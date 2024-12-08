

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
        text: ""
        visible:  title.text === "" ? false : true
        font.pixelSize: 20
    }

    Rectangle {
        id: rectangle
        width: 50
        height: 35
        color: "white"
        TextInput {
            id: textInput
            anchors.fill: parent
            anchors.centerIn: parent
            text: "1"
            font.pixelSize: 12

        }
    }
}
