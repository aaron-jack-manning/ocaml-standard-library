# OCaml Standard Library

This repository contains my custom OCaml standard library and build system.

## Disclaimer:

This is very bespoke for my requirements, and only something I use when writing code to be read and used by myself. In general, I do not recommend doing something like this. This repository exists because it shows off how one can effectively compile an OCaml project without the standard library but still expose the few functions they may need, a task made remarkably difficult by the way the compiler works, and because my implementations of some data structures and algorithms may be useful to people new to functional programming.

Also note that I use WSL for all OCaml programming, and this is my recommendation for Windows users. The only software dependencies for running and debugging code in this project are the OCaml compiler, gcc and make.

## Modules

This library includes the following custom modules:

- Array (for operations on mutable arrays)
- Bool (for basic operations on booleans)
- Char (for basic operations on characters)
- Console (for console IO)
- Fatal (for throwing exceptions, and making assertions)
- File (for file IO)
- Float (for basic operations on floating point numbers)
- Int (for basic operations on integers)
- List (functional list data structure)
- Map (functional map implemented as a red-black tree)
- Option (functions for working with the option monad)
- Queue (functional queue implemented as two lists)
- Set (functional set implemented as a red-black tree)
- Stack (functional stack data structure)
- String (for basic operations on strings)
- Tree (functional generic tree type with some general functions to manipulate it)

## Type Declarations and General Functions

In order to prevent duplicate definitions of common types like collections, but still allow things like list literals to work, and to prevent the need of a type annotation at the module level, the `General` module is provided to be opened in code files which exposes types like `'a queue` and other collections. `General` also includes generic operators that should be opened file wide, such as function composition (`>>`). This should always be opened at the top of project files.

## Compiler Options

I typically compile everything with the `-O3` flag for flambda optimization, and this can obviously be changed depending on requirements, as can the use of `ocamlopt` instead of `ocamlc` but if that is changed the final linking will need to be done with `.cmo` instead of `.cmx` files.

## Building the Standard Library

Within the `lib` folder a makefile is included so that the standard library can be built using `make build`. This will generate a file called `library.cmxa` which can then be used in projects as described in the next section. In general, build the library once and do not clean it before creating a larger project.

## Creating a Project Using This Library

In the root folder of this repository, a makefile is provided to be used for projects that make use of this standard library.

To create a new project, simply create the file you wish to add in the top level. For example, let's say we are creating a file called `main.ml`.

We first create the file in the root directory, add the line `open General` to the top of the file, and then change the build section of makefile from this:

```
build:
	$(COMPILER) -I $(CUSTOM_LIBRARY_LOCATION) library$(AEXT) -o program
```

to this:

```
build:
	$(COMPILE) main.ml
	$(COMPILER) -I $(CUSTOM_LIBRARY_LOCATION) library$(AEXT) main$(EXT) -o program
```

Any additional files that need to be added can be added in the same way, by adding the line to compile and adding `filename$(EXT)` file to the final step.

If adding in other files, order them within both places according to the desired file order, and if adding an `.mli` file with the `.ml` file, simply compile with the `.mli` file as well, before the `.ml` file. For example:

```
$(COMPILE) main.mli main.ml
```

This leaves a project which can be built with `make build`, run with `make run` and cleaned with `make clean`. `make install` is also an implemented command which builds the project and cleans all except the executable.

## Adding New Modules to the Standard Library

All new files added to the library need an `.ml` and `.mli` file in the `lib` folder.

Once the files exist, the compilation step needs to be added to the `makefile` within `lib` by preceeding the `.mli` and `.ml` files with `$(STANDARD_COMPILE)`. For example:

```
$(STANDARD_COMPILE) newModule.mli newModule.ml
```

Then the `COMPILED_FILES` variable also needs to be altered to include the corresponding compiled files.

```
COMPILED_FILES = general$(EXT) fatal$(EXT) int$(EXT) float$(EXT) option$(EXT) stack$(EXT) list$(EXT) map$(EXT) queue$(EXT) set$(EXT) tree$(EXT) string$(EXT) char$(EXT) bool$(EXT) console$(EXT) file$(EXT) newModule$(EXT)
```

Just as with the project in the top level, file order should be consistent across compile lines and this final line.

## The Core Library

One of the unfortunate consequences of the way OCaml's compilation works, is that there is a library called the core library (not to be confused with Jane Street's Core), documented [here](https://ocaml.org/manual/core.html), which contains some definitions for types and exceptions, yet does not include the code from the stdlib that uses them. When compiling with the `-nopervasives` flag, this is still included but without the standard library. While this makes sense from the perspective of having some fundamental exceptions always available, having types like `list` included makes it very annoying when implemented a custom standard library (with the benefit of list literals still functioning properly). This quirk is why my library has no type definition for `list`, `bool`, `option`, etc. but still uses these types.

## Planned Changes

At some point I would like to remove all dependencies on the actual OCaml standard library. Currently the only dependencies that exist are some external C functions with the string and array modules.

Unit tests are also planned, but have not been written yet.