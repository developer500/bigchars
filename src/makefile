
targetnm = bigchars
outfold = ../build

$(outfold)/$(targetnm).P: $(targetnm).asm *.asm
	z80asm +zx81 -O$(outfold) $^

$(targetnm).asm: $(targetnm).asm.m4
	m4 $< > $@

.PHONY: clean
clean:
	rm -f $(outfold)/*.o $(outfold)/*.bin $(outfold)/*.P $(outfold)/*.err $(targetnm).asm
