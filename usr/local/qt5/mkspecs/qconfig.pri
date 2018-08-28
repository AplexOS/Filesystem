#configuration
CONFIG +=  cross_compile shared qpa no_mocdepend release qt_no_framework
host_build {
    QT_ARCH = x86_64
    QT_TARGET_ARCH = arm
} else {
    QT_ARCH = arm
    QMAKE_DEFAULT_LIBDIRS = /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/usr/lib /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/lib/gcc/arm-linux-gnueabihf/5.3.1 /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/lib/gcc/arm-linux-gnueabihf /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/lib/gcc /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/lib /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/lib/arm-linux-gnueabihf/5.3.1 /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/lib/arm-linux-gnueabihf /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/lib /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/usr/lib/arm-linux-gnueabihf/5.3.1 /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/usr/lib/arm-linux-gnueabihf
    QMAKE_DEFAULT_INCDIRS = /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/include/c++/5.3.1 /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/include/c++/5.3.1/arm-linux-gnueabihf /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/include/c++/5.3.1/backward /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/lib/gcc/arm-linux-gnueabihf/5.3.1/include /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/lib/gcc/arm-linux-gnueabihf/5.3.1/include-fixed /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/include /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/x86_64-arago-linux/usr/arm-linux-gnueabihf/libc/usr/include
}
QT_CONFIG +=  minimal-config small-config medium-config large-config full-config fontconfig libudev evdev xkbcommon-evdev gbm linuxfb kms c++11 c++14 c++1z accessibility egl eglfs eglfs_gbm opengl opengles2 shared qpa reduce_exports clock-gettime clock-monotonic posix_fallocate mremap getaddrinfo ipv6ifname getifaddrs inotify eventfd threadsafe-cloexec system-jpeg system-png png system-freetype harfbuzz zlib iconv glib dbus dbus-linked openssl rpath alsa pulseaudio gstreamer-1.0 icu concurrent audio-backend release

#versioning
QT_VERSION = 5.6.2
QT_MAJOR_VERSION = 5
QT_MINOR_VERSION = 6
QT_PATCH_VERSION = 2

#namespaces
QT_LIBINFIX = 
QT_NAMESPACE = 

QT_EDITION = OpenSource

# pkgconfig
PKG_CONFIG_SYSROOT_DIR = /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi
PKG_CONFIG_LIBDIR = /home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/pkgconfig:/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/share/pkgconfig:/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/arm-linux-gnueabihf/pkgconfig

QT_COMPILER_STDCXX = 199711
QT_GCC_MAJOR_VERSION = 5
QT_GCC_MINOR_VERSION = 3
QT_GCC_PATCH_VERSION = 1
