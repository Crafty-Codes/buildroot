################################################################################
#
# hawktracer
#
################################################################################

HAWKTRACER_VERSION = 2ec19d71923344148928ef45fce549eda67030a4
HAWKTRACER_SITE = $(call github,amzn,hawktracer,$(HAWKTRACER_VERSION))
HAWKTRACER_LICENSE = MIT
HAWKTRACER_LICENSE_FILES = LICENSE
HAWKTRACER_INSTALL_STAGING = YES

HAWKTRACER_CONF_OPTS = \
	-DENABLE_ASAN=OFF \
	-DENABLE_TESTS=OFF \
	-DENABLE_CODE_COVERAGE=OFF \
	-DENABLE_BENCHMARKS=OFF \
	-DENABLE_DOC=OFF \
	-DENABLE_PYTHON_BINDINGS=OFF \
	-DENABLE_MAINTAINER_MODE=OFF \
	-DENABLE_RELEASE_MODE=OFF \
	-DENABLE_CLIENT=OFF \
	-DENABLE_EXAMPLES=OFF

ifeq ($(BR2_STATIC_LIBS),y)
HAWKTRACER_CONF_OPTS += -DBUILD_STATIC_LIB=ON
else
HAWKTRACER_CONF_OPTS += -DBUILD_STATIC_LIB=OFF
endif

ifeq ($(BR2_PACKAGE_HAWKTRACER_TCP_LISTENER),y)
HAWKTRACER_CONF_OPTS += -DENABLE_TCP_LISTENER=ON
else
HAWKTRACER_CONF_OPTS += -DENABLE_TCP_LISTENER=OFF
endif

# Enable threads support if supported by toolchain
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
HAWKTRACER_CONF_OPTS += \
	-DENABLE_CPU_USAGE_FEATURE=ON \
	-DENABLE_THREADS=ON
else
HAWKTRACER_CONF_OPTS += \
	-DENABLE_CPU_USAGE_FEATURE=OFF \
	-DENABLE_THREADS=OFF
endif

$(eval $(cmake-package))
