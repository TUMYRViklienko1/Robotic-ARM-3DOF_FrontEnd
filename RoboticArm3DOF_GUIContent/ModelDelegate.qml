import QtQuick 6.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import backEnd.com 1.0

Rectangle {
    width: angleFromSlider.width
    height: 40
    color: "#434343" // Black background for each row
    property alias flagForLoader: addToAutoMode.visible
    RowLayout {
        anchors.fill: parent
        anchors.margins: 5

        Text {
            id: claw
            text: model.claw
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: angleFromSlider.width / 4
        }
        Text {
            id: theta_1
            text: model.theta_1
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: angleFromSlider.width / 4
        }
        Text {
            id: theta_2
            text: model.theta_2
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: angleFromSlider.width / 4
        }
        Text {
            id: theta_3
            text: model.theta_3
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: angleFromSlider.width / 4
        }
    }
    MouseArea {
        id: addToAutoMode
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        visible: true
        onDoubleClicked: {
            console.log(model.index)
            angleFromSlider.currentIndex = model.index
            personModel.duplicateData(angleFromSlider.currentIndex)
        }
    }
    MouseArea {
        id: deleteFromAutoMode
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        visible: (addToAutoMode.visible == true) ? false : true
        onDoubleClicked: {
            console.log(model.index)
            angleFromSlider.currentIndex = model.index
            personModelAutoMode.deleteRow(angleFromSlider.currentIndex)

        }
    }
}

