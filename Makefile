# Compilation Arguments
CC ?= cc
CFLAGS += -Wall -Wextra -Wformat-security -D_FORTIFY_SOURCE=2
CFLAGS += -std=c99 -D_POSIX_C_SOURCE=200809L
LDFLAGS += -fPIC -shared

# General Constants
INSTALL=/usr/bin/install -c

# Output Files
SRC 	= $(wildcard *.c)
OUT	= $(SRC:%.c=%.so)

# Determine Prefix
ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

# Construction Targets
%.so: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

.PHONY: all
all: $(OUT)

.PHONY: install
install: all installdirs
	$(INSTALL) $(OUT) $(DESTDIR)$(PREFIX)/lib/openvpn/plugins/$(OUT)

.PHONY: installdirs
installdirs: 
	mkdir -p $(DESTDIR)$(PREFIX)/lib/openvpn/plugins

.PHONY: clean
clean:
	rm -f *.so

