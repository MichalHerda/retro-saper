import QtQuick 2.15
import SAPER 1.0

Rectangle {
   id: root
   anchors.fill: parent
   color: "black"

   Column {
      id: minefieldColumn
      anchors.fill: parent

      Repeater {
         id: minefieldRep
         model: SaperController.getRowsNo()
            Row {
               id: minefieldRow
               Repeater {
                  model: SaperController.getColsNo()

                  Rectangle {
                     id: minefieldRec
                     color: "black"
                     border {
                        color: "blue"
                        width: minefieldRec.width * 0.05
                     }
                     width: minefieldColumn.width / SaperController.getColsNo()
                     height: minefieldColumn.height / SaperController.getRowsNo()
                     // binduj tu stan komórki z modelu przez kontroler
                   }
               }
           }
      }
   }
}
