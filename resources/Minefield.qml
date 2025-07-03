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

   //Column {
   //   id: minefieldColumn
   //   anchors.fill: parent

      /*
      Repeater {
         id: minefieldRep
         model: SaperController.getRowsNo()
            Row {
               id: minefieldRow
               Repeater {
                  model: SaperController.getColsNo()

                  Cell {
                     id: mineFieldCell
                     width: minefieldColumn.width / SaperController.getColsNo()
                     height: minefieldColumn.height / SaperController.getRowsNo()
                  }
               }
            }
      }
      */
      GridView {
          id: minefieldGrid
          anchors.fill: parent
          cellWidth: root.width / SaperController.getColsNo()
          cellHeight: root.height / SaperController.getRowsNo()
          model: SaperController.model

          delegate: Cell {
              isMine: model.isMine
              isRevealed: model.isRevealed
              isFlagged: model.isFlagged
              neighborMines: model.neighborMines
              width: minefieldGrid.cellWidth
              height: minefieldGrid.cellHeight
          }
      }
   //}
}
