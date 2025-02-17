### DEFINITIONS ###
# Root LaTeX file
NAME=thesis
ROOT=$(NAME).tex
SRC=$(wildcard *.tex)

# Output PDF file #
PDF=$(NAME).pdf

# pdflatex build logs #
LOG=$(subst .pdf,.log,$(PDF))

# pdflatex temp files #
AUX=$(subst .pdf,.aux,$(PDF))
LOF=$(subst .pdf,.lof,$(PDF))
LOT=$(subst .pdf,.lot,$(PDF))
OUT=$(subst .pdf,.out,$(PDF))
TOC=$(subst .pdf,.toc,$(PDF))
SYN=$(subst .pdf,.pdfsync,$(PDF))
# bibtex temp files
BBL=$(subst .pdf,.bbl,$(PDF))
BCF=$(subst .pdf,.bcf,$(PDF))
BLG=$(subst .pdf,.blg,$(PDF))
TMP=$(AUX) $(LOF) $(LOG) $(LOT) $(OUT) $(SYN) $(TOC) $(BBL) $(BCF) $(BLG)

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
	find . -type f -name '*.tex' -exec \
		aspell --extra-dicts ./local-dict.pws check -t {} \
	\;

# List mispelled words #
list:
	@find . -type f -name '*.tex' -exec cat {} \; \
	| aspell --extra-dicts ./local-dict.pws list -t \
	| sort -u

# Remove all output files #
clean: clean-tmp
	rm -f $(PDF)

# Remove temporary files #
clean-tmp:
	rm -f $(TMP) comment.cut
