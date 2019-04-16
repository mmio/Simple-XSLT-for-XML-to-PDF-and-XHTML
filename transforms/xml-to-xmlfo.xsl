<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/school">

    <fo:root>
      <fo:layout-master-set>
	<fo:simple-page-master master-name="A4-landscape"
			       page-width="297mm" page-height="210mm"
			       margin-top="1cm"   margin-bottom="1cm"
			       margin-left="1cm"  margin-right="1cm">
	  <fo:region-body   margin="3cm"/>
	  <fo:region-before extent="2cm"/>
	  <fo:region-after  extent="2cm"/>
	  <fo:region-start  extent="2cm"/>
	  <fo:region-end    extent="2cm"/>
	</fo:simple-page-master>
      </fo:layout-master-set>

      <xsl:for-each select="*">
	<fo:page-sequence master-reference="A4-landscape">
	  <fo:flow flow-name="xsl-region-body"> <!--Flow-name where it will be shown.-->
	    <xsl:element name="fo:block">
	      <xsl:attribute name="font-family">Ubuntu</xsl:attribute>
	      <xsl:attribute name="text-align">center</xsl:attribute>
	      <xsl:attribute name="font-size">32pt</xsl:attribute>
	      <xsl:value-of select="name(.)" />
	    </xsl:element>
	    
	    <xsl:apply-templates />
	  </fo:flow>
	</fo:page-sequence>
	
      </xsl:for-each>
      
    </fo:root>
    
  </xsl:template>

  <xsl:template match="student">
    <xsl:element name="fo:block">
      <xsl:attribute name="font-family">Ubuntu</xsl:attribute>
      
      <xsl:attribute name="font-size">22pt</xsl:attribute>
      
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>

  <xsl:template match="teacher">
    <xsl:element name="fo:block">
      <xsl:attribute name="font-family">Ubuntu</xsl:attribute>
      
      <xsl:attribute name="font-size">22pt</xsl:attribute>
      
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
