STDLIB_FILES = lib/fromStdlib.cmx lib/exposed.cmx lib/int.cmx lib/float.cmx lib/option.cmx lib/stack.cmx lib/list.cmx lib/map.cmx lib/queue.cmx lib/set.cmx lib/tree.cmx lib/string.cmx

GENERATE_MLI = ocamlopt -i -I lib
COMPILE = ocamlopt -O3 -nopervasives -I lib -c

build:
	# compile the standard library by using the internal makefile
	cd lib; make compile

	# main is the main file to run code in
	$(GENERATE_MLI) main.ml > main.mli
	$(COMPILE) main.mli main.ml

	# after all files are individually compiled with -nopervasives, this is compiled with it so that fromStdlib has the necessary linking
	ocamlopt -O3 $(STDLIB_FILES) main.cmx -o program

topmostlyclean:
	rm -f *.o *.a *.s *.cmi *.cmx *.cmxa *.cmo *.cma main.mli

topclean:
	rm -f *.o *.a *.s *.cmi *.cmx *.cmxa *.cmo *.cma main.mli program

stdlibclean:
	cd lib; make clean

clean:
	make topclean
	make stdlibclean

mostlyclean:
	make topmostlyclean
	make stdlibclean

run:
	./program