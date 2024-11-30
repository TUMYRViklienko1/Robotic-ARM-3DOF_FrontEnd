
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
Pane {
    id: root
    width: Constants.width // Set default width if Constants is not defined
    height: Constants.height
    // Set default height if Constants is not defined
    Material.theme: switchDarkMode.checked ? Material.Dark : Material.Light
    background: Rectangle {
        color: "#fbfcfc" // Set your desired background color here


    }


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
        waistAngle: __sliderWaist.slider.value
        shouldertAngle: __sliderShoulder.slider.value
        elbowAngle: __sliderElbow.slider.value
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
            SliderHender.onSliderValueChanged(__sliderWaist.slider.value,
                                              __sliderShoulder.slider.value,
                                              __sliderElbow.slider.value,!checked);
        }
    }




    KinematicMode {
        id: kinematicMode
        x: 200
    }

    RowLayout{
        id:rootRowLayout
        anchors.fill: parent

        RoboticArm {
            id: roboticArmView
            width: Constants.width/2
            height: 750
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

        Rectangle{
            height: 750
            width:1334/2
            color: "#212121"

            ColumnLayout{
                id:listLayout
                width: Constants.width/2
                Item {
                    id: rootGrid
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

                        MyButton {
                            id: resset
                            theta_1: 90
                            theta_2: 90
                            theta_3: 90
                            claw: 1
                            title: "Reset"
                        }

                        MyButton {
                            id: position1
                            theta_1: 55
                            theta_2: 120
                            theta_3: 10
                            claw: 1
                            title: "position1"

                        }

                        MyButton {
                            id: position2
                            theta_1: 90
                            theta_2: 24
                            theta_3: 160
                            claw: 0
                            title: "position2"

                        }

                        MyButton {
                            id: position3
                            theta_1: 30
                            theta_2: 13
                            theta_3: 120
                            claw: 1
                            title: "position3"

                        }
                        MyButton {
                            id: save
                            title: "save"
                            onClicked: FileHandler.saveToFile()
                        }

                        MyButton {
                            id: upload
                            title: "upload"
                            onClicked: FileHandler.loadFromFile()
                        }
                    }
                }
                ColumnLayout {//slider
                    id: columnLayoutForward
                    property int test
                    width: 335
                    height: 393
                    visible: true

                    function toggleFocus(node) {
                        node.isFocused = !node.isFocused;
                    }

                    SliderAngle {
                        id: __sliderWaist
                        sliderNameText: "θ1"
                        slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(waistNode)
                    }
                    SliderAngle {
                        id: __sliderShoulder
                        sliderNameText: "θ2"
                        slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(shoulderNode)
                    }
                    SliderAngle {
                        id: __sliderElbow
                        sliderNameText: "θ3"
                        slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(elbowNode)
                    }
                }
                ColumnLayout {
                    id: columnLayoutInverse
                    width: 335
                    height: 393
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
                RowLayout{
                    ListView {
                        id: angleFromSlider
                        width: 300
                        height: 300
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
                            height: 40
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
                            height: 10
                            color: "#2b2b2b"
                        }

                        highlight: Rectangle {
                            color: "#323232"
                            radius: 5
                        }
                    }

                    ListView {
                        id: angleFromListView
                        width: 300
                        height: 300
                        focus: true
                        clip: true

                        model: personModelAutoMode

                        // Reusing the same delegate from the first ListView
                        delegate:Loader {
                            id: deleteLoader
                            source: "ModelDelegate.qml"
                            active: true
                            onLoaded: {
                                if (item) {
                                    item.flagForLoader = false;
                                }
                            }
                        }
                        header: Rectangle {
                            width: angleFromListView.width
                            height: 40
                            color: "green"

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 5
                                Text {
                                    text: "Claw"
                                    color: "white"
                                    font.bold: true
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredWidth: angleFromListView.width / 4
                                }
                                Text {
                                    text: "Theta 1"
                                    color: "white"
                                    font.bold: true
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredWidth: angleFromListView.width / 4
                                }
                                Text {
                                    text: "Theta 2"
                                    color: "white"
                                    font.bold: true
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredWidth: angleFromListView.width / 4
                                }
                                Text {
                                    text: "Theta 3"
                                    color: "white"
                                    font.bold: true
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredWidth: angleFromListView.width / 4
                                }
                            }
                        }

                        footer: Rectangle {
                            anchors { left: parent.left; right: parent.right }
                            height: 10
                            color: "green"
                        }

                        highlight: Rectangle {
                            color: "lightsteelblue"
                            radius: 5
                        }
                    }

                }
                Text{
                    text: "Auto mode:"
                    color: "white"
                    font.pixelSize: 32

                }
                RowLayout{
                    id:autoRowLayout

                    InverseTextInput {
                        id:delay
                        recColor: "#5362f4"
                    }
                    MyButton {
                        id: autoModeStartButton
                        title: "Auto"
                        //backgroundDefultColor: "#eb984e"
                        onPressed: {
                            stopButton.autoModeIsRunning = true
                            sizeAutoMode = AutoModeModel.getSize()-1;
                            startAutoMode()
                        }
                    }

                    MyButton{
                        id:stopButton
                        title: "Stop"
                        // backgroundDefultColor: "#e74c3c"
                        onPressed: autoModeIsRunning = !autoModeIsRunning
                    }

                }
            }


        }
    }







    Item {
        id: __materialLibrary__
    }
}
