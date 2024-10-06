import QtQuick 2.15
import QtQuick.Controls 2.15
import backEnd.com 1.0

Button {
    id: root
    property color backgroundDefultColor: "red"
    property real lightenFactor: 1.3 // Factor to lighten the color (default is 1.3 for moderate lightening)
    text: "text"
    implicitWidth: 103
    implicitHeight: 47
    background: Rectangle {
        radius: 3
        // Apply lighter color when button is not pressed
        color: root.down ? Qt.lighter(
                               root.backgroundDefultColor,
                               root.lightenFactor) : root.backgroundDefultColor
    }
}
