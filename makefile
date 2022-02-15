COMPILER = ocamlopt
EXT = .cmx
AEXT = .cmxa

CUSTOM_LIBRARY_LOCATION = lib
STANDARD_FLAGS = -nopervasives -O3
COMPILE = $(COMPILER) $(STANDARD_FLAGS) -I $(CUSTOM_LIBRARY_LOCATION) -c

build:
	$(COMPILER) -I $(CUSTOM_LIBRARY_LOCATION) library$(AEXT) -o program

mostlyclean:
	rm -f *.o *.a *.s *.cmi *.cmx *.cmxa *.cmo *.cma

clean:
	rm -f *.o *.a *.s *.so *.cmi *.cmx *.cmxa *.cmo *.cma program

make install:
	make build
	make mostlyclean

run:
	./program