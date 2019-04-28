SAXON_DIR=$(HOME)/bin/saxon9he.jar
SAXON_TRANS=java -classpath $(SAXON_DIR) net.sf.saxon.Transform

FOP_CONF=config/fop.xconf
FOP=fop -c $(FOP_CONF)

XML_LINT=xmllint --noout --relaxng

xhtml:
	$(XML_LINT) schemas/base.rng base.xml
	$(SAXON_TRANS) -t -s:base.xml -xsl:transforms/base-to-xhtml.xsl -o:outputs/output.xhtml
pdf:
	$(XML_LINT) schemas/base.rng base.xml
	$(SAXON_TRANS) -t -s:base.xml -xsl:transforms/base-to-xmlfo.xsl -o:outputs/xmlfo.xml
	$(FOP) outputs/xmlfo.xml outputs/presentation.pdf
	rm outputs/xmlfo.xml
