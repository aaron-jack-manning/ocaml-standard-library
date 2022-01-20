CUSTOM_LIBRARY_LOCATION = lib
COMPILE = ocamlopt -O3 -nopervasives -I $(CUSTOM_LIBRARY_LOCATION) -c

build:
	ocamlopt $(CUSTOM_LIBRARY_LOCATION)/library.cmxa -o program

mostlyclean:
	rm -f *.o *.a *.s *.cmi *.cmx *.cmxa *.cmo *.cma main.mli

clean:
	rm -f *.o *.a *.s *.cmi *.cmx *.cmxa *.cmo *.cma main.mli program

make install:
	make build
	make mostlyclean

run:
	./program