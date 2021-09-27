PROGRAM = boot_sector_code

BUILD_DIR = build

SOURCE_S_LIST = \
src/boot_sector_code.s

SOURCE_C_LIST = \

INCLUDE_C_LIST = \
-Ih

OBJECTS_LIST = 
OBJECTS_LIST += $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCE_S_LIST:.s=.o)))
OBJECTS_LIST += $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCE_C_LIST:.c=.o)))

vpath %.s $(sort $(dir $(SOURCE_S_LIST)))
vpath %.c $(sort $(dir $(SOURCE_C_LIST)))

CC = gcc.exe -c
AS = gcc.exe -c -x assembler
LD = ld.exe
HX = objcopy.exe --output-target binary -j .text

FLAGS_AS = 

FLAGS_CC = 

FLAGS_CC += $(INCLUDE_C_LIST)

all : $(BUILD_DIR)/$(PROGRAM).bin

$(BUILD_DIR)/$(PROGRAM).bin : $(BUILD_DIR)/$(PROGRAM).o
	$(HX) $(<) $(@)

$(BUILD_DIR)/%.o : %.s makefile | $(BUILD_DIR)
	$(AS) $(FLAGS_AS) -o $(@) $(<)

$(BUILD_DIR)/%.o : %.c makefile | $(BUILD_DIR)
	$(CC) $(FLAGS_CC) -o $(@) $(<)
	
$(BUILD_DIR) :
	mkdir $(@)
	
clean :
	rm -rf $(BUILD_DIR)

-include $(wildcard $(BUILD_DIR)/*.d)
