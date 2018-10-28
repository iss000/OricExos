# # # 
DEMOS := \
01.first \
02.bars \
03.circles \
04.morebars \
05.tape-xfer \
06.cube
# 
all:
	@rm -f *.tap
	@for i in $(DEMOS); do make -C $$i all && make -C $$i clean; done
