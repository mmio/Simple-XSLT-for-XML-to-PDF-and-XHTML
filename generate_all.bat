set SAXON=c:\docbook\SaxonHE9-9-1-1J
set FOP=c:\docbook\fop2\

@echo off

echo Generating xhtml files
java -cp %SAXON%\saxon9he.jar net.sf.saxon.Transform -t -s:base.xml -xsl:transforms\base-to-xhtml.xsl -o:outputs\output.xhtml
pause

echo Generating xmlfo file
java -cp %SAXON%\saxon9he.jar net.sf.saxon.Transform -t -s:base.xml -xsl:transforms\base-to-xmlfo.xsl -o:outputs\xmlfo.xml
pause

echo Generating pdf file
call %FOP%\fop.bat -c config\fop.xconf -fo outputs\xmlfo.xml -pdf outputs\output.pdf
pause