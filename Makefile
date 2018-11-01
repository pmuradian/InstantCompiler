all:
	happy -gca ParInstant.y
	alex -g LexInstant.x
	ghc --make InstantLLVM.hs -o insc_llvm
	ghc --make InstantJVM.hs -o insc_jvm

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocInstant.* LexInstant.* ParInstant.* LayoutInstant.* SkelInstant.* SkelLLVMInstant.* PrintInstant.* TestInstant.* AbsInstant.* TestInstant ErrM.* SharedString.* ComposOp.* Instant.dtd XMLInstant.* Makefile*
	
test: all
	./insc_jvm < ~/Downloads/instant161024/examples/test07.ins
	./insc_llvm < ~/Downloads/instant161024/examples/test07.ins