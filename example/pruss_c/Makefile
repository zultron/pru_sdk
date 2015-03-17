C_FILES := host_main.c ../common/mio.c

CLPRU = clpru
CLPRU_ARGS = --silicon_version=2 --hardware_mac=on

# build host program
include ../../build/top.mk

# Build data.bin/text.bin from default target
all: data.bin text.bin


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


clean: pruss_c_example_clean

pruss_c_example_clean:
	rm -f pru_main.obj pru_hal.obj pru_main.elf pru_main.map
	rm -f *.o main
	rm -f text.bin data.bin

