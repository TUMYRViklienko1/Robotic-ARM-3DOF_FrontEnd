import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ComboBox {
    id: root
    textRole: "text"
    model: ListModel {
        id: model
        ListElement {

            Switch{}

        }
        ListElement {

            text: "Apple"

        }
        ListElement {

            text: "Coconut"

        }
    }
    implicitHeight: 55
    implicitWidth: 100

    property real radius: 5
    property color backgroundColor: "#282828"

    property color checkedColor: "#121212"

    delegate: ItemDelegate {
        id: itemDelegate
        width: root.implicitWidth * 1.2
        height: root.implicitHeight
        hoverEnabled: true
        focus: true

        background: Rectangle {
            anchors.fill: parent
            radius: 2
            color: itemDelegate.hovered ? root.backgroundColor : "transparent"
        }

        RowLayout {
            Layout.alignment: Qt.AlignVCenter
            width: parent.width
            height: parent.height
            anchors.fill: parent
            spacing: 10
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Label {
                opacity: 0.9
                text: modelData
                font.pixelSize: 15
                color: itemDelegate.hovered ? "#FFFFFF" : "#FFFFFF"
                Layout.fillWidth: true
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 10
            }
        }
    }

    contentItem: Item {
        width: root.background.width - root.indicator.width - 10
        height: root.background.height
        RowLayout {
            anchors.fill: parent
            spacing: 10
            Label {
                opacity: 0.9
                text: root.displayText
                font.pixelSize: 15
                Layout.fillWidth: true
                verticalAlignment: Image.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 10
                color: "#FFFFFF"
            }
        }
    }

    background: Rectangle {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        color: root.down ? Qt.darker(root.checkedColor,
                                     1.2) : root.checkedColor
        radius: root.radius
        border.width: root.activeFocus ? 2 : 0.6
        border.color: root.activeFocus ? "black" : "black"
    }

    popup: Popup {
        y: root.height + 2
        width: root.implicitWidth * 1.26
        implicitHeight: contentItem.implicitHeight > 250 ? 250 : contentItem.implicitHeight
        padding: 4
        contentItem: ListView {
            leftMargin: 5
            implicitHeight: contentHeight
            keyNavigationEnabled: true
            model: root.popup.visible ? root.delegateModel : null
            clip: true
            focus: true
            currentIndex: root.highlightedIndex
        }

        background: Rectangle {
            anchors.fill: parent
            color: root.down ? Qt.darker(root.checkedColor,
                                         1.2) : root.checkedColor
            radius: 6
            border.width: 0.6
            border.color: backgroundColor
            clip: true
        }
    }
}
