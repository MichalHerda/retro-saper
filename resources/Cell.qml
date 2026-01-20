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
            when: model.isFlagged
            PropertyChanges { target: flagLoader; visible: true }
        },
        State {
            name: "revealed"
            when: model.isRevealed
            PropertyChanges { target: cell;  }
        }
    ]

    Image {
        id: cellImage
        anchors.fill: cell
        source: "qrc:/Images/CellImage.png"
    }

    Loader {
        id: flagLoader
        anchors.centerIn: cell
        active: cell.isFlagged
        sourceComponent: Image {
            width: cell.width * 0.75
            height: cell.height * 0.75
            source: "qrc:/Images/RadiationWarning.png"
        }
    }

    Loader {
        id: bombLoader
        anchors.centerIn: cell
        active: cell.isRevealed && cell.isMine
        sourceComponent: Image {
            width: cell.width * 0.7
            height: cell.height * 0.7
            z: -1
            source: "qrc:/Images/BombImage.png"
        }
    }

    Loader {
        id: neighborLoader
        anchors.fill: parent
        active: cell.isRevealed && !cell.isMine && cell.neighborMines > 0
        sourceComponent: Rectangle {
            color: "transparent"
            Text {
                anchors.centerIn: parent
                text: cell.neighborMines
                color: "white"
                font.pixelSize: parent.width * 0.5
                font.bold: true
            }
        }
    }

    MouseArea {
        id: cellImageMouseArea
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onClicked: (mouse) => {
            if(!SaperController.isGameOver) {
                if (mouse.button === Qt.RightButton) {
                    if(SaperController.isFirstMove) {
                       console.log("cannot flag! firstMove = true")
                    }
                    else {
                        console.log("Right click! flag!")
                        SaperController.setFlagged(row, column, !isFlagged)
                    }
                    SaperController.checkForGameOver()
                }
                else if (mouse.button === Qt.LeftButton) {
                    if(SaperController.isFirstMove) {
                        console.log("FirstMove! clean neighbors ")

                        SaperController.placeBombsRandomly(row, column)
                        SaperController.isFirstMove = false
                        SaperController.revealCell(row, column)
                    }
                    else {
                        console.log("clicked at row", row, "column", column, "flagged: ", model.isFlagged)
                        console.log("Left click! Reveal!")
                        SaperController.revealCell(row, column)
                    }
                    SaperController.checkForGameOver()
                }
            }
            else {
               console.log("gameOver, press START !")
            }
        }
    }
}
