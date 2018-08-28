QT.qmltest.VERSION = 5.6.2
QT.qmltest.MAJOR_VERSION = 5
QT.qmltest.MINOR_VERSION = 6
QT.qmltest.PATCH_VERSION = 2
QT.qmltest.name = QtQuickTest
QT.qmltest.module = Qt5QuickTest
QT.qmltest.libs = $$QT_MODULE_LIB_BASE
QT.qmltest.includes = $$QT_MODULE_INCLUDE_BASE $$QT_MODULE_INCLUDE_BASE/QtQuickTest
QT.qmltest.frameworks =
QT.qmltest.bins = $$QT_MODULE_BIN_BASE
QT.qmltest.libexecs = $$QT_MODULE_LIBEXEC_BASE
QT.qmltest.plugins = $$QT_MODULE_PLUGIN_BASE
QT.qmltest.imports = $$QT_MODULE_IMPORT_BASE
QT.qmltest.qml = $$QT_MODULE_QML_BASE
QT.qmltest.depends = core testlib widgets
QT.qmltest.run_depends = quick qml_private gui core_private
QT.qmltest.module_config = v2
QT.qmltest.CONFIG = console testlib_defines
QT.qmltest.DEFINES = QT_QMLTEST_LIB
QT_MODULES += qmltest
