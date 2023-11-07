.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

MAIN_TARGET = $(SFLOWTOOL)

$(addprefix $(DEST)/, $(MAIN_TARGET)): $(DEST)/% :

	rm -fr ./sflowtool
	@until git clone https://github.com/sflow/sflowtool; do \
	echo "git clone failed, retrying..."; \
	sleep 10; \
	done
	cp -r debian sflowtool

	pushd ./sflowtool
	git checkout -b sflowtool -f 6c2963b
ifeq ($(CROSS_BUILD_ENVIRON), y)
	CC=$(CROSS_CC) dpkg-buildpackage -rfakeroot -b -us -uc -a$(CONFIGURED_ARCH) -Pcross,nocheck -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
else
	dpkg-buildpackage -rfakeroot -b -us -uc -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
endif
	popd

	mv $* $(DEST)/

