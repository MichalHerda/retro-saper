import QtQuick 2.15
import QtQuick.Controls
import SAPER 1.0

Rectangle {
    id: highScoresPage
    color: "blue"

    property int selectedDifficulty: GameSettingsManager.DifficultyLevel.AshenSurvivor
    property var highScores: []

    Column {
        id: highScoresColumn
        width: highScoresPage.width * 0.8
        height: highScoresPage.height * 0.9
        anchors.centerIn: parent
        spacing: highScoresPage.height * 0.025

        Label {
            id: selectLabel
            width: highScoresColumn.width * 0.9
            height: highScoresColumn.height * 0.1
            text: "Select difficulty:"
            color: "white"
            font.pixelSize: Math.min(selectLabel.height, selectLabel.width) * 0.4
            horizontalAlignment: Text.AlignHCenter
        }

        ComboBox {
            id: difficultyComboBox
            width: highScoresColumn.width * 0.9
            height: highScoresColumn.height * 0.1

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
                //highScores = SaperController.highScoresForDifficulty(selectedDifficulty)
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
            width: highScoresColumn.width * 0.9
            height: highScoresColumn.height * 0.7
            anchors.horizontalCenter: highScoresColumn.horizontalCenter
            color: "darkblue"
            radius: 10

            Text {
                color: "white"
                text: "List of best scores for difficulty: " + difficultyComboBox.currentText
            }

            ListView {
                anchors.fill: parent
                model: highScores //SaperController.highScoresForDifficulty(selectedDifficulty)

                Component.onCompleted: {
                    console.log("SaperController.highScores:", JSON.stringify(SaperController.highScoresForDifficulty(selectedDifficulty)))
                }

                delegate: Rectangle {
                    height: 40
                    width: parent.width
                    color: index % 2 === 0 ? "navy" : "darkblue"

                    Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: modelData.playerName
                            color: "white"
                        }
                        Text {
                            text: Qt.formatDateTime(new Date(modelData.achievedAt), "yyyy-MM-dd hh:mm:ss")
                            color: "white"
                        }
                        Text {
                            text: (modelData.timeSeconds !== undefined ? modelData.timeSeconds.toFixed(2) + " s" : "")
                            color: "white"
                        }
                    }
                }
            }
        }
    }
}
