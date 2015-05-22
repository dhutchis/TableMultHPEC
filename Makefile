# input file name.  This defines the name of the file you want to latex
# the make file will automatically look for INPUT.tex as the latex file
# and will look for a INPUT.bib file for the bibliography
INPUT=Graphulo_MatrixMultiply_HPEC2015
BIBFILE=10_bibliography

#commands 
TEX=latex
PDFTEX=pdflatex
LYX=lyx
BIBTEX=bibtex
DVIPS=dvips -t letter
PS2PDF=ps2pdf14 -dPDFSETTINGS=/prepress

#extensions
DVIEXT=.dvi
PSEXT=.ps
TEXEXT=.tex
BIBEXT=.bib
LYXEXT=.lyx
PDFEXT=.pdf

default: pdf

dvi: latex bibtex latex2

latex: 
	$(TEX) $(INPUT)$(TEXEXT)

latex2:
	$(TEX) $(INPUT)$(TEXEXT)
	$(TEX) $(INPUT)$(TEXEXT)

pdflatex: 
	$(PDFTEX) $(INPUT)$(TEXEXT)

pdflatex2:
	$(PDFTEX) $(INPUT)$(TEXEXT)
	$(PDFTEX) $(INPUT)$(TEXEXT)

bibtex: $(BIBFILE)$(BIBEXT) 
	$(BIBTEX) $(INPUT)

ps: dvi
	$(DVIPS) -o $(INPUT)$(PSEXT) $(INPUT)$(DVIEXT)

pspdf: ps
	$(PS2PDF) $(INPUT)$(PSEXT)

pdf: pdflatex bibtex pdflatex2

gentex:
	$(LYX) --export latex $(INPUT)-lyx$(LYXEXT)

viewdvi:
	kdvi $(INPUT)$(DVIEXT)

view: kpdf

kpdf:
	okular $(INPUT)$(PDFEXT)

clean:
	rm -f $(INPUT)$(PSEXT)
	rm -f $(INPUT)$(DVIEXT) 
	rm -f *.aux *.bbl *.blg *.log *.toc

cleaner: clean
	rm -f *~
	rm -f $(INPUT)$(PDFEXT)
