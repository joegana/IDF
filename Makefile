UNAME := $(shell uname)
SOURCE_DIR = source
BUILD_DIR = build
OBJECT_DIR = $(BUILD_DIR)/objects
LIB = $(BUILD_DIR)/lib/libidf.a
SOURCES := $(shell find $(SOURCE_DIR) -name "*.cpp" -not -path "*/io_src/*" -not -path "*/swig/*")
ifndef IDF_CAN
SOURCES := $(filter-out $(shell find $(SOURCE_DIR) -name "*Can*"),$(SOURCES))
endif
OBJECTS := $(SOURCES:$(SOURCE_DIR)/%.cpp=$(OBJECT_DIR)/%.o)
CPPFLAGS += -g -Wall -Wextra -fdiagnostics-show-option -Wredundant-decls -fno-strict-aliasing -Wno-invalid-offsetof -Wno-missing-field-initializers -Wshadow -Woverloaded-virtual -Iinclude

all: $(LIB)

clean:
	rm -rf $(BUILD_DIR)

$(sort $(dir $(OBJECTS))) $(dir $(LIB)):
	mkdir -p $@

$(LIB): $(OBJECTS) | $(dir $(LIB))
	ar rs $(LIB) $(OBJECTS)

.SECONDEXPANSION:

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.cpp | $$(dir $$@)
	$(CXX) -c $(CPPFLAGS) -o $@ $^
