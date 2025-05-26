import QtQuick
import QtQuick.Controls
import SAPER 1.0

Window {
    width: 800
    height: 500
    color: "#1a0f0b"
    visible: true
    title: qsTr("S.A.P.E.R.")

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

        }

        Rectangle {
            id: mainOptionsFrame
            width: titlePageRow.width * 0.25
            height: titlePageRow.height

            Column {
                id: mainOptionsColumn
                y: mainOptionsColumn.height * 0.1
                ComboBox {
                    //anchors.centerIn: parent
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
                            gameSettingsManager.difficultyLevel = model[currentIndex].value
                        }
                    }
                    Component.onCompleted: {
                        for (var i = 0; i < model.length; i++) {
                              if (model[i].value === gameSettingsManager.difficultyLevel)
                                  currentIndex = i;
                                  console.log("current index ", currentIndex)
                        }
                        initialize = false;
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
            console.log("difficulty level: ", gameSettingsManager.difficultyLevel)
        }
    }
}
