Q ?= @
CC = arm-none-eabi-gcc
CXX = arm-none-eabi-g++
BUILD_DIR = target
NWLINK = npx --yes -- nwlink@0.0.16
LINK_GC = 1
LTO = 1

define object_for
$(addprefix $(BUILD_DIR)/,$(addsuffix .o,$(basename $(1))))
endef

src = $(addprefix src/,\
	eadk_vars.c \
)

CPPFLAGS = -std=c99 -Os -Wall
CPPFLAGS = $(shell $(NWLINK) eadk-cflags)
CPPFLAGS +=  -D__RODATA_EADK_API_LEVEL__=\"1.0\" -D__RODATA_EADK_APP_NAME__=\"DOOM\"
LDFLAGS = -nostdlib -nostartfiles
LDFLAGS += -Wl,--relocatable
LDFLAGS += --specs=nano.specs

ifeq ($(LINK_GC),1)
CPPFLAGS += -fdata-sections -ffunction-sections
LDFLAGS += -Wl,-e,main -Wl,-u,eadk_app_name -Wl,-u,eadk_app_icon -Wl,-u,eadk_api_level
LDFLAGS += -Wl,--gc-sections
endif

ifeq ($(LTO),1)
CPPFLAGS += -flto -fno-fat-lto-objects
CPPFLAGS += -fwhole-program
CPPFLAGS += -fvisibility=internal
LDFLAGS += -flinker-output=nolto-rel
endif

.PHONY: build
build: $(BUILD_DIR)/DOOM.bin

.PHONY: run
run: $(BUILD_DIR)/DOOM.nwa
	@echo "INSTALL $<"
	$(Q) $(NWLINK) install-nwa $<

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.nwa
	@echo "BIN     $@"
	$(Q) $(NWLINK) nwa-bin $< $@

$(BUILD_DIR)/DOOM.nwa: $(call object_for,$(src)) $(BUILD_DIR)/icon.o
	@echo "LD      $@"
	$(Q) $(CC) $(CPPFLAGS) $(LDFLAGS) $^ -o $@

$(addprefix $(BUILD_DIR)/,%.o): %.c | $(BUILD_DIR)
	@echo "CXX     $^"
	$(Q) $(CC) $(CPPFLAGS) -c $^ -o $@

$(BUILD_DIR)/icon.o: src/icon.png
	@echo "ICON    $<"
	$(Q) $(NWLINK) png-icon-o $< $@

.PRECIOUS: $(BUILD_DIR)
$(BUILD_DIR):
	$(Q) mkdir -p $@/src

.PHONY: clean
clean:
	@echo "CLEAN"
	$(Q) rm -rf $(BUILD_DIR)