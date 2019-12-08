VERSION := 1.0.0

CC      ?= cc
CFLAGS  ?=

EQN     := /usr/freeware/bin/geqn
TBL     := /usr/freeware/bin/tbl
NROFF   := /usr/freeware/bin/groff

PROJECT_ROOT := $(shell pwd)

# Public Target: package
#
# Alias for the tardist build
.PHONY: package
package: stree-$(VERSION).tardist

# Public Target: stree-$(VERSION).tardist
#
# The full complete build of the tardist file.
# gendist leaves around un-tarred files under
# dist/, this target tars them up
stree-$(VERSION).tardist: dist/stree 
	cd dist/ && tar cf ../$@ *

# Public Target: stree
#
# Build the main binary
stree: main.o
	$(CC) $^ -o $@ $(CFLAGS)


# Private Target: *.o
#
# How to compile down to .o from .c
%.o: %.c
	$(CC) -c $< $(CFLAGS)


# Private Target: $(PROJECT_ROOT)/dist
#
# Create the dist directory if needed. This is normally
# removed via clean.
$(PROJECT_ROOT)/dist:
	mkdir $@

# Private Target: dist/stree
#
# Create the dist from the spec, idb and build artifacts.
dist/stree: stree doc/stree.z $(PROJECT_ROOT)/dist
	/usr/sbin/gendist -sbase $(PROJECT_ROOT) -idb stree.idb -spec stree.spec -dist $(PROJECT_ROOT)/dist -all

# Private Target: doc/stree.z
#
# Preformat the manpage for installation on Irix that
# does not include troff.
doc/stree.z: doc/stree.1
	$(EQN) -Tascii doc/stree.1 | $(TBL) | $(NROFF) -man -Tascii > doc/stree
	pack -f doc/stree

# Public Target: clean
#
# Clean up after build and package.
clean:
	rm -rf dist/
	rm -f stree-$(VERSION).tardist doc/stree.z stree *.o
