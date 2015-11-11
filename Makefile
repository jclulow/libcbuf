
ROOT :=			$(PWD)

CFLAGS =		-I$(ROOT)/src \
			-I$(ROOT)/include \
			-std=gnu99 -g \
			-Wall -Wextra -Werror \
			-Wno-unused-parameter \
			-Wno-unused-function
EXTRA_CFLAGS =

CBUF_OBJS =		obj/cbuf.o obj/cbufq.o obj/list.o

libcbuf.a: $(CBUF_OBJS)
	ar rcs $@ $^

obj/%.o: src/%.c | obj
	gcc -c $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $^

obj/%.o: deps/illumos-list/src/%.c | obj
	gcc -c $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $^

obj:
	mkdir -p $@

