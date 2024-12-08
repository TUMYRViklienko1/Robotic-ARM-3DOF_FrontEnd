import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
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
    property int sliderValue: root.value


    Text {
        id: sliderName
        text: "text"
        color: "white"

        font.pointSize: 15
    }

    Rectangle {
        id: rectangle
        width: 60
        height: 40
        color: "white"
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

        handle: Rectangle {
            x: root.leftPadding + (root.horizontal ? root.visualPosition * (root.availableWidth - width) : (root.availableWidth - width) / 2)
            y: root.topPadding + (root.vertical ? root.visualPosition * (root.availableHeight - height) : (root.availableHeight - height) / 2)

            implicitWidth: 4
            implicitHeight: 12


            border.width: root.pressed ? width/2 : 1
            border.color: root.background.color
            color: body.color
            Behavior on border.width { SmoothedAnimation {} }
        }

        background: Rectangle {
            id:body
            x: (root.width  - width) / 2
            y: (root.height - height) / 2

            implicitWidth: root.horizontal ? 200 : 1
            implicitHeight: root.horizontal ? 1 : 200

            width: root.horizontal ? root.availableWidth : implicitWidth
            height: root.horizontal ? implicitHeight : root.availableHeight

            radius: width

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 1.0; color: "#515151" }
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
