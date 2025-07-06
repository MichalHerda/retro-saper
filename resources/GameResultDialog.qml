import QtQuick 2.15
import SAPER 1.0

Rectangle {
    id: root
    color: "#2E2E2E"

    Text {
        id: gameWinText
        visible: SaperController.isWin
        anchors.centerIn: root
        color: "#FFD700"
        font.pointSize: root.height * 0.7
        text: qsTr("Win !!!")
    }

    Text {
        id: gameLoseText
        visible: !SaperController.isWin
        anchors.centerIn: root
        color: "#FFD700"
        font.pointSize: root.height * 0.7
        text: qsTr("Lose !!!")
    }
}
