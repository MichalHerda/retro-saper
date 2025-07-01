import QtQuick
import QtQuick.Controls
import SAPER 1.0

Window {
    width: 800
    height: 500
    color: "#1a0f0b"
    visible: true
    title: qsTr("S.A.P.E.R.")

    property bool gameStart: false

    GameSettingsManager {
        id: gameSettingsManager
    }

    Row {
        id: titlePageRow
        anchors.fill: parent

        Rectangle {
            id: titleImageFrame
            width: titlePageRow.width * 0.75
            height: titlePageRow.height

            Image {
                anchors.fill: parent
                source: "qrc:/SAPER.png"
            }

            Minefield {
                id: minefield
                //anchors.fill: parent
                width: titlePageRow.width * 0.75
                height: titlePageRow.height
                visible: gameStart
            }
        }

        Options {
            id: mainOptionsFrame
            width: titlePageRow.width * 0.25
            height: titlePageRow.height
        }
    }

    Timer {
        id: debug
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            //console.log("difficulty level: ", SaperController.difficultyLevel)
        }
    }
}
