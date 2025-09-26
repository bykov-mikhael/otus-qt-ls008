import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialogContact
    allowedOrientations: Orientation.All

    property alias сontactFName: taContactFName.text
    property alias сontactMName: taContactMName.text
    property alias сontactLName: taContactLName.text
    property alias сontactAlias: cbContactAias.value
    property alias сontactPhoneNumber: tfContactPhoneNumber.text
    property alias сontactMail: tfContactMail.text

    DialogHeader {
        acceptText: qsTr("Сохранить")
        cancelText: qsTr("Отменить")
    }
    Column {
        anchors.centerIn: parent
        width: parent.width

        TextArea {
            id: taContactFName
            width: parent.width
            placeholderText: qsTr("Фамилия")
            label: qsTr("фамилия")
            inputMethodHints: Qt.ImhUrlCharactersOnly
        }

        TextArea {
            id: taContactLName
            width: parent.width
            placeholderText: qsTr("Имя")
            label: qsTr("имя")
            inputMethodHints: Qt.ImhUrlCharactersOnly
        }

        TextArea {
            id: taContactMName
            width: parent.width
            placeholderText: qsTr("Отчество")
            label: qsTr("отчество")
            inputMethodHints: Qt.ImhUrlCharactersOnly
            //            EnterKey.onClicked: textArea.focus = true
        }

        ComboBox {
            id: cbContactAias
            width: parent.width
            label: "обращение"

            menu: ContextMenu {
                MenuItem {
                    text: ""
                }
                MenuItem {
                    text: "г-н"
                }
                MenuItem {
                    text: "г-жа"
                }
                MenuItem {
                    text: "тщ"
                }
            }
        }

        TextField {
            id: tfContactPhoneNumber
            width: parent.width
            placeholderText: qsTr("Номер телефона")
            label: qsTr("номер телефона")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: RegExpValidator {
                regExp: /^(\+7|8)[0-9]{10}$/
            }
            EnterKey.enabled: !errorHighlight
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: textArea.focus = true
        }

        TextField {
            id: tfContactMail
            width: parent.width
            placeholderText: qsTr("Эл. почта")
            label: qsTr("эл. почта")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: RegExpValidator {
                regExp: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
            }
            EnterKey.enabled: !errorHighlight
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: textArea.focus = true
        }
    }
}
