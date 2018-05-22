export QTDIR=/usr/share/qt
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
export QT_QWS_FONTDIR=$QTDIR/lib/fonts
export QWS_SIZE=800x600
export QWS_DISPLAY=LinuxFb:/dev/fb0
export QWS_MOUSE_PROTO="Tslib:/dev/input/touchscreen0"
