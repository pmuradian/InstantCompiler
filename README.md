Compiler for a small inperative language called "Instant"

--- directories and files ---
root direcotory contains:
Makefile - used to compile and run the project
Instant.cf - bnfc grammer file
res/ - directory for resources, contains jasmin.jar file to generate .class files from jasmin output (*.j files).
src/ - source files are located here, contains custom and bnfc generated haskell files.

InstantJVM.hs and InstantLLVM.hs files are for creating jvm and llvm compilers respectively. 
SkelJVMInstant.hs and SkelLLVMInstant.hs files contain implementation of output code generation for jvm and llvm respectively.

--- compile and run ---
To run the program use Makefile command:
make - will create insc_jvm and insc_llvm executables in root directory
cleanall - will remove all created files after make command including executables insc_jvm and insc_llvm

Executing insc_jvm foo/bar/baz.ins for a correct program baz.ins will create files baz.j (Jasmin) and baz.class (JVM) in the directory foo/bar
Executing insc_llvm foo/bar/baz.ins for a correct program baz.ins should create files baz.ll (text LLVM) and baz.bc (lli-exectutable bitcode) in the directory foo/bar.