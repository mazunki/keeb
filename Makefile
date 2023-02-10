LAYOUT=mazunki
KEEB=crkbd/rev1
HEXFILENAME=$(subst /,_,$(KEEB))
HEXFILE=keeb.hex
DUMPED_FILE=keeb.hex.bak

all: build

env:
	@echo hexfile=$(HEXFILE)
	@echo hexfilename=$(HEXFILENAME)
	@echo layout=$(LAYOUT)
	@echo keeb=$(KEEB)
	ln -sf src/keyboards/$(KEEB)/keymaps/$(LAYOUT) $(LAYOUT)

build:
	make -C src $(KEEB):$(LAYOUT)
	ln -sf src/.build/$(HEXFILENAME)_$(LAYOUT).hex $(HEXFILE)

install:
	@echo "Please press reset on your board now, and hit enter"
	@read
	avrdude -p atmega32u4 -P /dev/ttyACM0 -c avr109 -U flash:w:$(HEXFILE)

flashdump:
	@echo "Please press reset on your board now, and hit enter"
	@read
	avrdude -p atmega32u4 -P /dev/ttyACM0 -c avr109 -U flash:r:$(DUMPED_FILE)

help:
	make -C src help

clean:
	make -C src clean distclean

