LIB=		epoll-shim
SHLIB_MAJOR=	0
SRCS=		src/epoll.c src/timerfd.c src/signalfd.c src/common.c
INCS=		include/sys/epoll.h include/sys/timerfd.h include/sys/signalfd.h
VERSION_MAP=	Version.map

FILES=		src/epoll-shim.pc
FILESDIR=	${LIBDATADIR}/pkgconfig

LIBDIR=		/usr/local/lib
INCSDIR=	/usr/local/include/libepoll-shim/sys
LIBDATADIR=	/usr/local/libdata

CFLAGS+=	-I${.CURDIR}/include -pthread -Wall -Wextra -Wno-missing-prototypes -Wno-padded -Wno-missing-variable-declarations -Wno-thread-safety-analysis
LDFLAGS+=	-pthread -lrt

src/epoll-shim.pc: src/epoll-shim.pc.in
	sed -e 's,@CMAKE_INSTALL_PREFIX@,/usr/local,' \
		-e 's,@PROJECT_VERSION@,,' \
		$> >$@

distrib-dirs:
	mkdir -p "${DESTDIR}/${LIBDIR}"
	mkdir -p "${DESTDIR}/${INCSDIR}"
	mkdir -p "${DESTDIR}/${FILESDIR}"

.include <bsd.lib.mk>
