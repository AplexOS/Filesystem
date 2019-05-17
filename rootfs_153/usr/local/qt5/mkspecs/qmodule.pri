CONFIG +=  cross_compile compile_examples no-libdl qpa largefile precompile_header enable_new_dtags neon pcre
QT_BUILD_PARTS +=  libs examples tools
QT_NO_DEFINES =  CUPS EGL_X11 IMAGEFORMAT_JPEG LIBPROXY OPENVG STYLE_GTK TSLIB XRENDER
QT_QCONFIG_PATH = 
host_build {
    QT_CPU_FEATURES.x86_64 =  mmx sse sse2
} else {
    QT_CPU_FEATURES.arm =  neon
}
QT_COORD_TYPE = double
QT_LFLAGS_ODBC   = -lodbc
styles += mac fusion windows
DEFINES += QT_NO_MTDEV
QT_LIBS_DBUS = -ldbus-1  
QT_CFLAGS_DBUS = -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/include/dbus-1.0 -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/dbus-1.0/include  
QT_HOST_CFLAGS_DBUS = -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/include/dbus-1.0 -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/dbus-1.0/include  
QT_CFLAGS_GLIB = -pthread -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/include/glib-2.0 -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/glib-2.0/include  
QT_LIBS_GLIB = -pthread -lgthread-2.0 -lglib-2.0  
QT_CFLAGS_PULSEAUDIO = -D_REENTRANT -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/include/glib-2.0 -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/lib/glib-2.0/include  
QT_LIBS_PULSEAUDIO = -lpulse-mainloop-glib -lpulse -lglib-2.0  
QMAKE_INCDIR_OPENGL_ES2 = 
QMAKE_LIBDIR_OPENGL_ES2 = 
QMAKE_LIBS_OPENGL_ES2 =  "-lGLESv2" "-lsrv_um"
QMAKE_CFLAGS_OPENGL_ES2 = 
QMAKE_CFLAGS_FONTCONFIG = -I/home/cmi-at751/ti-processor-sdk-linux-am335x-evm-03.03.00.04/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi/usr/include/freetype2  
QMAKE_LIBS_FONTCONFIG = -lfontconfig -lfreetype  
QMAKE_INCDIR_LIBUDEV =  
QMAKE_LIBS_LIBUDEV = -ludev  
DEFINES += QT_NO_TSLIB
QMAKE_INCDIR_XKBCOMMON_EVDEV =  
QMAKE_LIBS_XKBCOMMON_EVDEV = -lxkbcommon  
DEFINES += QT_NO_LIBINPUT
QMAKE_X11_PREFIX = /usr
QMAKE_INCDIR_EGL =  
QMAKE_LIBS_EGL = -lEGL -lIMGegl -ldrm_omap -lsrv_um  
QMAKE_CFLAGS_EGL =  
sql-drivers =  sqlite
sql-plugins = 
