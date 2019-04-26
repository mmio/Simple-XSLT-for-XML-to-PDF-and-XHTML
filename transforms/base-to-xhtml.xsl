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
    <xsl:result-document method="xml" href="file_{position() - 1}-output.xhtml">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
	  <title> Presentation </title>
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
	</head>
	<body>
	  <div class="container">
	    <div class="mt-4">

	      <!-- Navigation -->
	      <xsl:if test="not(position()=1)">
		<a href="file_{position() - 2}-output.xhtml">
		  <button class="btn">
		    previouse
		  </button>
		</a>
	      </xsl:if>
	      <xsl:if test="position() = 1">
		<a href="file_{position() - 2}-output.xhtml">
		  <button class="btn" disabled="true">
		    previouse
		  </button>
		</a>
	      </xsl:if>

	      <xsl:if test="not(position()=last())">
		<a href="file_{position()}-output.xhtml" class="float-right">
		  <button class="btn">
		    next
		  </button>
		</a>
	      </xsl:if>
	      <xsl:if test="position() = last()">
		<a href="file_{position()}-output.xhtml" class="float-right">
		  <button class="btn" disabled="true">
		    next 
		  </button>
		</a>
	      </xsl:if>

	      <hr />
	    </div>

	    <!-- Content -->
	    <div style="min-height: 400px;">
	      <xsl:apply-templates />
	    </div>

	    <hr />

	    <!-- Meta data -->
	    Page <xsl:value-of select="position()" /> of <xsl:value-of select="last()" />
	    <xsl:apply-templates select="/presentation/meta/date" />
	    <xsl:apply-templates select="/presentation/meta/author" />
	  </div>
	</body>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="/presentation/meta/date">
    <div xmlns="http://www.w3.org/1999/xhtml">
      Date: <xsl:value-of select="." />
    </div>
    <br />
  </xsl:template>

  <xsl:template match="/presentation/meta/author">
    <div xmlns="http://www.w3.org/1999/xhtml">
      Author: <xsl:value-of select="." />
    </div>
    <br />
  </xsl:template>

  <xsl:template match="title">
    <div xmlns="http://www.w3.org/1999/xhtml">
      <xsl:if test="../@type = 'title'">
	<h1 class="text-center" style="padding-top: 16%;">
	  <xsl:value-of select="." />
	</h1>
      </xsl:if>
      <xsl:if test="../@type != 'title'">
	<h1>
	  <xsl:value-of select="." />
	</h1>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="itemize">
    <div xmlns="http://www.w3.org/1999/xhtml">
      <ul>
	<xsl:for-each select="item">
	  <li>
	    <xsl:value-of select="." />
	    <xsl:apply-templates />
	  </li>
	</xsl:for-each>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="picture">
    <div xmlns="http://www.w3.org/1999/xhtml">
      <img src="{@href}" style="width: 100%;"/>
    </div>
  </xsl:template>

  <xsl:template match="multicol">
    <div xmlns="http://www.w3.org/1999/xhtml">
      <div style="width: 49%; display: inline-block;">
	<xsl:apply-templates select="itemize"/>
      </div>
      <div style="width: 49%; float: right; display: inline-block;">
	<xsl:apply-templates select="picture"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="bold">
    <b xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="." />
    </b>
  </xsl:template>

  <xsl:template match="underline">
    <u xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="." />
    </u>
  </xsl:template>

  <xsl:template match="italics">
    <i xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="." />
    </i>
  </xsl:template>

</xsl:stylesheet>

<!-- Video -->
<!-- html canvas -->
<!-- double column, horizontal vertical -->
<!-- multichoice presentation -->
<!-- mixed text picture-->
