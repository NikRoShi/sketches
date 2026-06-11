# 1. Настройки
CC = sdcc
MCU = stm8
CFLAGS = -m$(MCU) --std-sdcc99 -I. -I../../libs

# 2. Пути
LIB_DIR = ../../libs
BUILD_DIR = build
TARGET = sketch.hex

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
	if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(BUILD_DIR)/firmware.ihx
	copy $(BUILD_DIR)\firmware.ihx $(TARGET)

$(BUILD_DIR)/%.rel: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	if exist $(BUILD_DIR) rmdir /s /q $(BUILD_DIR)
	if exist $(TARGET) del /q $(TARGET)
