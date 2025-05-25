### DEFINITIONS ###
# Root LaTeX file
NAME=thesis
ROOT=$(NAME).tex
SRC=$(wildcard *.tex) $(wildcard */*.tex)

# Output PDF file #
PDF=$(NAME).pdf

# pdflatex temp files #
AUX=$(subst .pdf,.aux,$(PDF))
LOF=$(subst .pdf,.lof,$(PDF))
LOT=$(subst .pdf,.lot,$(PDF))
OUT=$(subst .pdf,.out,$(PDF))
TOC=$(subst .pdf,.toc,$(PDF))
TMP_PDF=$(AUX) $(LOF) $(LOG) $(LOT) $(OUT) $(TOC) comment.cut

# biblatex
BBL=$(subst .pdf,.bbl,$(PDF))
BCF=$(subst .pdf,.bcf,$(PDF))
BLG=$(subst .pdf,.blg,$(PDF))
TMP_BIB=$(BBL) $(BCF) $(BLG)

# latexmk temp files
FDB=$(subst .pdf,.fdb_latexmk,$(PDF))
FLS=$(subst .pdf,.fls,$(PDF))
SYN=$(subst .pdf,.pdfsync,$(PDF))
RUN=$(subst .pdf,.run.xml,$(PDF))
TMP_LMK=$(FDB) $(FLS) $(SYN) $(RUN)

TMP=$(TMP_PDF) $(TMP_BIB) $(TMP_LMK)

# Spellcheck backup files #
BAK=$(wildcard *.bak)


### TARGETS ###
all: $(PDF)

# Build PDF #
$(PDF): $(SRC)
	pdflatex --halt-on-error --jobname $(NAME) $(NAME)

# Regenerate citations
cite:
	pdflatex --halt-on-error --jobname $(NAME) $(NAME)
	biber $(NAME)
	pdflatex --halt-on-error --jobname $(NAME) $(NAME)
	pdflatex --halt-on-error --jobname $(NAME) $(NAME)

# Spellcheck source files #
check:
	find . -type f -maxdepth 1 -name '*.tex' -exec \
		aspell --extra-dicts ./local-dict.pws check -t {} \
	\;

# List mispelled words #
list:
	@find . -type f -maxdepth 1 -name '*.tex' -exec cat {} \; \
	| aspell --extra-dicts ./local-dict.pws list -t \
	| sort -u

# Remove all output files #
clean: clean-tmp
	rm -f $(PDF)

# Remove temporary files #
clean-tmp:
	rm -f $(TMP) comment.cut
