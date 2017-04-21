DOCNAME = dm_stack_releases

# Version information extracted from git.
GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ai)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

$(DOCNAME)-$(GITVERSION)$(GITDIRTY).pdf: $(DOCNAME).tex meta.tex
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)

.FORCE:

meta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\vcsrevision}{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\newcommand{\vcsdate}{$(GITDATE)}' >>$@
