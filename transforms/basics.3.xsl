<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />

  <xsl:template match="*">

    <xsl:for-each select="@*">
      <xsl:if test=". != ''">
	ATT:<xsl:value-of select="name(.)" />=<xsl:value-of select="." />
      </xsl:if>
    </xsl:for-each>
    
    <xsl:apply-templates select="*"/>
  </xsl:template>

</xsl:stylesheet>

