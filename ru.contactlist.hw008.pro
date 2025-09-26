TARGET = ru.contactlist.hw008

CONFIG += \
    auroraapp

PKGCONFIG += \

QT += sql

SOURCES += \
    src/main.cpp \
    src/databasemanager.cpp


HEADERS += \
    src/databasemanager.hpp

DISTFILES += \
    DatabaseContext.js \
    qml/Database.js \
    qml/hw008.qml \
    qml/pages/pageMain.qml \
    qml/dialogs/dialogContact.qml \
    rpm/ru.contactlist.hw008.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.contactlist.hw008.ts \
    translations/ru.contactlist.hw008-ru.ts \
