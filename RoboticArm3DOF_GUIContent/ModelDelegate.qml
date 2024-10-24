import QtQuick 6.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import backEnd.com 1.0

Item{
    id:root
    required property string theta_1
    required property string theta_2
    required property string theta_3
    required property string step
    width: 300
    height:15

    RowLayout {
        Text {
            text: step  // Accessing name role from C++ model
            font.bold: true
        }
        Text {
            text: theta_1  // Accessing name role from C++ model
            font.bold: true
        }
        Text {
            text: theta_2  // Accessing name role from C++ model
            font.bold: true
        }
        Text {
            text: theta_3  // Accessing name role from C++ model
            font.bold: true
        }
    }

    MouseArea{
        id: doubleClick
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

           onDoubleClicked:(mouse, model)=> {
               if(mouse.button === Qt.LeftButton) {
                personModel.duplicateData(step)
               }
           }
    }

}
