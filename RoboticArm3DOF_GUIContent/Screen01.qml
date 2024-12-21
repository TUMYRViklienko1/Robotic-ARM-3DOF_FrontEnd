
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15

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
    color: Constants.backgroundColor // Set your desired background color here

    property bool flag: false

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
            Layout.preferredHeight: rootGridLayout.height

            padding: 10
            background: Rectangle {
                color: Constants.textColor
            }
            // CustomDropDown{
            // id: dropDown
            // }

            RoboticArm {
                id: roboticArmView
                // width: Constants.width/2.5
                // height: (parent.height - (Constants.spacing * (rootGridLayout.rows - 1)) - Constants.spacing*2) * 1.0

                anchors.fill: parent
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

            Layout.fillHeight: true

            Layout.preferredWidth: 400
           // Layout.preferredHeight: 120
            padding: 10
            background: Rectangle {
                radius: 3
                color: Constants.blockColor
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
                    Layout.fillWidth: true


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
                    Layout.fillWidth: true

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
                    Layout.fillWidth: true

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
            Layout.fillHeight: true

            Layout.preferredWidth: 400
            Layout.preferredHeight: 250
            padding: 10
            background: Rectangle {
                radius: 3
                color: Constants.blockColor
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
            Layout.fillHeight: true

            Layout.preferredWidth: 400
            Layout.preferredHeight: 400


            padding: 10

            background: Rectangle {
                radius: 3
                color: Constants.blockColor
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
                radius: 3
                color: Constants.blockColor
            }


            GridLayout{
                anchors.fill: parent
                columns: 2 // Define 3 columns
                columnSpacing: 5
                rowSpacing: 5
                MyButton {
                    id: save

                    Layout.column: 0
                    Layout.row: 0
                    Layout.fillWidth: true

                    title: "Save"
                    onClicked: FileHandler.saveToFileSlot()
                }

                MyButton {
                    id: saveAs

                    Layout.column: 1
                    Layout.row: 0
                    Layout.fillWidth: true

                    title: "Save As"
                    onClicked: FileHandler.saveAsToFileSlot()
                }

                MyButton {
                    id: upload

                    Layout.column: 0
                    Layout.columnSpan: 2
                    Layout.row: 1
                    Layout.fillWidth: true

                    title: "Upload"
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
                radius: 3
                color: Constants.blockColor
            }

            Text {
                text: "File Explorer"
                anchors.centerIn: parent
                color: Constants.textColor
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
                color: Constants.blockColor
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true

                // Title
                Text {
                    Layout.preferredHeight: 40 // Specify a fixed height for the title
                    Layout.alignment: Qt.AlignTop
                    text: "Current orders:"
                    color: Constants.textColor
                    font.pixelSize: 20
                }

                // ListView scales to the remaining height
                ListView {
                    id: angleFromSlider
                    Layout.preferredHeight: 300 // Allow it to take up the remaining space
                    Layout.preferredWidth: 250
                    Layout.fillWidth: true
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
                                color: Constants.textColor
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 1"
                                color: Constants.textColor
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 2"
                                color: Constants.textColor
                                font.bold: true
                                Layout.alignment: Qt.AlignLeft
                                Layout.preferredWidth: angleFromSlider.width / 4
                            }
                            Text {
                                text: "Theta 3"
                                color: Constants.textColor
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
