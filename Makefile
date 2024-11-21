### DEFINITIONS ###
# Root LaTeX file
SRC=thesis.tex

# Output PDF file #
PDF=thesis.pdf

# pdflatex build logs #
LOG=$(subst .pdf,.log,$(PDF))

# pdflatex temp files #
AUX=$(subst .pdf,.aux,$(PDF))
LOF=$(subst .pdf,.lof,$(PDF))
LOT=$(subst .pdf,.lot,$(PDF))
OUT=$(subst .pdf,.out,$(PDF))
TOC=$(subst .pdf,.toc,$(PDF))
SYN=$(subst .pdf,.pdfsync,$(PDF))
TMP=$(AUX) $(LOF) $(LOG) $(LOT) $(OUT) $(SYN) $(TOC)

# Spellcheck backup files #
BAK=$(wildcard *.bak)


### TARGETS ###
all: $(PDF)

# Build PDF #
$(PDF): $(SRC)
	pdflatex --halt-on-error --jobname $(basename $(PDF)) $(SRC)

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
	rm -f $(TMP)
