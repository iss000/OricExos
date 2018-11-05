# # # 
DEMOS := \
	01.first \
	02.bars \
	03.circles \
	04.morebars \
	05.tape-xfer \
	06.tesseract


# 
all: remove-bin
	@for i in $(DEMOS); do make -C $$i all && make -C $$i clean; done

clean: remove-bin
	@for i in $(DEMOS); do make -C $$i clean; done

.PHONY: remove-bin
remove-bin:
	@rm -f *.tap *.dsk *.hfe
