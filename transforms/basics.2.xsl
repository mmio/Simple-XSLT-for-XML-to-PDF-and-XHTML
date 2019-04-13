<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />
  <xsl:template match="*">
    <xsl:element name="div">
      <xsl:attribute name="elementName">
	<xsl:value-of select="name(.)" />
      </xsl:attribute>
      <xsl:value-of select="text()" />
      <xsl:apply-templates select="*"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>

