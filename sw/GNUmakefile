CC=gcc
CPPC=g++
CFLAGS=-g -Og -Wall
CRCFOLDER=eth-crc32-checker
PROBERFOLDER=fpga-prober
SIPHASHFOLDER=siphash-checker
CLIFOLDER=admin-cli
CLILINK=-ledit -lpthread

.PHONY: pkt-sender admin-builder crc32-checker pkt-receiver admin-cli siphash-checker build clean

default: build

pkt-sender: $(PROBERFOLDER)/pkt-sender.cc
	@$(CPPC) $(CFLAGS) $(PROBERFOLDER)/pkt-sender.cc -o pkt-sender.out
	@echo -e "\tCPPC ${PROBERFOLDER}/pkt-sender.cc"

admin-builder: $(PROBERFOLDER)/admin-builder.cc
	@$(CPPC) $(CFLAGS) $(PROBERFOLDER)/admin-builder.cc -o admin-builder.out
	@echo -e "\tCPPC ${PROBERFOLDER}/admin-builder.cc"

crc32-checker: $(CRCFOLDER)/crc32-checker.c
	@$(CC) $(CFLAGS) $(CRCFOLDER)/crc32-checker.c -o crc32-checker.out
	@echo -e "\tCC ${CRCFOLDER}/crc-checker.c"

pkt-receiver: $(PROBERFOLDER)/pkt-receiver.cc
	@$(CPPC) $(CFLAGS) $(PROBERFOLDER)/pkt-receiver.cc -o pkt-receiver.out
	@echo -e "\tCC ${PROBERFOLDER}/pkt-receiver.cc"

admin-cli: $(CLIFOLDER)/
	@$(CPPC) $(CFLAGS) $(CLILINK) $(CLIFOLDER)/main.cc -o main.out
	@echo -e "\tCPPC ${CLIFOLDER}/main.cc"

siphash-checker: $(SIPHASHFOLDER)/siphash-checker.cc
	@$(CPPC) $(CFLAGS) $(SIPHASHFOLDER)/siphash-checker.cc -o siphash-checker.out
	@echo -e "\tCC $(SIPHASHFOLDER)/siphash-checker.cc"

build: admin-cli pkt-sender admin-builder crc32-checker pkt-receiver siphash-checker
	@mkdir -p tools
	@mv ./pkt-sender.out tools/
	@mv ./admin-builder.out tools/
	@mv ./crc32-checker.out tools/
	@mv ./pkt-receiver.out tools/
	@mv ./siphash-checker.out tools/
	@echo -e "BUILD DONE"
	@echo -e "supplementary tools under ./tools/"
	@echo -e "CLI interface executable ./main.out, run with root privilege to access raw socket"

clean:
	rm -rf main.out pkt-sender.out crc32-checker.out admin-builder.out pkt-receiver.out siphash-checker.out
	rm -rf tools/
