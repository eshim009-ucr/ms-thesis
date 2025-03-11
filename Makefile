VERSIONS=acm ucr

.PHONY: acm ucr
all: $(VERSIONS)

$(VERSIONS):
	cd $@ && $(MAKE)
