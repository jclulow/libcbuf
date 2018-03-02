#include <stdlib.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/debug.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <inttypes.h>
#include <unistd.h>
#include "sys/list.h"

#ifdef	LIBCBUF_NO_ENDIAN_H
/*
 * Check to make sure this is a little-endian system.
 */
#ifndef	_LITTLE_ENDIAN
#error "without endian.h this library only works on little endian machines"
#endif

/*
 * Define fallback macros for the endian(3C) functions we need.
 */
#define	htobe16(val)		htons(val)
#define	htobe32(val)		htonl(val)
#define	htobe64(val)		htonll(val)

#define	be16toh(val)		ntohs(val)
#define	be32toh(val)		ntohl(val)
#define	be64toh(val)		ntohll(val)

#define	htole16(val)		(val)
#define	htole32(val)		(val)
#define	htole64(val)		(val)

#define	le16toh(val)		(val)
#define	le32toh(val)		(val)
#define	le64toh(val)		(val)

#else
/*
 * On a recent enough system, we can use the system-provided endian(3C) suite
 * of functions.
 */
#include <endian.h>
#endif

#include "libcbuf.h"

#ifndef	_LIBCBUF_IMPL_H
#define	_LIBCBUF_IMPL_H

struct cbuf {
	uint8_t *cbuf_data;
	size_t cbuf_capacity;

	size_t cbuf_limit;
	size_t cbuf_position;

	cbuf_order_t cbuf_order;

	list_node_t cbuf_link;		/* cbufq_t linkage */
};

struct cbufq {
	size_t cbufq_count;

	list_t cbufq_bufs;		/* queue of cbuf_t */
};

extern int cbuf_safe_add(size_t *, size_t, size_t);

#endif	/* !_LIBCBUF_IMPL_H */
