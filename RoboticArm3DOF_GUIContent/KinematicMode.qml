import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 6.7


RowLayout {
    id: root
    property alias forward: forward
    property alias inverse: inverse
    Button {
        id: forward
        text: qsTr("Forward")
        onClicked: {
        columnLayoutForward.visible = true
            columnLayoutInverse.visible =  false
        }
    }

    Button {
        id: inverse
        text: qsTr("Inverse")
        onClicked: {
        columnLayoutForward.visible = false
            columnLayoutInverse.visible =  true
        }
    }

}

