# OCaml Standard Library

This repository contains my custom OCaml standard library and build system.

## Disclaimer:

This is very bespoke for my requirements, and only something I use when writing code to be read and used by myself. In general, I do not recommend doing something like this. This repository exists because it shows off how one can effectively compile an OCaml project without the standard library but still expose the few functions they may need, a task made remarkably difficult by the way the compiler works, and because my implementations of some data structures and algorithms may be useful to people new to functional programming.

Also note that I use WSL for all OCaml programming, and this is my recommendation for Windows users. The only software dependencies for running and debugging code in this project are the OCaml compiler and make.

## Modules

This library includes the following custom modules:

- Bool (for basic operations on booleans)
- Char (for basic operations on characters)
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

## Exposure of Functions from Standard Library

With respect to the exposed parts of the standard library, these are all handled in the `FromStdlib` module, which redefines some definitions directly from the standard library so that this file can be safely included separately, exposing only the desired functions. As such, it is recommended that this file is opened in the code that uses this library, while others are not, and referenced from the module level instead (with one additional exception of `Exposed`, mentioned in the following section).

All files are compiled with `-nopervasives` except `FromStdlib` (to avoid the headaches in exposing functions like `printf` which have many dependencies). Linking is also done without `-nopervasives` so that `fromStdlib.cmx` can find the corresponding functions.

Some functions exist in the `FromStdlib` module which have names starting with `stdlib`. These functions can be called directly, but it is generally recommended they are called from the corresponding module in the custom standard library. They exist in `FromStdlib` to be exposed more neatly elsewhere.

## Type Declarations and General Functions

In order to prevent duplicate definitions of common types like collections, but still allow things like list literals to work, and to prevent the need of a type annotation at the module level, a `Exposed` module is provided to be opened in code files which exposes types like `'a queue` and other collections. `Exposed` also includes generic operators that should be opened file wide, such as function composition (`>>`). This should always be opened at the top of project files.

## Compiler Options

I typically compile everything with the `-O3` flag for flambda optimization, and this can obviously be changed depending on requirements, as can the use of `ocamlopt` instead of `ocamlc` but if that is changed the final linking will need to be done with `.cmo` instead of `.cmx` files.

## Building the Standard Library

Within the `lib` folder a makefile is included so that the standard library can be built using `make build`. This will generate a file called `library.cmxa` which can then be used in projects as described in the next section. In general, build the library once and do not clean it before creating a larger project.

## Creating a Project Using This Library

In the root folder of this repository, a makefile is provided to be used for projects that make use of this standard library.

To create a new project, simply create the file you wish to add in the top level. For example, let's say we are creating a file called `main.ml`.

We first create the file in the root directory, and then change the build section of makefile from this:

```
build:
	ocamlopt $(CUSTOM_LIBRARY_LOCATION)/library.cmxa -o program
```

to this:

```
build:
    $(COMPILE) main.ml

	ocamlopt $(CUSTOM_LIBRARY_LOCATION)/library.cmxa main.cmx -o program
```

Any additional files that need to be added can be added in the same way, by adding the line to compile and adding the `.cmx` file to the final step.

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

Then the final step within `build` also needs to be altered to include the corresponding `.cmx` file.

```
ocamlopt -a fromStdlib.cmx exposed.cmx int.cmx float.cmx option.cmx stack.cmx list.cmx map.cmx queue.cmx set.cmx tree.cmx string.cmx newModule.cmx -o $(LIB_NAME).cmxa
```

Just as with the project in the top level, file order should be consistent across compile lines and this final line.

## The Core Library

One of the unfortunate consequences of the way OCaml's compilation works, is that there is a library called the core library (not to be confused with Jane Street's Core), documented [here](https://ocaml.org/manual/core.html), which contains some definitions for types and exceptions, yet does not include the code from the stdlib that uses them. When compiling with the `-nopervasives` flag, this is still included but without the standard library. While this makes sense from the perspective of having some fundamental exceptions always available, having types like `list` included makes it very annoying when implemented a custom standard library. This quirk is why my library has no type definition for `list`, `bool`, `option`, etc. but still uses these types.

## Planned Changes

The following modules are some that I plan on introducing in future iterations of this project:

- Array: for operations with mutable arrays.
- Random: for random number generation.
- File: for file IO.
- Input: for command line inputs and arguments.

## Tests

Unit tests are also planned for all collection modules, but have not been written yet.