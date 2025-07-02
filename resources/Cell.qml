import QtQuick 2.15

Item {
    id: cell

    property bool isRevealed: false
    property bool isFlagged: false
    property bool isMine: false
    property int neighborMines

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
        source: "qrc:/FlagImage.png"
    }

    MouseArea {
        id: cellImageMouseArea
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                isFlagged = true
                console.log("Right click!")
            }
            else if (mouse.button === Qt.LeftButton) {
                isRevealed = true
                console.log("Left click!")
            }
        }
    }
}
