
ROOT :=			$(PWD)

CFLAGS =		-I$(ROOT)/src \
			-I$(ROOT)/include \
			-std=gnu99 -g \
			-Wall -Wextra -Werror \
			-Wno-unused-parameter \
			-Wno-unused-function
EXTRA_CFLAGS =

CBUF_OBJS =		cbuf.o cbufq.o list.o

OBJ_DIR =		obj
DESTDIR =		.

CBUF_ARCHIVE =		$(DESTDIR)/libcbuf.a

$(CBUF_ARCHIVE): $(CBUF_OBJS:%=$(OBJ_DIR)/%)
	@mkdir -p $(@D)
	ar rcs $@ $^

$(OBJ_DIR)/%.o: src/%.c | $(OBJ_DIR)
	gcc -c $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: deps/illumos-list/src/%.c | $(OBJ_DIR)
	gcc -c $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $^

$(OBJ_DIR):
	mkdir -p $@

clean:
	rm -f $(CBUF_OBJS:%=$(OBJ_DIR)/%)
	rm -f $(CBUF_ARCHIVE)
