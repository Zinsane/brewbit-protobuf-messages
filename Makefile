
.PHONY: clean

PROTOC_BIN  = protoc
INCLUDES    = -I$(PWD)
SRC         = $(PWD)/bbmt.proto
BIN_DIR     = bin
OBJ_DIR     = obj
TARGET      = bbmt

PYTHON_BIN = python
NANOPB_DIR = $(PWD)/../nanopb
NANOPB_BIN = $(NANOPB_DIR)/generator/nanopb_generator.py
INCLUDES  += -I$(NANOPB_DIR)/generator

# Ruby defs
#
RUBY_OPTIONS       = --beefcake_out .
BEEFCAKE_NAMESPACE = ProtobufMessages
RUBY_TARGET        = messages

ifeq ($(OS),Windows_NT)
  # TODO: fill in path for includes on windows for google's protobuf
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Linux)
    INCLUDES += -I/usr/include
  endif
  ifeq ($(UNAME_S),Darwin)
    INCLUDES += -I/usr/local/Cellar/protobuf/2.5.0/include
  endif
endif


all: $(TARGET) $(RUBY_TARGET)

$(RUBY_TARGET): | $(BIN_DIR) $(OBJ_DIR)
	cd $(OBJ_DIR) && BEEFCAKE_NAMESPACE=$(BEEFCAKE_NAMESPACE) $(PROTOC_BIN) $(RUBY_OPTIONS) $(INCLUDES) $(SRC)
	mv $(OBJ_DIR)/$(TARGET).pb.rb $(BIN_DIR)/$(RUBY_TARGET).rb

$(TARGET): | $(BIN_DIR) $(OBJ_DIR)
	cd $(OBJ_DIR) && $(PROTOC_BIN) $(INCLUDES) -o$(TARGET).pb $(SRC)
	cd $(OBJ_DIR) && $(PYTHON_BIN) $(NANOPB_BIN) $(TARGET).pb
	mv $(OBJ_DIR)/$(TARGET).pb $(BIN_DIR)/
	mv $(OBJ_DIR)/$(TARGET).pb.{c,h} $(BIN_DIR)/

clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

