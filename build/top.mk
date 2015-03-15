CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)gcc
STRIP := $(CROSS_COMPILE)strip
PASM := pasm
DTC := dtc

C_FLAGS += -Wall -O2 -mtune=cortex-a8 -march=armv7-a

L_LIBS += -lprussdrv

BIN_FILES := $(P_FILES:.p=.bin)
O_FILES := $(C_FILES:.c=.o)
DTBO_FILES := $(DTS_FILES:.dts=.dtbo)

all:	main $(BIN_FILES) $(DTBO_FILES)

main:	$(O_FILES)
	$(LD) -static -o $@ $(O_FILES) $(L_FLAGS) $(L_LIBS)
	$(STRIP) $@

%.bin : %.p
	$(PASM) -V2 -I$(PRU_SDK_DIR)/include -b $<

%.o : %.c
	$(CC) $(C_FLAGS) -c -o $@ $<

%.dtbo : %.dts
	$(DTC) -@ -O dtb -o $@ $<

.PHONY	: clean all
clean	:
	-rm -f $(O_FILES)
	-rm -f $(BIN_FILES)
	-rm -f $(DTBO_FILES)
	-rm -f main
