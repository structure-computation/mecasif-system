SHELL := /bin/bash

all: 
	### Building ### \
	mkdir -p build; \
	cd build/; \
	qmake ../; \
	make; \
# 	cd ../; \
# 	make start; \

start:
	### Running ### \
	./run; \
	sleep 0.5; \
	make start; \

clean:
	### Cleaning ### \
	rm -rf build; \
	rm -f run; \



