CC ?= cc
CFLAGS ?= -O -Wall -Wextra -Wformat-security -D_FORTIFY_SOURCE=2
CFLAGS += -std=c99 -D_POSIX_C_SOURCE=200809L -fstack-protector-strong
LDFLAGS += -fPIC -shared

# FreeBSD puts the openvpn header in a different location unknown to clang
IPATH_FREEBSD = /usr/local/include/

# Output Files
SRC 	= $(wildcard *.c)
OUT	= $(SRC:%.c=%.so)

%.so: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

all: plugin

plugin: $(OUT)

clean:
	rm -f *.so
