/****************************************************************************
** Meta object code from reading C++ file 'test.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../test.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'test.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_TestWidget[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      18,   12,   11,   11, 0x0a,
      49,   45,   11,   11, 0x0a,
      74,   11,   11,   11, 0x0a,
      89,   87,   11,   11, 0x0a,
     104,   45,   11,   11, 0x0a,
     122,   45,   11,   11, 0x0a,
     140,  135,   11,   11, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_TestWidget[] = {
    "TestWidget\0\0index\0ComboBoxChoiceChanged(int)\0"
    "val\0SpinBoxValueChanged(int)\0WidgetTest()\0"
    "i\0tabChange(int)\0movePosition(int)\0"
    "setSize(int)\0file\0loadInjection(QString)\0"
};

void TestWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        TestWidget *_t = static_cast<TestWidget *>(_o);
        switch (_id) {
        case 0: _t->ComboBoxChoiceChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->SpinBoxValueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->WidgetTest(); break;
        case 3: _t->tabChange((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->movePosition((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->setSize((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->loadInjection((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData TestWidget::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject TestWidget::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_TestWidget,
      qt_meta_data_TestWidget, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &TestWidget::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *TestWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *TestWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_TestWidget))
        return static_cast<void*>(const_cast< TestWidget*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int TestWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
