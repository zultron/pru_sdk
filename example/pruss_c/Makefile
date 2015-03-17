CLPRU = clpru
CLPRU_ARGS = --silicon_version=2 --hardware_mac=on

C_FILES := host_main.c

CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)gcc

C_FLAGS += -Wall -O2 -mtune=cortex-a8 -march=armv7-a
L_LIBS += -lprussdrv

O_FILES := $(C_FILES:.c=.o)


all:	main data.bin text.bin

clean	:
	rm -f pru_main.obj pru_hal.obj pru_main.elf pru_main.map
	rm -f *.o main
	rm -f text.bin data.bin

.PHONY	: clean all


###################
# Userspace stuff
main:	$(O_FILES)
	$(LD) -static -o $@ $(O_FILES) $(L_FLAGS) $(L_LIBS)

%.o : %.c
	$(CC) $(C_FLAGS) -c -o $@ $<


###################
# PRU stuff
pru_hal.obj: pru_hal.c
#	# compile support library without optimization
#	# enabled to keep argument passing convention

	$(CLPRU) $(CLPRU_ARGS) \
	    -c $<

pru_main.obj: pru_main.c
	$(CLPRU) $(CLPRU_ARGS) -O3 \
	    -c $<

pru_main.elf: pru_main.obj pru_hal.obj
#	# compile and link
#	# optimizations allowed

	$(CLPRU) $(CLPRU_ARGS) \
	    -z \
	    $^ -llibc.a \
	    -m pru_main.map \
	    -o $@ \
	    lnk.cmd


data.bin text.bin: pru_main.elf
#	# convert ELF to binary file pru_main.bin

	hexpru bin.cmd $<

