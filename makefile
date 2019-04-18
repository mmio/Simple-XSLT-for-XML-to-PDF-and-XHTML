# Executable directories
SAXON_DIR=$(HOME)/bin/saxon9he.jar
SAXON_TRANS=java -classpath $(SAXON_DIR) net.sf.saxon.Transform

FOP_CONF=config/fop.xconf
FOP=fop -c $(FOP_CONF)

XEP=$(HOME)/bin/XEP/xep

XML_LINT=xmllint --valid --noout --relaxng $(RNG) $(XML)

PDF_VIEWER=zathura

# Default variables
TRN_DIR=transforms
OUT_DIR=outputs
EX=2

XML=basics.xml
XSL=$(TRN_DIR)/basics.$(EX).xsl
X2X_OUT=$(OUT_DIR)/output.$(EX).html

FO=basics.fo
PDF_OUT=$(OUT_DIR)/output.pdf

# $(XEP) -fo $(FO) $(PDF_OUT)

fo2pdf: $(FO)
	$(FOP) $(FO) $(PDF_OUT)
	$(PDF_VIEWER) $(PDF_OUT)

xml2xml: $(X2X_OUT)
	cat $(X2X_OUT)

$(X2X_OUT): $(XML) $(XSL)
	$(SAXON_TRANS) -t -s:$(XML) -xsl:$(XSL) -o:$(X2X_OUT)

clear:
	rm outputs/*

list_fonts:
	fc-list | cut -d ':' -f2

xhtml:
	$(SAXON_TRANS) -t -s:base.xml -xsl:transforms/base-to-xhtml.xsl -o:outputs/output.xhtml
pdf:
	$(SAXON_TRANS) -t -s:base.xml -xsl:transforms/base-to-xmlfo.xsl -o:outputs/xmlfo.xml
	$(FOP) outputs/xmlfo.xml outputs/presentation.pdf
