
.PHONY: clean

PROTOC_BIN  = protoc
INCLUDES    = -I$(PWD)
SRC         = $(PWD)/bbmt.proto
BIN_DIR     = bin
OBJ_DIR     = obj

NANOPB_DIR = $(PWD)/../nanopb
NANOPB_BIN = $(NANOPB_DIR)/generator/nanopb_generator.py
INCLUDES  += -I$(NANOPB_DIR)/generator

# Ruby defs
#
RUBY_OPTIONS       = --beefcake_out .
BEEFCAKE_NAMESPACE = ProtobufMessages

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


all: $(BIN_DIR)/messages.rb

$(BIN_DIR)/messages.rb: | $(BIN_DIR) $(OBJ_DIR)
	cd $(OBJ_DIR) && BEEFCAKE_NAMESPACE=$(BEEFCAKE_NAMESPACE) $(PROTOC_BIN) $(RUBY_OPTIONS) $(INCLUDES) $(SRC)
	cp $(OBJ_DIR)/bbmt.pb.rb $(BIN_DIR)/messages.rb

clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

