import QtQuick 6.7
import QtQuick.Layouts
import backEnd.com 1.0
import QtQuick.Controls 2.15
Item {
    id: rootler

    property alias sliderWaist: __sliderWaist
    property alias sliderShoulder: __sliderShoulder
    property alias sliderElbow: __sliderElbow
    property bool clawMode: true

    readonly property color clawActiveColor: "#79acc7"
    readonly property color clawCloseColor: "#8f8f8f"

    function sendAngles(theta_1,theta_2,theta_3,claw){
        console.log("sendAngles11 called with angles:", theta_1, theta_2, theta_3, claw);

        SliderHender.onSliderValueChanged(theta_1,theta_2,theta_3,claw);
    }
    function toggleFocus(node) {
        node.isFocused = !node.isFocused;
    }

    states: [
        State {
            name: "open"
            when: clawMode
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
            when: !clawMode
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



    ColumnLayout{
        Text{
            id:title
            font.pixelSize: 20
            color:"white"
            text:"Controller:"
        }
        SliderAngle {
            id: __sliderWaist
            sliderNameText: "θ1"
            slider.onActiveFocusChanged: cellController.toggleFocus(waistNode)
        }
        SliderAngle {
            id: __sliderShoulder
            sliderNameText: "θ2"
            slider.onActiveFocusChanged: cellController.toggleFocus(shoulderNode)
        }
        SliderAngle {
            id: __sliderElbow
            sliderNameText: "θ3"
            slider.onActiveFocusChanged: cellController.toggleFocus(elbowNode)
        }


        RowLayout{
            Text{
                id:gripperTitle
                font.pixelSize: 15
                color:"white"
                text:"Gripper:"
            }
            Button {
                id: gripperOpen
                Layout.minimumWidth: 30 // Ensure a reasonable minimum width
                onClicked: {
                    clawMode = true
                    SliderHender.onSliderValueChanged(controllerForward.sliderWaist.sliderValue,
                                                      controllerForward.sliderShoulder.sliderValue,
                                                      controllerForward.sliderElbow.sliderValue,clawMode);

                    gripperTitleOpen.color = clawActiveColor
                    gripperTitleClose.color = clawCloseColor
                }
                //Layout.fillWidth: true
                background: Rectangle {
                    color: "transparent"
                    Text {
                        id: gripperTitleOpen
                        font.pixelSize: 13
                        color: clawActiveColor
                        text: "OPEN"

                    }

                }
            }

            Text{
                id: spacer
                font.pixelSize: 15
                color:"white"
                text:" |"
            }
            Button {
                id: gripperClose
                Layout.minimumWidth: 30 // Ensure a reasonable minimum width
                //Layout.fillWidth: true

                onClicked: {
                    clawMode = false
                    SliderHender.onSliderValueChanged(controllerForward.sliderWaist.sliderValue,
                                                      controllerForward.sliderShoulder.sliderValue,
                                                      controllerForward.sliderElbow.sliderValue,clawMode);
                    gripperTitleClose.color = clawActiveColor
                    gripperTitleOpen.color = clawCloseColor
                }

                background: Rectangle {
                    color: "transparent"
                    Text {
                        id:gripperTitleClose
                        font.pixelSize: 13
                        color: clawCloseColor
                        text: "CLOSE"
                    }
                }
            }

        }
    }

}
