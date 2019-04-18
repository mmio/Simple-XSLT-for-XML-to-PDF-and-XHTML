<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      indent="yes"/>
  
  <xsl:template match="/presentation">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
      <head>
	<title> Presentation </title>
      </head>
      <body>
	<xsl:apply-templates select="slides"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="slides">
    <h2>Slides</h2>
    <xsl:apply-templates select="slide"/>
  </xsl:template>

  <xsl:template match="slide">
    <xsl:result-document method="xml" href="file_{@type}-output.xml">
      <h2>A slide</h2>
    </xsl:result-document>
  </xsl:template>

</xsl:stylesheet>
