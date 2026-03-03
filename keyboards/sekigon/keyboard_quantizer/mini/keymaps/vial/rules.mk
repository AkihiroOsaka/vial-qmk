VIA_ENABLE = yes
VIAL_ENABLE = yes
VIAL_INSECURE = yes
# マウス・スクロール機能を有効化
POINTING_DEVICE_ENABLE = yes

SRC += quantizer_mouse.c raw_hid.c

include keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/cli/rules.mk
include keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/key_override/rules.mk
VPATH += keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/cli
VPATH += keyboards/sekigon/keyboard_quantizer/mini/keymaps/vial/key_override

GIT_DESCRIBE := $(shell git describe --tags --long --dirty="\\*" 2>/dev/null)
CFLAGS += -DGIT_DESCRIBE=$(GIT_DESCRIBE)

# ↓ ここを修正：via.o にもマクロ送信関数の書き換え（_vial）を適用します
$(BUILD_DIR)/obj_sekigon_keyboard_quantizer_mini_vial/quantum/via.o:: CFLAGS += -Draw_hid_receive=raw_hid_receive_vial -Ddynamic_keymap_macro_send=dynamic_keymap_macro_send_vial
$(BUILD_DIR)/obj_sekigon_keyboard_quantizer_mini_vial/quantum/dynamic_keymap.o:: CFLAGS += -Ddynamic_keymap_macro_send=dynamic_keymap_macro_send_vial
SRC += tmk_core/protocol/bmp/via_qmk.c
