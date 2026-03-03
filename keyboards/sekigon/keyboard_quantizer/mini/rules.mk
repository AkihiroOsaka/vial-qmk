# Vial & VIA 設定
VIA_ENABLE = yes
VIAL_ENABLE = yes
VIAL_INSECURE = yes

# マウス・スクロール機能の有効化（エラー回避に必須）
POINTING_DEVICE_ENABLE = yes
POINTING_DEVICE_DRIVER = custom

# Keyboard Quantizer Mini 固有のソースファイル
SRC += quantizer_mouse.c raw_hid.c
SRC += matrix.c c1_main.c c1_usbh.c tusb_os_custom.c
OPT_DEFS += -DCRT0_EXTRA_CORES_NUMBER=1

# インクルード設定
include keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/cli/rules.mk
include keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/key_override/rules.mk
VPATH += keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/cli
VPATH += keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/key_override

# PIO USB & TinyUSB ライブラリ設定
SRC += lib/Pico-PIO-USB/src/pio_usb.c
SRC += lib/Pico-PIO-USB/src/pio_usb_host.c
SRC += lib/Pico-PIO-USB/src/usb_crc.c
VPATH += keyboards/sekigon/keyboard_quantizer/mini/lib/Pico-PIO-USB/src

SRC += lib/tinyusb/src/tusb.c
SRC += lib/tinyusb/src/common/tusb_fifo.c
SRC += lib/tinyusb/src/host/usbh.c
SRC += lib/tinyusb/src/host/hub.c
SRC += lib/tinyusb/src/class/hid/hid_host.c
SRC += lib/tinyusb/src/portable/raspberrypi/pio_usb/hcd_pio_usb.c
VPATH += keyboards/sekigon/keyboard_quantizer/mini/lib/tinyusb/src

# Pico SDK 関連設定
SRC += lib/pico-sdk/src/rp2_common/hardware_dma/dma.c
SRC += lib/pico-sdk/src/host/pico_stdlib/stdlib.c
VPATH += lib/pico-sdk/src/rp2_common/hardware_dma/include
VPATH += lib/pico-sdk/src/rp2_common/hardware_uart/include
VPATH += lib/pico-sdk/src/rp2_common/pico_stdio/include
VPATH += lib/pico-sdk/src/common/pico_stdlib/include
VPATH += lib/pico-sdk/src/common/pico_time/include
VPATH += lib/pico-sdk/src/common/pico_sync/include
VPATH += lib/pico-sdk/src/common/pico_util/include

# ビルド用フラグ設定
GIT_DESCRIBE := $(shell git describe --tags --long --dirty="\\*" 2>/dev/null)
CFLAGS += -DGIT_DESCRIBE=$(GIT_DESCRIBE)

# Vial 互換のためのオーバーライド設定
$(BUILD_DIR)/obj_sekigon_keyboard_quantizer_mini_vial/quantum/via.o:: CFLAGS += -Draw_hid_receive=raw_hid_receive_vial
$(BUILD_DIR)/obj_sekigon_keyboard_quantizer_mini_vial/quantum/dynamic_keymap.o:: CFLAGS += -Ddynamic_keymap_macro_send=dynamic_keymap_macro_send_vial
SRC += tmk_core/protocol/bmp/via_qmk.c
