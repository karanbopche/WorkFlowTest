PROJECT = WorkFlowTest.exe

C_FLAGS = -Iinc -Wall -Werror -Oz -MMD
CPP_FLAGS = -Iinc -Wall -Werror --std=c++17 -MMD -Oz
LINKER_FLAG =

SRC_DIR = src
INC_DIR = inc
BUILD_DIR = build

CC = gcc
CPP = g++

ASM_FILES = $(wildcard $(SRC_DIR)/*.S)
C_FILES = $(wildcard $(SRC_DIR)/*.c)
CPP_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%_c.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%_S.o)
OBJ_FILES += $(CPP_FILES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%_cpp.o)

DEP_FILES = $(OBJ_FILES:%.o=$.d)
-include $(DEP_FILES)

all: $(PROJECT)

clean:
	rm -rf $(BUILD_DIR) *.exe

$(BUILD_DIR)/%_cpp.o: $(SRC_DIR)/%.cpp
	mkdir -p $(@D)
	$(CPP) -c -o $@ $< $(CPP_FLAGS)

$(BUILD_DIR)/%_c.o: $(SRC_DIR)/%.c
	mkdir -p $(@D)
	$(CC) -c -o $@ $< $(C_FLAGS)

$(BUILD_DIR)/%_S.o: $(SRC_DIR)/%.S
	mkdir -p $(@D)
	$(CCC) -c -o $@ $< $(C_FLAGS)

$(PROJECT): $(OBJ_FILES)
	$(CPP) -o $@ $(OBJ_FILES) $(LINKER_FLAG)
