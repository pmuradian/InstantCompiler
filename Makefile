all:
	happy -gca ./src/ParInstant.y
	alex -g ./src/LexInstant.x
	ghc --make -isrc ./src/InstantLLVM.hs -o insc_llvm
	ghc --make -isrc ./src/InstantJVM.hs -o insc_jvm

clean:
	-rm -f src/*.log src/*.aux src/*.hi src/*.o src/*.dvi .hs

cleanexec:
	-rm -f insc_jvm insc_llvm

cleanoutput:
	-rm -f *.bc *.j *.ll *.class

cleanall: clean
	-rm -f insc_jvm insc_llvm

distclean: clean
	-rm -f DocInstant.* LexInstant.* ParInstant.* LayoutInstant.* SkelInstant.* SkelLLVMInstant.* PrintInstant.* TestInstant.* AbsInstant.* TestInstant ErrM.* SharedString.* ComposOp.* Instant.dtd XMLInstant.* Makefile*
	
test: all
	./insc_jvm ~/Downloads/instant161024/examples/test07.ins
	./insc_llvm ~/Downloads/instant161024/examples/test07.ins