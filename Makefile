SHELL := /bin/bash


all:
	### Running ### \
	cd ./nerve-center; \
	make & \
	cd ../organs-manager; \
	./run & \

stop:
	### Stoping ### \
	killall -9 spinalhub; \ 



