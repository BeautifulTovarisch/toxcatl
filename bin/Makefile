OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep
OCAMLFIND=ocamlfind
OCAMLFLAGS=$(INCLUDES)
OCAMLOPTFLAGS=$(INCLUDES)

DEPS=toxcatl

SRC := $(filter-out %_test.ml, $(wildcard *.ml))

MODULES := $(SRC:.ml=)

TESTSRC := $(wildcard *_test.ml)
TESTS := $(addprefix test, $(TESTSRC:_test.ml=))

.DELETE_ON_ERROR:

.PHONY: all
all : $(MODULES)

.PHONY: $(MODULES)
$(MODULES) : % : .depend %.cmx

%.cmi : %.mli
	$(OCAMLFIND) $(OCAMLOPT) -package $(DEPS) -linkpkg -c $<

%.cmx : %.ml
	$(OCAMLFIND) $(OCAMLOPT) -package $(DEPS) -linkpkg $< -o $*

.depend:
	ocamldep *.ml *.mli > .depend

include .depend

clean:
	-rm $(MODULES)
	rm -f *.a *.o *.cm[iox]
