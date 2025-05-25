import QtQuick
import QtQuick.Controls
import SAPER 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("S.A.P.E.R.")

    GameSettingsManager {
        id: gameSettingsManager
    }

    ComboBox {
        anchors.centerIn: parent
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
            gameSettingsManager.difficultyLevel = model[currentIndex].value
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
