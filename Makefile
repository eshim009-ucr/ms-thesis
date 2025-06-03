TARGETS=all clean cite

SUBDIRS=acm ucr

$(TARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

.PHONY: check
check:
	$(MAKE) -C common check
