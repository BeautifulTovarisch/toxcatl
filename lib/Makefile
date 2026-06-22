OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep
OCAMLFIND=ocamlfind
INCLUDES=-I +unix
OCAMLFLAGS=$(INCLUDES)
OCAMLOPTFLAGS=$(INCLUDES)

LIB=toxcatl

SRC := $(filter-out %_test.ml, $(wildcard *.ml))

MODULES := $(SRC:.ml=)

TESTSRC := $(wildcard *_test.ml)
TESTS := $(addprefix test, $(TESTSRC:_test.ml=))

.DELETE_ON_ERROR:

.PHONY: all
all : $(MODULES)

.PHONY: $(MODULES)
$(MODULES) : % : .depend %.cmi %.cmxa

.PHONY: install
install:
	-ocamlfind remove $(LIB)
	ocamlfind install $(LIB) META *.mli *.cmi *.cmx *.cmxa *.a

# make test<ModuleName>
.PHONY: $(TESTS)
$(TESTS) : % :
	$(OCAMLOPT) $(OCAMLFLAGS) -o $@ \
		$(subst test,, $@).mli \
		$(subst test,, $@).ml \
		$(subst test,, $@)_test.ml \

	./$@
	-rm $@
	$(MAKE) clean

%.cmi : %.mli
	$(OCAMLOPT) $(OCAMLFLAGS) -c $<

%.cmx : %.ml
	$(OCAMLOPT) $(OCAMLFLAGS) -c $<

%.cmxa : %.cmx
	$(OCAMLOPT) $(OCAMLFLAGS) -a -o $*.cmxa $<

.depend:
	ocamldep *.ml *.mli > .depend

include .depend

clean:
	rm -f *.a *.o *.cm[iox] *.cmxa
