<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">
  <xsl:import href="params.xsl"/>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/presentation/slides" />
  </xsl:template>
  
  <xsl:template match="/presentation/slides">
    <fo:root>
      <fo:layout-master-set>
	<fo:simple-page-master master-name="A4-landscape"
			       page-width="297mm" page-height="210mm"
			       margin-top="2cm">
	  <fo:region-body   margin="3.2cm" column-count="2"/>
	  <fo:region-before extent="2cm"/>
	  <fo:region-after  extent="2cm"/>
	  <fo:region-start  extent="2cm"/>
	  <fo:region-end    extent="2cm"/>
	</fo:simple-page-master>
      </fo:layout-master-set>
      <!-- Individual slide -->
      <xsl:for-each select="*">
	<fo:page-sequence master-reference="A4-landscape">
	  <!-- Header -->
	  <fo:static-content flow-name="xsl-region-before">
	    <fo:block text-align="center"
		      font-family="{$pdf-title-font-face}"
		      font-size="{$pdf-title-font-size}">
	      <xsl:value-of select="title" />
	    </fo:block>
	  </fo:static-content>
	  <!-- Footer -->
	  <fo:static-content flow-name="xsl-region-after">
	    <fo:block font-family="{$pdf-footer-font-face}" font-size="{$pdf-footer-font-size}">
	      Page <xsl:value-of select="position()" /> of <xsl:value-of select="last()" />
	    </fo:block>
	  </fo:static-content>
	  <!-- Body -->
	  <fo:flow flow-name="xsl-region-body">
	    <xsl:if test="@type = 'title'">
	      <fo:block padding-top="50mm"
			font-family="{$pdf-title-name-font-face}"
			font-size="{$pdf-title-name-font-size}"
			text-align="center" span="all">
	      	<xsl:apply-templates select="/presentation/meta/author" />
	      </fo:block>
	      <fo:block font-family="{$pdf-title-date-font-face}"
			font-size="{$pdf-title-date-font-size}"
			text-align="center" span="all">
		<xsl:apply-templates select="/presentation/meta/date" />
	      </fo:block>
	    </xsl:if>
	    <xsl:apply-templates />
	  </fo:flow>
	</fo:page-sequence>
      </xsl:for-each>
    </fo:root>
  </xsl:template>

  <xsl:template match="itemize" name="itemize">
    <fo:block span="all" line-height="1.5">
      <fo:list-block font-family="{$pdf-item-font-face}" font-size="{$pdf-item-font-size}">
	<xsl:apply-templates>
	  <xsl:with-param name="indent" select = "'22pt'" />
	  <xsl:with-param name="leading-tag" select = "'*'" />
	</xsl:apply-templates>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <xsl:template match="item">
    <xsl:param name = "indent" />
    <xsl:param name = "leading-tag" />

    <fo:list-item start-indent="{$indent}">
      <fo:list-item-label>
    	<fo:block>
	  <xsl:value-of select="$leading-tag" />
    	</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="{$indent} + 15pt">
    	<fo:block>
	  <xsl:apply-templates />
    	</fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="itemize/itemize">
    <xsl:apply-templates>
      <xsl:with-param name="indent" select = "'44pt'" />
      <xsl:with-param name="leading-tag" select = "'-'" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="multicol">
    <fo:block span="none">
	<xsl:apply-templates select="itemize[1]"/>
	<xsl:apply-templates select="picture[2]"/>
    </fo:block>
    <fo:block span="none">
      <xsl:apply-templates select="picture[1]"/>
      <xsl:apply-templates select="itemize[2]"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="basic-picture">
    <xsl:param name = "width" />
    <xsl:param name = "height" />
    <xsl:param name = "span" />
    
    <fo:block-container width="{$width}" height="{$height}" span="{$span}">
      <fo:block text-align="center">
	<fo:block
	    border-style="solid" 
	    border-width="1px" 
	    border-color="gray" 
	    fox:border-radius="3px">
	  <fo:external-graphic text-align="center"
			       width="{$width}"
			       height="auto"
			       content-width="scale-to-fit"
			       src="{@href}"/>
	</fo:block>
	<fo:block>
	  <xsl:value-of select="@caption" />
	</fo:block>
      </fo:block>
    </fo:block-container>
  </xsl:template>
  
  <xsl:template match="picture">
    <xsl:call-template name="basic-picture">
      <xsl:with-param name="width" select = "'227mm'" />
      <xsl:with-param name="height" select = "'180mm'" />
      <xsl:with-param name="span" select = "'all'" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="multicol/picture">
    <xsl:call-template name="basic-picture">
      <xsl:with-param name="width" select = "'110mm'" />
      <xsl:with-param name="height" select = "'200mm'" />
      <xsl:with-param name="span" select = "'none'" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="bold">
    <fo:inline font-weight="bold">
      <xsl:value-of select="." />
    </fo:inline>
  </xsl:template>

  <xsl:template match="underline">
    <fo:inline text-decoration="underline">
      <xsl:value-of select="." />
    </fo:inline>
  </xsl:template>

  <xsl:template match="italics">
    <fo:inline font-style="italic">
      <xsl:value-of select="." />
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>

