

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ColumnLayout {
    id: columnLayout
    property alias recColor: rectangle.color
    property alias title: title.text
    property alias valueCord: textInput.text
    Text {
        id: title
        text: qsTr("Text")
        font.pixelSize: 20
    }

    Rectangle {
        id: rectangle
        width: 100
        height: 40
        color: "red"
        radius: 5
        TextInput {
            id: textInput

            width: 80
            height: 20
            text: "1"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter

        }
    }
}
