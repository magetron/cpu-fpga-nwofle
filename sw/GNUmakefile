CC=gcc
CPPC=g++
CFLAGS=-g -Og -Wall
CRCFOLDER=eth-crc32-checker
PROBERFOLDER=fpga-prober

.PHONY: pkt-sender admin-builder crc32-checker clean

default: pkt-sender admin-builder crc32-checker

pkt-sender: $(PROBERFOLDER)/pkt-sender.cc
	@$(CPPC) $(CFLAGS) $(PROBERFOLDER)/pkt-sender.cc -o pkt-sender.out
	@echo -e "\tCPPC ${PROBERFOLDER}/pkt-sender.cc"

admin-builder: $(PROBERFOLDER)/admin-builder.cc
	@$(CPPC) $(CFLAGS) $(PROBERFOLDER)/admin-builder.cc -o admin-builder.out
	@echo -e "\tCPPC ${PROBERFOLDER}/admin-builder.cc"


crc32-checker: $(CRCFOLDER)/crc32-checker.c
	@$(CC) $(CFLAGS) $(CRCFOLDER)/crc32-checker.c -o crc32-checker.out
	@echo -e "\tCC ${CRCFOLDER}/crc-checker.c"


clean:
	rm -rf pkt-sender.out crc32-checker.out