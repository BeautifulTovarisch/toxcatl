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
$(MODULES) : % : .depend %.cmi %.cma

.PHONY: install
install:
	-ocamlfind remove $(LIB)
	ocamlfind install $(LIB) META *.cmi *.a

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

%.cma : %.ml
	$(OCAMLOPT) $(OCAMLFLAGS) -a $< -o $*

.depend:
	ocamldep *.ml *.mli > .depend

include .depend

clean:
	-rm $(MODULES)
	rm -f *.a *.o *.cm[iox]
