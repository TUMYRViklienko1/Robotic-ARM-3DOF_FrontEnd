

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import RoboticArm3DOF_GUI 1.0
import QtQuick.Layouts 1.0
import Generated.QtQuick3D.RoboticArm3
import QtQuick.Controls.Material 2.15

Pane {
    id: root
    width: Constants.width
    height: Constants.height
    Material.theme: switchDarkMode.checked ? Material.Dark : Material.Light
    Backend {
        id: backend
        waistAngle: __sliderWaist.textInputValue
        shouldertAngle: __sliderShoulder.textInputValue
        elbowAngle: __sliderElbow.textInputValue
    }
    ToggleDark {
        id: switchDarkMode
    }

    RoboticArm {
        id: roboticArmView
        width: 1000
        height: 1000
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
        waistRotation: backend.waistAngle
        shoulderRotation: backend.shouldertAngle
        elbowRotation: backend.elbowAngle
    }

    ColumnLayout {
        id: columnLayout
        anchors.left: parent.left
        width: 335
        height: 393
        anchors.verticalCenter: parent.verticalCenter

        SliderAngle {
            id: __sliderWaist
            sliderNameText: "θ1"
            recColor: "#66d263"
        }
        SliderAngle {
            id: __sliderShoulder
            sliderNameText: "θ2"
            recColor: "#e75151"
        }
        SliderAngle {
            id: __sliderElbow
            sliderNameText: "θ3"
            recColor: "#5362f4"
        }
    }

    Item {
        id: __materialLibrary__
    }
}
