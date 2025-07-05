import QtQuick 2.15
import SAPER 1.0

Item {
    id: cell

    property bool isRevealed: false
    property bool isFlagged: false
    property bool isMine: false
    property int neighborMines

    property bool isInitialized: false

    states: [
        State {
            name: "covered"
            when: cell.isRevealed && !cell.isFlagged
            PropertyChanges { target: cellImage; visible: false }
        },
        State {
            name: "flagged"
            when: cell.isFlagged
            PropertyChanges { target: flagImage; visible: true }
        },
        State {
            name: "revealed"
            when: cell.isRevealed
            PropertyChanges { target: cell;  }
        }
    ]

    Image {
        id: cellImage
        anchors.fill: cell
        source: "qrc:/CellImage.png"
    }

    Image {
        id: flagImage
        anchors.centerIn: cell
        visible: false
        width: cell.width * 0.75
        height: cell.height * 0.75
        source: "qrc:/RadiationWarning.png"
    }

    Image {
        id: bombImage
        anchors.centerIn: cell
        visible: cell.isMine
        width: cell.width * 0.7
        height: cell.height * 0.7
        z: -1
        source: "qrc:/BombImage.png"
    }

    Rectangle {
        id: neighborMinesRec
        anchors.fill: parent
        color: "transparent"
        visible: cell.isRevealed && !cell.isMine && cell.neighborMines > 0
        z: 1

        Text {
            anchors.centerIn: parent
            text: cell.neighborMines
            color: "white"
            font.pixelSize: parent.width * 0.5
            font.bold: true
        }
    }

    MouseArea {
        id: cellImageMouseArea
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                if(SaperController.isFirstMove) {
                   console.log("cannot flag! firstMove = true")
                }
                else {
                    console.log("Right click! flag!")
                    isFlagged = true
                }
            }
            else if (mouse.button === Qt.LeftButton) {
                if(SaperController.isFirstMove) {
                    console.log("FirstMove! clean neighbors ")
                    SaperController.isFirstMove = false
                }
                //else {
                   console.log("Left click! Reveal!")
                   isRevealed = true
               //}
            }
        }
    }
}
