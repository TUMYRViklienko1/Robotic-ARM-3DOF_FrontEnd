
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
        color: "lightblue" // Set your desired background color here
        gradient: Gradient {
            GradientStop { position: 0.0; color: "red" }
            GradientStop { position: 0.02; color: "white" }

        }

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

    ColumnLayout{
        id:listLayout
        anchors.right: parent.right
        height: 350
        y: 300
        ListView {
            id: angleFromSlider
            width: 300
            height: 150
            focus: true
            clip: true

            model: personModel

            delegate:
                Item {
                implicitHeight: 30
                implicitWidth: angleFromSlider.width


                RowLayout {
                    Text {
                        id: step
                        text: model.step
                        font.bold: true
                    }
                    Text {
                        id: theta_1
                        text: model.theta_1
                        font.bold: true
                    }
                    Text {
                        id: theta_2
                        text: model.theta_2
                        font.bold: true
                    }
                    Text {
                        id: theta_3
                        text: model.theta_3
                        font.bold: true
                    }
                    Text {
                        id: claw
                        text: model.claw
                        font.bold: true
                    }
                }
                MouseArea {
                    id: doubleClick
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onDoubleClicked: {
                        console.log(model.index)
                        angleFromSlider.currentIndex = model.index
                        personModel.duplicateData(angleFromSlider.currentIndex)
                    }
                }

            }
            header: Rectangle {
                Text{
                    id:titleListView
                    text: "Slider value:"
                    font.bold: true
                    font.pixelSize: 10

                }
                anchors { left: parent.left; right: parent.right }
                height: 15
                color: "pink"
            }

            footer: Rectangle {
                anchors { left: parent.left; right: parent.right }
                height: 10
                color: "pink"
            }

            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5
            }
        }
        ListView {
            id: angleFromListView
            width: 300
            height: 150
            focus: true
            clip: true

            model: personModelAutoMode

            delegate:
                Item {
                implicitHeight: 30
                implicitWidth: angleFromSlider.width


                RowLayout {
                    Text {
                        text: model.step
                        font.bold: true
                    }
                    Text {
                        text: model.theta_1
                        font.bold: true
                    }
                    Text {
                        text: model.theta_2
                        font.bold: true
                    }
                    Text {
                        text: model.theta_3
                        font.bold: true
                    }
                    Text {
                        text: model.claw
                        font.bold: true
                    }

                }
                MouseArea {
                    id: doubleClickRemove
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onDoubleClicked: {
                        console.log(model.index)
                        personModelAutoMode.deleteRow(model.index)
                        //angleFromSlider.currentIndex = model.index
                    }
                }



            }
            header: Rectangle {
                Text{
                    text: "Auto mode value:"
                    font.pixelSize: 10
                    font.bold: true
                }
                anchors { left: parent.left; right: parent.right }
                height: 15
                color: "green"
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
        Text{
            text: "Auto mode:"
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

            MyButton {
                id: resset
                theta_1: 90
                theta_2: 90
                theta_3: 90
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

    RoboticArm {
        id: roboticArmView
        x: 310
        width: 1000
        height: 1000
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
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

    ColumnLayout {
        id: columnLayoutInverse
        anchors.left: parent.left
        width: 335
        height: 393
        visible: false
        anchors.verticalCenter: parent.verticalCenter
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
        RowLayout{
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
    ColumnLayout {//slider
        id: columnLayoutForward
        property int test
        anchors.left: parent.left
        width: 335
        height: 393
        anchors.verticalCenter: parent.verticalCenter
        visible: true

        function toggleFocus(node) {
            node.isFocused = !node.isFocused;
        }

        SliderAngle {
            id: __sliderWaist
            sliderNameText: "θ1"
            recColor: "#66d263"
            slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(waistNode)
        }
        SliderAngle {
            id: __sliderShoulder
            sliderNameText: "θ2"
            recColor: "#e75151"
            slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(shoulderNode)
        }
        SliderAngle {
            id: __sliderElbow
            sliderNameText: "θ3"
            recColor: "#5362f4"
            slider.onActiveFocusChanged: columnLayoutForward.toggleFocus(elbowNode)
        }
    }


    Item {
        id: __materialLibrary__
    }
}
