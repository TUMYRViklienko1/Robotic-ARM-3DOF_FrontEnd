import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import backEnd.com 1.0
RowLayout {
    id: rowLayout
    spacing: 10
    clip: false
    layer.enabled: false
    focus: false

    // Property aliases
    property alias sliderNameText: sliderName.text
    property alias textInputValue: textInput.text
    property alias slider: root
    function sendAngles(theta_1,theta_2,theta_3,claw){

        SliderHender.onSliderValueChanged(theta_1,theta_2,theta_3,claw);
    }

    Text {
        id: sliderName
        text: "text"
        color: "white"

        font.pointSize: 15
    }

    Rectangle {
        id: rectangle
        width: 90
        height: 40
        radius: 5
        border.color: "#4d5656"
        border.width: 2
        color: "#f4f6f7"
              TextInput {
            id: textInput

            text: "90"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            onTextChanged: {
                root.value = parseFloat(textInput.text);
            }
        }
    }


    Text {
        id: startValueSlider
        text: "0°"
        color: "white"
        font.pointSize: 15
    }


    Slider {

        id: root
        value: 90
        wheelEnabled: true
        stepSize: 1
        from: 0
        to: 180

        onValueChanged: {
            textInput.text = value.toFixed(0);
            if(!flag)
            {
                sendAngles(__sliderWaist.slider.value, __sliderShoulder.slider.value ,
                           __sliderElbow.slider.value,__clawToggle.checked);
            }
        }
    }


    Text {
        id: endValueSlider
        text: "180°"
        color: "white"

        font.pointSize: 15
    }

}
