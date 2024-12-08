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
                //Layout.fillWidth: true
                background: Rectangle {
                    color: "transparent"
                    Text {
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
