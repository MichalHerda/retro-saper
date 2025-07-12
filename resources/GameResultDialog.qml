import QtQuick 2.15
import QtQuick.Controls
import SAPER 1.0

Rectangle {
    id: root
    color: "#2E2E2E"

    property bool isNewHighScore: false
    property bool qualifies: false
    property bool askedName: false
    property string playerName: ""

    Component.onCompleted: {
        console.log("gameResultDialog onCompleted")
        if (SaperController.isWin) {
            qualifies = gameSettingsManager.qualifiesForHighScores(SaperController.difficulty, SaperController.lastGameTime);
            console.log("qualified for highScores: ", qualifies)
            if(qualifies) {
                isNewHighScore = true
            }
        }
        else {
            askedName = true
        }
    }

    Text {
        id: gameWinText
        visible: SaperController.isWin && askedName
        anchors.centerIn: root
        color: "#FFD700"
        font.pointSize: root.height * 0.5
        text: qsTr("Win !!!")
    }

    Text {
        id: gameLoseText
        visible: !SaperController.isWin && askedName
        anchors.centerIn: root
        color: "#FFD700"
        font.pointSize: root.height * 0.5
        text: qsTr("Lose !!!")
    }

    Column {
        id: enterHighScoreColumn
        visible: SaperController.isWin && qualifies && !askedName
        anchors.fill: parent
        spacing: root.height * 0.075

        Item {
            id: separator1
            width: enterHighScoreColumn.width * 0.8
            height: enterHighScoreColumn.height * 0.05
        }

        Text {
            id: topResultInfoField
            width: enterHighScoreColumn.width * 0.8
            height: enterHighScoreColumn.height * 0.1
            anchors.horizontalCenter: enterHighScoreColumn.horizontalCenter
            text: qsTr("you have reached top 20 result!")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pointSize: topResultInfoField.height * 0.7
        }

        TextField {
            id: nameField
            width: enterHighScoreColumn.width * 0.8
            height: enterHighScoreColumn.height * 0.3
            anchors.horizontalCenter: enterHighScoreColumn.horizontalCenter
            placeholderText: qsTr("Enter your name")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            onTextChanged: playerName = text
            font.pointSize: topResultInfoField.height * 0.7
        }

        Button {
            id: saveResultButton
            width: enterHighScoreColumn.width * 0.8
            height: enterHighScoreColumn.height * 0.2
            anchors.horizontalCenter: enterHighScoreColumn.horizontalCenter
            text: qsTr("Save result and exit")
            font.pointSize: topResultInfoField.height * 0.7
            onClicked: {
                if (playerName.length > 0) {
                    gameSettingsManager.addHighScoreInvokable(
                        SaperController.difficultyLevel,
                        playerName,
                        SaperController.lastGameTime
                    );
                askedName = true;
                gameSettingsManager.getHighScores(SaperController.difficultyLevel)
                createHighScoresPage()
                isNewHighScore = false;
                }
            }
        }
    }
}
