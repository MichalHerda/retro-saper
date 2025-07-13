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
    property Item highScoresPageInstance

    //property alias highScoresPageComponent: highScoresPageComponent

    signal createMinefield()
    signal createHighScoresPage()

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
                source: "qrc:/Images/SAPER.png"
            }

            Component {
                id: minefieldComponent

                Minefield {
                    id: minefield
                    width: titlePageRow.width * 0.75
                    height: titlePageRow.height
                }
            }

            Component {
                id: highScoresPageComponent

                HighScoresPage {
                    id: highScoresPage
                    anchors.fill: parent

                    Component.onCompleted: {
                        refreshHighScores()
                        selectedDifficulty = SaperController.difficultyLevel
                    }
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

    onCreateHighScoresPage: {
        console.log("create highScoresPage")

        if (highScoresPageInstance) {
            console.log("Destroying previous highScoresPage")
            highScoresPageInstance.destroy()
        }
        SaperController.loadHighScoresForDifficulty(SaperController.difficultyLevel)
        highScoresPageInstance = highScoresPageComponent.createObject(titleImageFrame)
    }

    Timer {
        id: debug
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            //console.log("isFirstMove: ", SaperController.isFirstMove)
            //console.log("isGameOver: ", SaperController.isGameOver)
        }
    }
}
