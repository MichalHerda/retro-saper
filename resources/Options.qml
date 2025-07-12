import QtQuick 2.15
import QtQuick.Controls
import SAPER 1.0

Rectangle {
    id: mainOptionsFrame
    width: titlePageRow.width * 0.25
    height: titlePageRow.height
    color: "#661111"

    Column {
        id: mainOptionsColumn
        width: mainOptionsFrame.width
        height: mainOptionsFrame.height * 0.9
        anchors.verticalCenter: parent.verticalCenter
        spacing: mainOptionsColumn.height * 0.015

        Label {
            id: timerLabel
            width: mainOptionsColumn.width * 0.9
            height: mainOptionsColumn.height * 0.25
            anchors.horizontalCenter: mainOptionsColumn.horizontalCenter
            color: "#FFD700"
            font.pixelSize: Math.min(timerLabel.height, timerLabel.width) * 0.4
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            property double elapsed: SaperController.gameTimer.elapsedSeconds
            font.bold: true
            text: {
                var mins = Math.floor(elapsed / 60)
                var secs = Math.floor(elapsed % 60)
                var hundredths = Math.floor((elapsed - Math.floor(elapsed)) * 100)
                return qsTr("%1:%2.%3")
                    .arg(mins < 10 ? "0" + mins : mins)
                    .arg(secs < 10 ? "0" + secs : secs)
                    .arg(hundredths < 10 ? "0" + hundredths : hundredths)
            }
        }

        Label {
            id: difficultyLevelLabel
            width: mainOptionsColumn.width * 0.9
            height: mainOptionsColumn.height * 0.1
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
            height: mainOptionsColumn.height * 0.1
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
            height: mainOptionsColumn.height * 0.05
        }

        Button {
            id: startGameButton
            width: mainOptionsColumn.width * 0.9
            height: mainOptionsColumn.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                anchors.fill: parent
                color: startGameButton.pressed ? "#1C1C1C" : "#2E2E2E"
            }
            text: "START"

            onClicked: {
                console.log("start game button clicked")
                gameStart = true;
                SaperController.isWin = false
                SaperController.isGameOver = false
                SaperController.resetBoard()
                SaperController.gameTimer.reset()
                SaperController.gameTimer.start()
                createMinefield()
            }
        }

        Item {
            id: separator2
            width: mainOptionsColumn.width
            height: mainOptionsColumn.height * 0.05
        }

        Button {
            id: highScoresButton
            width: mainOptionsColumn.width * 0.9
            height: mainOptionsColumn.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                anchors.fill: parent
                color: highScoresButton.pressed ? "#1C1C1C" : "#2E2E2E"
            }
            text: "HIGH SCORES"

            onClicked: {
                console.log("highScoresButton clicked")
                if (highScoresPageInstance) {
                    highScoresPageInstance.destroy()
                    highScoresPageInstance = null
                }
                else {
                    createHighScoresPage()
                }
            }
        }
    }
}
