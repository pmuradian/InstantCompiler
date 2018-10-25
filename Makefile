all:
	happy -gca ParInstant.y
	alex -g LexInstant.x
	ghc --make TestInstant.hs -o TestInstant

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocInstant.* LexInstant.* ParInstant.* LayoutInstant.* SkelInstant.* PrintInstant.* TestInstant.* AbsInstant.* TestInstant ErrM.* SharedString.* ComposOp.* Instant.dtd XMLInstant.* Makefile*
	
test: all
	./TestInstant < ~/Downloads/instant161024/examples/test06.ins