<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      indent="yes"/>

  <xsl:template match="/presentation">
    <xsl:apply-templates select="slides/slide"/>
  </xsl:template>

  <xsl:template match="//slide">
    <xsl:result-document method="xml" href="file_{@id}-output.xhtml">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
	  <title> Presentation </title>
	</head>
	<body>
	  <xsl:apply-templates select="title" />

	  <xsl:apply-templates select="itemize" />
	  <xsl:apply-templates select="picture" />

	  <hr />
	<div>
	  <!-- if @id != first -->
	  <a href="file_{@id - 1}-output.xhtml">
	    <button>previouse</button>
	  </a>
	  <!-- endif -->

	  <!-- if @id != last -->
	  <a href="file_{@id + 1}-output.xhtml" style="float: right">
	    <button>next</button>
	  </a>
	  <!-- endif -->
	</div>
	
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

<xsl:template match="title">
  <div xmlns="http://www.w3.org/1999/xhtml">
    <h1>
      <xsl:value-of select="." />
    </h1>
  </div>
</xsl:template>

<xsl:template match="itemize">
  <div xmlns="http://www.w3.org/1999/xhtml">
    <ul >
      <xsl:for-each select="item">
	<li>
	  <xsl:value-of select="." />
	</li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>

<xsl:template match="picture">
  <div xmlns="http://www.w3.org/1999/xhtml" style="width: 600px; margin: 0 auto">
    <img src="{@href}" style="width: 100%"/>
  </div>
</xsl:template>

</xsl:stylesheet>
