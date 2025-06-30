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
                anchors.fill: parent
                width: titlePageRow.width * 0.75
                height: titlePageRow.height
                visible: gameStart
            }
        }

        Rectangle {
            id: mainOptionsFrame
            width: titlePageRow.width * 0.25
            height: titlePageRow.height
            color: "#661111"

            Column {
                id: mainOptionsColumn
                width: mainOptionsFrame.width
                height: mainOptionsFrame.height * 0.5
                anchors.verticalCenter: parent.verticalCenter
                spacing: mainOptionsColumn.height * 0.025

                Label {
                    id: difficultyLevelLabel
                    width: mainOptionsColumn.width * 0.9
                    height: mainOptionsColumn.height * 0.15
                    anchors.horizontalCenter: mainOptionsColumn.horizontalCenter

                    text: "game difficulty: "
                    color: "#FFD700"
                    font.pixelSize: Math.min(difficultyLevelLabel.height, difficultyLevelLabel.width) * 0.4

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                ComboBox {
                    id: difficultyLeveComboBox
                    width: mainOptionsColumn.width * 0.9
                    height: mainOptionsColumn.height * 0.2
                    anchors.horizontalCenter: mainOptionsColumn.horizontalCenter
                    property bool initialize: true
                    model: [
                        {text: "RadiationScavenge", value: GameSettingsManager.DifficultyLevel.RadiationScavenge},
                        {text: "WastelandWanderer", value: GameSettingsManager.DifficultyLevel.WastelandWanderer},
                        {text: "AshenSurvivor", value: GameSettingsManager.DifficultyLevel.AshenSurvivor},
                        {text: "NuclearOutlaw", value: GameSettingsManager.DifficultyLevel.NuclearOutlaw},
                        {text: "RadstormVeteran", value: GameSettingsManager.DifficultyLevel.RadstormVeteran},
                        {text: "GammaReaper", value: GameSettingsManager.DifficultyLevel.GammaReaper},
                        {text: "DoomsdayOverlord", value: GameSettingsManager.DifficultyLevel.DoomsdayOverlord}
                    ]
                    textRole: "text"
                    valueRole: "value"

                    onCurrentIndexChanged: {
                        if(!initialize) {
                            SaperController.difficultyLevel = model[currentIndex].value
                        }
                    }
                    Component.onCompleted: {
                        for (var i = 0; i < model.length; i++) {
                              if (model[i].value === SaperController.difficultyLevel)
                                  currentIndex = i;
                                  console.log("current index ", currentIndex)
                        }
                        initialize = false;
                    }
                }

                Item {
                    id: separator
                    width: mainOptionsColumn.width
                    height: mainOptionsColumn.height * 0.25
                }

                Button {
                    id: startGameButton
                    width: mainOptionsColumn.width * 0.9
                    height: mainOptionsColumn.height * 0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    background: Rectangle {
                        anchors.fill: parent
                        color: startGameButton.pressed ? "#1C1C1C" : "#2E2E2E"
                    }
                    text: "START"

                    onClicked: {
                        console.log("start game button clicked")
                        gameStart = true;
                    }

                }
            }
        }
    }


    Timer {
        id: debug
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            console.log("difficulty level: ", SaperController.difficultyLevel)
        }
    }
}
