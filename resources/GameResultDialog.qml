import QtQuick 2.15

Rectangle {
    id: root
    color: "#2E2E2E"

    Text {
        id: gameResultText
        anchors.centerIn: root
        color: "#FFD700"
        font.pointSize: root.height * 0.7
        text: qsTr("Win !!!")
    }
}
