### DEFINITIONS ###
# Root LaTeX file
NAME=thesis
ROOT=$(NAME).tex
SRC=$(wildcard *.tex)

# Output PDF file #
PDF=$(NAME).pdf

# pdflatex build logs #
LOG=$(subst .tex,.log,$(SRC))

# pdflatex temp files #
AUX=$(subst .tex,.aux,$(SRC))
LOF=$(subst .tex,.lof,$(SRC))
LOT=$(subst .tex,.lot,$(SRC))
OUT=$(subst .pdf,.out,$(PDF))
TOC=$(subst .tex,.toc,$(SRC))
SYN=$(subst .pdf,.pdfsync,$(PDF))

# biblatex temp files #
BBL=$(subst .tex,.bbl,$(SRC))
BCF=$(subst .tex,.bcf,$(SRC))
BLG=$(subst .tex,.blg,$(SRC))

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
	bibtex $(NAME)
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
