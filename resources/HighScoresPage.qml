import QtQuick 2.15
import QtQuick.Controls
import SAPER 1.0

Rectangle {
    id: highScoresPage
    color: "#1a0f0b"

    property int selectedDifficulty: GameSettingsManager.DifficultyLevel.AshenSurvivor
    property var highScores: []

    Column {
        id: highScoresColumn
        width: highScoresPage.width * 0.95
        height: highScoresPage.height * 0.9
        anchors.centerIn: parent
        spacing: highScoresPage.height * 0.025

        Label {
            id: selectLabel
            width: highScoresColumn.width
            height: highScoresColumn.height * 0.03
            text: qsTr("Show high scores for difficulty level:")
            color: "white"
            font.pixelSize: Math.min(selectLabel.height, selectLabel.width) * 0.9
            horizontalAlignment: Text.AlignHCenter
        }

        ComboBox {
            id: difficultyComboBox
            width: highScoresColumn.width * 0.6
            height: highScoresColumn.height * 0.075

            anchors.horizontalCenter: highScoresColumn.horizontalCenter

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
                selectedDifficulty = model[currentIndex].value
                console.log("Selected difficulty:", model[currentIndex].text, selectedDifficulty)
                SaperController.loadHighScoresForDifficulty(selectedDifficulty)
                var result = SaperController.highScoresForDifficulty(selectedDifficulty)
                console.log("Fetched high scores:", JSON.stringify(result))
                highScores = result
            }

            Component.onCompleted: {
                // Ustaw domyślnie na poziom z property
                for (var i = 0; i < model.length; i++) {
                    if (model[i].value === selectedDifficulty) {
                        currentIndex = i
                        break
                    }
                }
            }
        }

        Rectangle {
            id: highScoresFrame
            width: highScoresColumn.width
            height: highScoresColumn.height * 0.85
            anchors.horizontalCenter: highScoresColumn.horizontalCenter
            color: "#000000" //"darkblue"
            radius: 10

            Text {
                color: "white"
                text: "List of best scores for difficulty: " + difficultyComboBox.currentText
            }

            ListView {
                anchors.fill: parent
                model: highScores

                Component.onCompleted: {
                    console.log("SaperController.highScores:", JSON.stringify(SaperController.highScoresForDifficulty(selectedDifficulty)))
                }

                delegate: Rectangle {
                    height: highScoresFrame.height * 0.1
                    width: highScoresFrame.width
                    color: "#000000"

                    Row {
                        id: highScoreRow
                        width: highScoresFrame.width
                        //anchors.verticalCenter: parent.verticalCenter

                        Item {
                            id: separator1
                            width: highScoreRow.width * 0.025
                        }

                        Text {
                            id: playerNameText
                            text: modelData.playerName
                            width: highScoreRow.width * 0.5
                            color: "#FFD700"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Item {
                            id: separator2
                            width: highScoreRow.width * 0.025
                        }

                        Text {
                            id: resultDateText
                            text: Qt.formatDateTime(new Date(modelData.achievedAt), "yyyy-MM-dd" ) //" hh:mm:ss")
                            width: highScoreRow.width * 0.2
                            color: "#FFD700"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Item {
                            id: separator3
                            width: highScoreRow.width * 0.025
                        }

                        Text {
                            id: resultTimeText
                            text: (modelData.timeSeconds !== undefined ? modelData.timeSeconds.toFixed(2) + " s" : "")
                            width: highScoreRow.width * 0.2
                            color: "#FFD700"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Item {
                            id: separator4
                            width: highScoreRow.width * 0.025
                        }
                    }
                }
            }
        }
    }
}
