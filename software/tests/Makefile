# # # 
DEMOS := \
	01.first \
	02.bars \
	03.circles \
	04.morebars \
	05.tape-xfer \
	06.tesseract \
	07.pp-xfer \
	08.exp-map \
	09.pp-xfer-v2 \
	10.bwtime \
	11.graytime \
	12.bars \
	13.morebars \
	14.tesseract \
	15.bars-16
# 
all: remove-bin
	@for i in $(DEMOS); do (make -C $$i all && make -C $$i clean) || exit 1; done

clean: remove-bin
	@for i in $(DEMOS); do make -C $$i clean; done

.PHONY: remove-bin
remove-bin:
	@rm -f *.tap *.dsk *.hfe
