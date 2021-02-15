SRC_DIR=..
PCF_DIR=../constraints
DEVICE=1k
PACKAGE=vq100
SRC=$(SRC_DIR)/top_midi_switcher.v
PCF=$(PCF_DIR)/midi_switcher.pcf
EXE=midi-router

counter.bin: $(SRC) $(PCF)
	yosys -q -p "synth_ice40 -blif $(EXE).blif" $(SRC)
	arachne-pnr -d $(DEVICE) -P $(PACKAGE) -p $(PCF) $(EXE).blif -o $(EXE).txt
	icebox_explain $(EXE).txt > $(EXE).ex
	icepack $(EXE).txt $(EXE).bin

clean:
	rm -f $(EXE).blif $(EXE).txt $(EXE).ex $(EXE).bin
