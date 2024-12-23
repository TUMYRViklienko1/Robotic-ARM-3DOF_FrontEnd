

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick3D
import QtQuick.Controls.Material 2.15
ColumnLayout {
    property alias titleNode: titleNode.text
    property alias borderColor: nodeBorder.color
    property vector3d screenPosition
    property vector3d scenePosition
    property View3D view3D: parent
    property bool isFocused: false

    id: root

    x: screenPosition.x - width/2
    y: screenPosition.y - height/2
    z: screenPosition.z
    states:[
        State {
            name: "inActive"; when: isFocused === false
            PropertyChanges {
                target: nodeBorder
                border.color:"#595959"

            }
            PropertyChanges {
                target: titleNode
                color:"#595959"

            }
        },
        State {
            name: "Active"; when: isFocused === true
            PropertyChanges {
                target: nodeBorder
                border.color:"#34abd3"
            }
            PropertyChanges {
                target: titleNode
                color: "#34abd3"

            }
        }

    ]
    Text {
        id: titleNode
        x: 40
        y: -27
        text: qsTr("text")
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }
    Rectangle {
        id: nodeBorder
        width: 60
        height: 60
        color: "#00000000"
        radius: width/2

        //border.color: "#595959"
        border.width: 3
    }

    Item {
        id: __materialLibrary__
    }
    Component.onCompleted:  {
        screenPosition =  Qt.binding(function() {
            let w = view3D.width // force the binding to update when width or height changes
            let h = view3D.height

            return view3D.mapFrom3DScene(scenePosition)
        } )
    }
}
