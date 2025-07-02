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
            PropertyChanges { target: cell;  }
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

    MouseArea {
        id: cellImageMouseArea
        anchors.fill: parent
        onClicked: {
            console.log("clicked")
            isRevealed = true
        }
    }
}
