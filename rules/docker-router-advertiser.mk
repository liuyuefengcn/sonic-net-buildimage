# Docker image for router advertiser

DOCKER_ROUTER_ADVERTISER_STEM = docker-router-advertiser
DOCKER_ROUTER_ADVERTISER = $(DOCKER_ROUTER_ADVERTISER_STEM).gz
DOCKER_ROUTER_ADVERTISER_DBG = $(DOCKER_ROUTER_ADVERTISER_STEM)-$(DBG_IMAGE_MARK).gz

$(DOCKER_ROUTER_ADVERTISER)_PATH = $(DOCKERS_PATH)/$(DOCKER_ROUTER_ADVERTISER_STEM)

$(DOCKER_ROUTER_ADVERTISER)_DBG_DEPENDS = $($(DOCKER_CONFIG_ENGINE_BULLSEYE)_DBG_DEPENDS)
$(DOCKER_ROUTER_ADVERTISER)_DBG_DEPENDS += $(RADVD_DBG)

$(DOCKER_ROUTER_ADVERTISER)_DBG_IMAGE_PACKAGES = $($(DOCKER_CONFIG_ENGINE_BULLSEYE)_DBG_IMAGE_PACKAGES)

$(DOCKER_ROUTER_ADVERTISER)_LOAD_DOCKERS = $(DOCKER_CONFIG_ENGINE_BULLSEYE)

$(DOCKER_ROUTER_ADVERTISER)_VERSION = 1.0.0
$(DOCKER_ROUTER_ADVERTISER)_PACKAGE_NAME = radv
$(DOCKER_ROUTER_ADVERTISER)_WARM_SHUTDOWN_BEFORE = swss
$(DOCKER_ROUTER_ADVERTISER)_FAST_SHUTDOWN_BEFORE = swss

SONIC_DOCKER_IMAGES += $(DOCKER_ROUTER_ADVERTISER)
SONIC_INSTALL_DOCKER_IMAGES += $(DOCKER_ROUTER_ADVERTISER)

SONIC_DOCKER_DBG_IMAGES += $(DOCKER_ROUTER_ADVERTISER_DBG)
SONIC_INSTALL_DOCKER_DBG_IMAGES += $(DOCKER_ROUTER_ADVERTISER_DBG)

$(DOCKER_ROUTER_ADVERTISER)_CONTAINER_NAME = radv
$(DOCKER_ROUTER_ADVERTISER)_RUN_OPT += --privileged -t
$(DOCKER_ROUTER_ADVERTISER)_RUN_OPT += -v /etc/sonic:/etc/sonic:ro
$(DOCKER_ROUTER_ADVERTISER)_FILES += $(SUPERVISOR_PROC_EXIT_LISTENER_SCRIPT)
