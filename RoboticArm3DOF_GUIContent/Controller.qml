import QtQuick 6.7
import QtQuick.Layouts
import backEnd.com 1.0
import QtQuick.Controls 2.15
Item {
    id: rootler

    property alias sliderWaist: __sliderWaist
    property alias sliderShoulder: __sliderShoulder
    property alias sliderElbow: __sliderElbow
    function sendAngles(theta_1,theta_2,theta_3,claw){
        SliderHender.onSliderValueChanged(theta_1,theta_2,theta_3,claw);
    }
    function toggleFocus(node) {
        node.isFocused = !node.isFocused;
    }

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
                Connections{
                    target: gripperOpen
                    onClicked: {
                        SliderHender.onSliderValueChanged(controllerForward.sliderWaist.sliderValue,
                                                          controllerForward.sliderShoulder.sliderValue,
                                                          controllerForward.sliderElbow.sliderValue,!__clawToggle.checked);
                        titleButton.color = "red"

                    }
                }
                //Layout.fillWidth: true
                background: Rectangle {
                    color: "transparent"
                    Text {
                        id: titleButton
                        font.pixelSize: 13
                        color: "white"
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
                    SliderHender.onSliderValueChanged(controllerForward.sliderWaist.sliderValue,
                                                      controllerForward.sliderShoulder.sliderValue,
                                                      controllerForward.sliderElbow.sliderValue,!__clawToggle.checked);
                }

                background: Rectangle {
                    color: "transparent"
                    Text {
                        font.pixelSize: 13
                        color: "white"
                        text: "CLOSE"
                    }
                }
            }

        }
    }

}
