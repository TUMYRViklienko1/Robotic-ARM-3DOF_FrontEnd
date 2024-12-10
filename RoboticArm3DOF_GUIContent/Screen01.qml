
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.0

import QtQuick.Controls 6.7
import QtQuick3D.Effects 6.7
import QtQuick3D.Helpers 6.7
import RoboticArm3DOF_GUI 1.0
import QtQuick.Layouts 1.0
import Generated.QtQuick3D.RoboticArm3
import QtQuick.Controls.Material
import backEnd.com 1.0
import QtQml
Rectangle {
    id: root
    width: Constants.width // Set default width if Constants is not defined
    height: Constants.height
    // Set default height if Constants is not defined
    Material.theme: switchDarkMode.checked ? Material.Dark : Material.Light
    color: "#404244" // Set your desired background color here
    // background: Rectangle {



    // }


    property bool flag: false
    states: [
        State {
            name: "open"
            when: !(__clawToggle.checked)
            PropertyChanges {
                target: backend

                clawMove: 1050
                clawAngle: 0
            }
            PropertyChanges {
                target: clawNode
                isFocused: false
            }
        },
        State {
            name: "close"
            when: __clawToggle.checked
            PropertyChanges {
                target: backend

                clawMove: 0
                clawAngle: 45
            }
            PropertyChanges {
                target: clawNode
                isFocused: true
            }
        }
    ]
    Backend {
        id: backend
        waistAngle: controllerForward.sliderWaist.sliderValue
        shouldertAngle: controllerForward.sliderShoulder.sliderValue
        elbowAngle: controllerForward.sliderElbow.sliderValue
        clawAngle: 45
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
        onClicked: {
            SliderHender.onSliderValueChanged(controllerForward.sliderWaist.sliderValue,
                                              controllerForward.sliderShoulder.sliderValue,
                                              controllerForward.sliderElbow.sliderValue,!__clawToggle.checked);
        }
    }

    KinematicMode {
        id: kinematicMode
        x: 200
    }



    GridLayout {
        id: rootGridLayout
        anchors.fill: parent
        columns: 3 // Define 3 columns
        columnSpacing: Constants.spacing
        rowSpacing: Constants.spacing

        // Left red rectangle spans all 3 rows
        Frame {
            id: cellRobotic
            Layout.column: 0
            Layout.row: 0
            Layout.rowSpan: 3
            Layout.preferredWidth: 400
            Layout.preferredHeight: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1))) * 1.0
            padding: 10
            background: Rectangle {
                color: "white"
            }


            RoboticArm {
                id: roboticArmView
                width: Constants.width/2.5
                height: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1))) * 1.0
                waistRotation: backend.waistAngle
                shoulderRotation: backend.shouldertAngle
                elbowRotation: backend.elbowAngle


                clawRotation: backend.clawAngle
                clawMove: backend.clawMove

                NodeJointForm {
                    id: waistNode
                    titleNode: "θ1"
                    scenePosition: roboticArmView.waistJointCord
                }
                NodeJointForm {

                    id: shoulderNode
                    titleNode: "θ2"
                    scenePosition: roboticArmView.shoulderJointCord
                }
                NodeJointForm {
                    id: elbowNode
                    titleNode: "θ3"
                    scenePosition: roboticArmView.elbowJointCord
                }
                NodeJointForm {
                    id: clawNode
                    titleNode: "Claw"
                    scenePosition: Qt.vector3d(roboticArmView.clawJointCord.x , roboticArmView.clawJointCord.y +30,roboticArmView.clawJointCord.z + 20)
                }
            }
        }

        // Column 1 black rectangles
        Frame {
            id: cellPosition
            Layout.column: 1
            Layout.row: 0
            Layout.preferredWidth: 400
            Layout.preferredHeight: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1))) * 0.2
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }


            GridLayout{
                anchors.fill: parent
                columns: 3 // Define 3 columns
                columnSpacing: 5
                rowSpacing: 5
                MyButton {
                    id: position1
                    Layout.column: 0
                    Layout.row: 0


                    theta_1: 30
                    theta_2: 13
                    theta_3: 120
                    claw: 1
                    title: "Pos. 1"
                }

                MyButton {
                    id: position2
                    Layout.column: 1
                    Layout.row: 0

                    theta_1: 55
                    theta_2: 120
                    theta_3: 10
                    claw: 1
                    title: "Pos. 2"

                }

                MyButton {
                    id: position3
                    Layout.column: 2
                    Layout.row: 0

                    theta_1: 90
                    theta_2: 24
                    theta_3: 160
                    claw: 0
                    title: "Pos. 3"

                }

                MyButton {
                    id: resset
                    Layout.column: 0
                    Layout.columnSpan: 3
                    Layout.row: 1
                    Layout.fillWidth: true

                    theta_1: 90
                    theta_2: 90
                    theta_3: 90
                    claw: 1
                    title: "Reset"
                }
            }

        }

        Frame {
            id: cellController
            Layout.column: 1
            Layout.row: 1
            Layout.preferredWidth: 400
            Layout.preferredHeight: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1))) * 0.35
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }

            function toggleFocus(node) {
                node.isFocused = !node.isFocused;
            }
            Controller {
                id: controllerForward

                visible: true
                Layout.fillWidth: true // Make it fill the width of the ColumnLayout
                Layout.fillHeight: true // Make it fill the height of the ColumnLayout
            }

            ColumnLayout {
                id: columnLayoutInverse
                Layout.fillWidth: true // Make it fill the width of the ColumnLayout
                Layout.fillHeight: true // Make it fill the height of the ColumnLayout
                visible: false
                RowLayout{
                    id:rowLayoutTextInverse
                    InverseTextInput {
                        id:__xCords
                        title: "X:"
                        recColor: "#e75151"
                    }
                    InverseTextInput {
                        id:__yCords
                        title: "Y:"
                        recColor: "#66d263"
                    }
                    InverseTextInput {
                        id:__zCords
                        title: "Z:"
                        recColor: "#5362f4"
                    }
                }
                MyButton{
                    id:inversSendCords
                    title: "Upload"
                    Connections{
                        target: inversSendCords
                        onPressed:{
                            InverseTest.setToStruct(__xCords.valueCord,__yCords.valueCord,__zCords.valueCord)
                            let [angle1, angle2, angle3] = InverseTest.inverseCalculator()
                            position1.setAngelsToSlider( angle1,angle2,angle3, 0)
                        }
                    }
                }
            }


        }

        Frame {
            id: cellAutoMode
            Layout.column: 1
            Layout.row: 2
            Layout.preferredWidth: 400
            Layout.preferredHeight: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1))) * 0.45
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }


            AutomaticMode{
                id:automaticMode
            }
        }

        // Right green rectangle spans all 3 rows
        Frame {
            id: cellFileExortImport
            Layout.column: 2
            Layout.row: 0
            Layout.preferredWidth: 290
            Layout.preferredHeight: cellPosition.height
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }

            RowLayout{
                MyButton {
                    id: save
                    title: "save"
                    onClicked: FileHandler.saveAsToFileSlot()
                }

                MyButton {
                    id: upload
                    title: "upload"
                    onClicked: FileHandler.openFile()
                }
            }
        }

        Frame {
            id: cellFileExplorer
            Layout.column: 2
            Layout.row: 1
            Layout.preferredWidth: 290
            Layout.preferredHeight: cellController.height
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }

            Text {
                text: "File Explorer"
                anchors.centerIn: parent
                color: "white"
            }
        }

        Frame {
            id: cellCurrentMode
            Layout.column: 2
            Layout.row: 2
            Layout.preferredWidth: 290
            Layout.preferredHeight: cellAutoMode.height
            padding: 10
            background: Rectangle {
                color: Constants.backgroundColor
            }

            ColumnLayout{

                Text{
                    text: "Current orders:"
                    color: "white"
                    font.pixelSize: 20
                }
                ListView {
                    id: angleFromSlider
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 200
                    focus: true
                    clip: true

                    model: personModel

                    delegate: Loader {
                        id: addLoader
                        source: "ModelDelegate.qml"
                        active: true
                        onLoaded: {
                            if (item) {
                                item.flagForLoader = true;
                            }
                        }
                    }
                    header: Rectangle {
                        width: angleFromSlider.width
                        height: 30
                        color: "#2b2b2b"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 5
                            Text {
                                text: "Claw"
                                color: "white"
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 1"
                                color: "white"
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 2"
                                color: "white"
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 3"
                                color: "white"
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                        }
                    }

                    footer: Rectangle {
                        anchors { left: parent.left; right: parent.right }
                        height: 15
                        color: "#2b2b2b"
                    }

                    highlight: Rectangle {
                        color: "#323232"
                        radius: 5
                    }
                }
            }
        }
    }




    Item {
        id: __materialLibrary__
    }
}
