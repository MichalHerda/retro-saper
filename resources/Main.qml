import QtQuick
import QtQuick.Controls
import SAPER 1.0

Window {
    id: mainWindow
    width: 800
    height: 500
    color: "#1a0f0b"
    visible: true
    title: qsTr("S.A.P.E.R.")

    property bool gameStart: false
    property Item minefieldInstance

    signal createMinefield()

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

            Component {
                id: minefieldComponent

                Minefield {
                    id: minefield
                    width: titlePageRow.width * 0.75
                    height: titlePageRow.height
                }
            }
        }

        Options {
            id: mainOptionsFrame
            width: titlePageRow.width * 0.25
            height: titlePageRow.height
        }
    }

    onCreateMinefield: {
        console.log("create minefieldComponent")

        if (minefieldInstance) {
            console.log("Destroying previous minefield")
            minefieldInstance.destroy()
        }
        minefieldInstance = minefieldComponent.createObject(titleImageFrame)
    }

    Timer {
        id: debug
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            //console.log("isFirstMove: ", SaperController.isFirstMove)
        }
    }
}
