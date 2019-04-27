<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
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
			       margin-top="1cm">   <!-- margin-bottom="1cm" -->
	  <!-- margin-left="1cm"  margin-right="1cm"> -->

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
	    <fo:block text-align="center" font-family="{$pdf-title-font-face}" font-size="{$pdf-title-font-size}">
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
	      <fo:block padding-top="50mm" font-family="{$pdf-title-name-font-face}" font-size="{$pdf-title-name-font-size}" text-align="center" span="all">
	      	<xsl:apply-templates select="/presentation/meta/author" />
	      </fo:block>
	      <fo:block font-family="{$pdf-title-date-font-face}" font-size="{$pdf-title-date-font-size}" text-align="center" span="all">
		<xsl:apply-templates select="/presentation/meta/date" />
	      </fo:block>
	    </xsl:if>

	    <xsl:apply-templates />
	  </fo:flow>
	</fo:page-sequence>
      </xsl:for-each>
    </fo:root>
  </xsl:template>
  <xsl:template match="itemize">
    <fo:block span="all">
      <fo:list-block font-family="{$pdf-item-font-face}" font-size="{$pdf-item-font-size}">
	<xsl:for-each select="item">
    	  <fo:list-item>
    	    <fo:list-item-label>
    	      <fo:block>
    		*
    	      </fo:block>
    	    </fo:list-item-label>
    	    <fo:list-item-body start-indent="22pt">
    	      <fo:block>
    		<!-- <xsl:value-of select="." /> -->
		<xsl:apply-templates />
    	      </fo:block>
    	    </fo:list-item-body>
    	  </fo:list-item>
	</xsl:for-each>
      </fo:list-block>
    </fo:block>
  </xsl:template>
  <xsl:template match="multicol/itemize">
    <fo:list-block font-family="{$pdf-item-font-face}" font-size="{$pdf-item-font-size}">
      <xsl:for-each select="item">
    	<fo:list-item>
    	  <fo:list-item-label>
    	    <fo:block>
    	      *
    	    </fo:block>
    	  </fo:list-item-label>
    	  <fo:list-item-body start-indent="22pt">
    	    <fo:block>
    	      <xsl:apply-templates />
<!-- <xsl:value-of select="." /> -->
    	    </fo:block>
    	  </fo:list-item-body>
    	</fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>
  <xsl:template match="picture">
    <fo:block-container width="257mm" height="200mm">
      <fo:block text-align="center" span="all">
	<fo:external-graphic width="257mm" height="auto" content-width="scale-to-fit" src="{@href}"/>
	<fo:block>
	  <xsl:value-of select="@caption" />
	</fo:block>
      </fo:block>
    </fo:block-container>
  </xsl:template>
  <xsl:template match="multicol/picture">
    <fo:block-container width="120mm" height="200mm">
    <fo:block text-align="center">
      <fo:external-graphic width="120mm" height="auto" content-width="scale-to-fit" src="{@href}"/>
      <fo:block>
	<xsl:value-of select="@caption" />
      </fo:block>
    </fo:block>
    </fo:block-container>
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

