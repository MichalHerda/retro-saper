import QtQuick 2.15
import SAPER 1.0

Rectangle {
   id: root
   anchors.fill: parent
   color: "black"

   Image {
      id: backgroundImage
      anchors.fill: parent
      source: "qrc:/NuclearField.png"
   }

   TableView {
      id: minefieldGrid
      anchors.fill: parent
      width: root.width
      height: root.height
      model: SaperController.model

      delegate: Cell {
         required property int row
         required property int column

         isMine: model.isMine
         isRevealed: model.isRevealed
         isFlagged: model.isFlagged
         neighborMines: model.neighborMines
         implicitWidth: minefieldGrid.width / SaperController.getColsNo()
         implicitHeight: minefieldGrid.height/ SaperController.getRowsNo()
      }
   }

   GameResultDialog {
      id: gameResultDialog
      width: root.width * 0.7
      height: root.height * 0.2
      anchors.centerIn: root
      visible: SaperController.isGameOver
   }
}
