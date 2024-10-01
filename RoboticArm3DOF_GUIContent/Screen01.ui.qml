
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
    width: Constants.width // Set default width if Constants is not defined
    height: Constants.height // Set default height if Constants is not defined
    Material.theme: switchDarkMode.checked ? Material.Dark : Material.Light
    states: [
        State {
            name: "open"
            when: __clawToggle.checked
            PropertyChanges {
                target: backend
                clawAngle: 45
            }
        },
        State {
            name: "close"
            when: !(__clawToggle.checked)
            PropertyChanges {
                target: backend
                clawAngle: 0
            }
        }
    ]
    Backend {
        id: backend
        waistAngle: __sliderWaist.textInputValue
        shouldertAngle: __sliderShoulder.textInputValue
        elbowAngle: __sliderElbow.textInputValue
        clawAngle: 0
    }

    ToggleDark {
        id: switchDarkMode
        text: qsTr("Dark mode")
    }
    ToggleDark {
        id: __clawToggle
        x: 0
        y: 46
        checked: false
        text: qsTr("<b>Claw<b/>")
    }
    Item {
        id: rootGrid
        x: 1006
        y: -12
        width: 316
        height: 202

        GridLayout {
            id: gridLayout
            anchors.fill: parent
            layer.enabled: false
            clip: false
            rowSpacing: 3
            columnSpacing: 3
            rows: 0
            columns: 2

            ButtonPosition {
                id: resset
                theta_1: 0
                theta_2: 0
                theta_3: 0
                text: "Reset"
            }

            ButtonPosition {
                id: position1
                theta_1: -55
                theta_2: 30
                theta_3: 57
                text: "position1"
            }

            ButtonPosition {
                id: position2
                theta_1: 90
                theta_2: 24
                theta_3: 90
                text: "position3"
            }

            ButtonPosition {
                id: position3
                theta_1: -2
                theta_2: -43
                theta_3: 90
                text: "position3"
            }
        }
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
        clawRotation: backend.clawAngle
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
