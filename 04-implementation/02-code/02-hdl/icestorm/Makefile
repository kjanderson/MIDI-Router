SRC_DIR=..
PCF_DIR=constraints
DEVICE=1k
SRC=$(SRC_DIR)/top.v \
    $(SRC_DIR)/counter.v \
    $(SRC_DIR)/mstreset.v
PCF=$(PCF_DIR)/counter.pcf
EXE=midi-router

counter.bin: $(SRC) $(PCF)
	yosys -q -p "synth_ice40 -blif $(EXE).blif" $(SRC)
	arachne-pnr -d $(DEVICE) -p $(PCF) $(EXE).blif -o $(EXE).txt
	icebox_explain $(EXE).txt > $(EXE).ex
	icepack $(EXE).txt $(EXE).bin

clean:
	rm -f $(EXE).blif $(EXE).txt $(EXE).ex $(EXE).bin
