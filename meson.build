project('epoll-shim', 'c',
	version : '0.0.1',
	license : 'MIT',
	default_options : [ 
		'buildtype=debugoptimized',
		'warning_level=3',
		'c_std=c11',
		'werror=true' ],
	meson_version : '>=0.46.0' )

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

libepollshim_so_version = '0.0.0'

# Dependencies
thread_dep = dependency('threads')
pkgconfig = import('pkgconfig')
rt_dep = cc.find_library('rt')

# Include directories
includes_include = include_directories('include')

# Symbol map
libepollshim_sym_path = meson.current_source_dir() + '/Version.map'
libepollshim_sym_ldflag = '-Wl,--version-script=' + libepollshim_sym_path

if cc.links('', name: '-Wl,--version-script', args: ['-shared', libepollshim_sym_ldflag])
	link_args = [libepollshim_sym_ldflag]
else
	error('Linker doesn\'t support --version-script')
endif 

header_libepollshim = [ 'include/sys/epoll.h',
	'include/sys/eventfd.h',
	'include/sys/timerfd.h',
	'include/sys/signalfd.h',
]

install_headers(header_libepollshim, subdir : 'libepoll-shim/sys')

src_libepollshim = [ 'src/epoll.c',
	'src/epoll_shim_ctx.c',
	'src/epoll_shim_ctx.h',
	'src/epollfd_ctx.c',
	'src/epollfd_ctx.h',
	'src/eventfd.c',
	'src/eventfd_ctx.c',
	'src/eventfd_ctx.h',
	'src/signalfd.c',
	'src/signalfd_ctx.c',
	'src/signalfd_ctx.h',
	'src/timerfd.c',
	'src/timerfd_ctx.c',
	'src/timerfd_ctx.h',
]

src_libepollshim += header_libepollshim

deps_libepollshim = [ thread_dep,
		rt_dep
]

lib_libepollshim = both_libraries('epoll-shim',
	src_libepollshim,
	include_directories : includes_include,
	dependencies : deps_libepollshim,
	version : libepollshim_so_version,
	link_args : '-Wl,--version-script=' + libepollshim_sym_path,
	install : true
)

pkgconfig.generate(lib_libepollshim,
	url : 'https://github.com/FreeBSDDesktop/epoll-shim',
	description : 'small epoll implementation using kqueue',
	subdirs : 'libepoll-shim'
)
