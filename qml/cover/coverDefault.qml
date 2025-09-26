import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    objectName: "defaultCover"

    CoverTemplate {
        objectName: "applicationCover"
        primaryText: "Приложение контакты"
        secondaryText: qsTr("Контакты")
        icon {
            source: Qt.resolvedUrl("../icons/hw008.svg")
            sourceSize {
                width: icon.width
                height: icon.height
            }
        }
    }
}
