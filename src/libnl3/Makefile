.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

MAIN_TARGET = libnl-3-200_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb
DERIVED_TARGETS = libnl-3-dev_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-genl-3-200_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-genl-3-dev_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-route-3-200_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-route-3-dev_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb  \
		  libnl-nf-3-200_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-nf-3-dev_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-cli-3-200_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb \
		  libnl-cli-3-dev_$(LIBNL3_VERSION)_$(CONFIGURED_ARCH).deb

$(addprefix $(DEST)/, $(MAIN_TARGET)): $(DEST)/% :
	# Obtaining the libnl3
	rm -rf ./libnl3-$(LIBNL3_VERSION_BASE)
	while [ ! -d libnl3-$(LIBNL3_VERSION_BASE) ]; do \
	git clone https://github.com/thom311/libnl libnl3-$(LIBNL3_VERSION_BASE) || true; \
	echo "Command failed, retrying in 10 seconds"; \    
	sleep 10; \
	done
	pushd libnl3-$(LIBNL3_VERSION_BASE)
	git checkout tags/libnl$(subst .,_,$(LIBNL3_VERSION_BASE))

	git checkout -b sonic
	stg init
	stg import -s ../patch/series

	ln -s ../debian debian
ifeq ($(CROSS_BUILD_ENVIRON), y)
	dpkg-buildpackage -rfakeroot -b -us -uc -a$(CONFIGURED_ARCH) -Pcross,nocheck -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
else
	dpkg-buildpackage -rfakeroot -b -us -uc -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
endif

	popd

	mv $(DERIVED_TARGETS) $* $(DEST)/

$(addprefix $(DEST)/, $(DERIVED_TARGETS)): $(DEST)/% : $(DEST)/$(MAIN_TARGET)
