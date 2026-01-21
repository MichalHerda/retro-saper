import QtQuick 2.15
import QtQuick.Controls
import SAPER 1.0

Rectangle {
    id: highScoresPage
    color: "#1a0f0b"

    property int selectedDifficulty: GameSettingsManager.DifficultyLevel.AshenSurvivor
    property var highScores: SaperController.highScores

    function formatTime(seconds) {
        let mins = Math.floor(seconds / 60);
        let secs = Math.floor(seconds % 60);
        let millis = Math.floor((seconds - Math.floor(seconds)) * 1000);

        let minStr = mins.toString().padStart(2, "0");
        let secStr = secs.toString().padStart(2, "0");
        let msStr = millis.toString().padStart(3, "0");

        return minStr + ":" + secStr + ":" + msStr;
    }

    function refreshHighScores() {
        console.log("refresh high scores function")
        SaperController.loadHighScoresForDifficulty(selectedDifficulty)
        highScores = SaperController.highScoresForDifficulty(selectedDifficulty)
    }

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
                highScores = result
            }

            Component.onCompleted: {
                for (var i = 0; i < model.length; i++) {
                    if (model[i].value === selectedDifficulty) {
                        currentIndex = i
                        break
                    }
                }
            }
        }

        Item {
            id: columnSeparator
            height: highScoresColumn.height * 0.1
        }

        Rectangle {
            id: highScoresFrame
            width: highScoresColumn.width
            height: highScoresColumn.height * 0.85
            anchors.horizontalCenter: highScoresColumn.horizontalCenter
            color: "#000000"
            radius: 10

            ScrollView {
                anchors.fill: parent
                clip: true

                ListView {
                    width: parent.width
                    height: parent.height
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

                            Item {
                                id: separator0
                                width: highScoreRow.width * 0.025
                            }

                            Text {
                                text: (index + 1).toString()
                                width: highScoreRow.width * 0.05
                                color: "#FFD700"
                                horizontalAlignment: Text.AlignHCenter
                            }

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
                                text: Qt.formatDateTime(new Date(modelData.achievedAt), "yyyy-MM-dd" )
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
                                text: (modelData.timeSeconds !== undefined ? formatTime(modelData.timeSeconds.toFixed(3) ) : "")
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
}
