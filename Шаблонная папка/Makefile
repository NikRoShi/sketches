# 1. Настройки
CC = sdcc
MCU = stm8
CFLAGS = -m$(MCU) --std-sdcc99 -I. -I../../my_STM8_libraries

# 2. Пути
LIB_DIR = ../../my_STM8_libraries
BUILD_DIR = build
TARGET = sketch.ihx

# --- МАГИЯ АВТОПОИСКА ---
# Ищем все .c файлы в папке libs
LIB_SOURCES = $(wildcard $(LIB_DIR)/*.c)
# Собираем всё вместе: main.c + всё что нашли в libs
SOURCES = main.c $(LIB_SOURCES)
# Генерируем список объектных файлов в папке build
OBJECTS = $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCES:.c=.rel)))
# -------------------------

vpath %.c . $(LIB_DIR)

all: prepare $(TARGET)

prepare:
	mkdir -p $(BUILD_DIR)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(BUILD_DIR)/firmware.ihx

$(BUILD_DIR)/%.rel: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(TARGET)

flash:
	sudo stm8flash -c stlinkv2 -p stm8s103f3 -w $(BUILD_DIR)/firmware.ihx

program:
	make
	make flash