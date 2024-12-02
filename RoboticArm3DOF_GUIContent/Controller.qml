import QtQuick 6.7
import QtQuick.Layouts
import backEnd.com 1.0
Item {
    id: controller

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

}
