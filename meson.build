project('epoll-shim', 'c',
	version : '0.0.1',
	license : 'MIT',
	default_options : [ 'c_std=c11' ],
	meson_version : '>=0.40.0' )

libepollshim_version = meson.project_version().split('.')

dir_data	= join_paths(get_option('prefix'), get_option('datadir'))
dir_sysconf	= join_paths(get_option('prefix'), get_option('sysconfdir'))
dir_libexec	= join_paths(get_option('prefix'), get_option('libexecdir'))
dir_lib		= join_paths(get_option('prefix'), get_option('libdir'))
dir_include	= join_paths(get_option('prefix'), get_option('includedir'), 'libepoll-shim/sys')
dir_src_test	= join_paths(meson.source_root(), 'test')
dir_src		= join_paths(meson.source_root(), 'src')

# Compiler setup
cc = meson.get_compiler('c')
cflags = ['-Wall', '-Wextra', '-Werror', '-fvisibility=hidden']
add_project_arguments(cflags, language: 'c')

#-Wno-missing-prototypes -Wno-padded -Wno-missing-variable-declarations -Wno-thread-safety-analysis

libepollshim_so_version = '0.0.0'

# Dependencies
thread_dep = dependency('threads')
pkgconfig = import('pkgconfig')
rt_dep = cc.find_library('rt')

# Include directories
includes_include = include_directories('include')

header_libepollshim = [ 'include/sys/epoll.h',
	'include/sys/timerfd.h',
	'include/sys/signalfd.h'
]

install_headers(header_libepollshim, subdir : 'libepoll-shim/sys')

src_libepollshim = [ 'src/epoll.c',
	'src/timerfd.c',
	'src/signalfd.c',
	'src/common.c'
]

src_libepollshim += header_libepollshim

deps_libepollshim = [ thread_dep,
		rt_dep
]

lib_libepollshim = shared_library('epoll-shim',
	src_libepollshim,
	include_directories : includes_include,
	dependencies : deps_libepollshim,
	version : libepollshim_so_version,
	install : true
)

lib_libepollshima = static_library('epoll-shim',
	src_libepollshim,
	include_directories : includes_include,
	dependencies : deps_libepollshim,
	install : true
)

pkgconfig.generate(
	filebase : 'libepoll-shim',
	name : 'libepoll-shim',
	description : 'small epoll implementation using kqueue',
	version : meson.project_version(),
	libraries : lib_libepollshim
)
