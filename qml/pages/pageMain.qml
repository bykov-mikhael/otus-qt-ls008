import QtQuick 2.0
import Sailfish.Silica 1.0
import Aurora.Controls 1.0
import "../assets/Database.js" as JS

Page {
    // Переменные
    property int idxModelPos: -1
    property var currentContact

    objectName: "mainPage"
    allowedOrientations: Orientation.All

    // --> Кнопки управления записями
    AppBar {
        id: bar
        headerText: qsTr("Контакты")

        AppBarSpacer {}
        // --> Кнопка "Добавить"
        // TODO добавить валидаторы для ФИО
        // TODO добавить поле инфо
        // TODO добавить local storage
        AppBarButton {
            context: "Добавить"
            icon.source: "image://theme/icon-m-add"

            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl(
                                                "../dialogs/dialogContact.qml"))
                dialog.accepted.connect(function () {
                    contactModel.append({
                                            "lContactFName": dialog.сontactFName,
                                            "lContactMName": dialog.сontactMName,
                                            "lContactLName": dialog.сontactLName,
                                            "lContactAlias": dialog.сontactAlias,
                                            "lContactPhoneNumber": dialog.сontactPhoneNumber,
                                            "lContactMail": dialog.сontactMail
                                        })
                })

                JS.dbInsert(dialog.сontactFName, dialog.сontactMName,
                            dialog.сontactLName, dialog.сontactAlias,
                            dialog.сontactPhoneNumber, dialog.сontactMail)
            }
        }

        // --> Кнопка "Изменить"
        AppBarButton {
            context: "Изменить"
            icon.source: "image://theme/icon-m-edit"
            enabled: idxModelPos > -1

            onClicked: {
                var dialog = pageStack.push(
                            Qt.resolvedUrl("../dialogs/dialogContact.qml"), {
                                "сontactFName": currentContact.lContactFName,
                                "сontactMName": currentContact.lContactMName,
                                "сontactLName": currentContact.lContactLName,
                                "сontactAlias": currentContact.lContactAlias,
                                "сontactPhoneNumber": currentContact.lContactPhoneNumber,
                                "сontactMail": currentContact.lContactMail
                            })

                dialog.accepted.connect(function () {
                    contactModel.set(idxModelPos, {
                                         "lContactFName": dialog.сontactFName,
                                         "lContactMName": dialog.сontactMName,
                                         "lContactLName": dialog.сontactLName,
                                         "lContactAlias": dialog.сontactAlias,
                                         "lContactPhoneNumber": dialog.сontactPhoneNumber,
                                         "lContactMail": dialog.сontactMail
                                     })
                })
            }
        }

        // --> Кнопка "Удалить"
        AppBarButton {
            context: "Удалить"
            icon.source: "image://theme/icon-m-delete"
            enabled: idxModelPos > -1
            onClicked: {
                contactModel.remove(idxModelPos)
                idxModelPos = -1
            }
        }
    }

    // --> Список контактов
    SilicaListView {
        anchors.top: bar.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        model: ListModel {
            id: contactModel
        }

        delegate: ListItem {
            height: 160

            Label {
                id: lContactInfo
                anchors.horizontalCenter: parent.horizontalCenter
                x: Theme.horizontalPageMargin
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                text: "\n" + lContactAlias + " " + lContactFName + " " + lContactMName + " "
                      + lContactLName + "\n" + lContactPhoneNumber + "\n" + lContactMail + "\n"
                //WARNING разобраться с высотой записи
                //-> height: 160
            }

            onClicked: {
                idxModelPos = index
                currentContact = contactModel.get(idxModelPos)
            }
        }
    }

    Component.onCompleted: {
        JS.dbInit()
        JS.dbReadAll()
    }
}
