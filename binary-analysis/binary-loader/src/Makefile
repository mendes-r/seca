IDIR=../include
BIN=../bin/

CC=gcc
CFLAGS=-I$(IDIR) -Wall -pedantic -std=c99
DEPS=$(IDIR)/. 
OBJ=loader.c
EXEC=b-loader

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

run: $(OBJ)
	@mkdir -p $(BIN)
	@$(CC) -o $(BIN)$(EXEC) $^ $(CFLAGS)

