import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    objectName: "Contact List"
    initialPage: Qt.resolvedUrl("pages/pageMain.qml")
    cover: Qt.resolvedUrl("cover/coverDefault.qml")
    allowedOrientations: defaultAllowedOrientations
}
