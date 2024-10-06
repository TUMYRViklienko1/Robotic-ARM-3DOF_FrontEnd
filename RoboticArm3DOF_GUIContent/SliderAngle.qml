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
    property alias recColor: rectangle.color
    property alias slider: root
    Text {
        id: sliderName
        text: "text"
        font.pointSize: 15
    }

    Rectangle {
        id: rectangle
        width: 90
        height: 40
        radius: 5
        TextInput {
            id: textInput

            text: "0"
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
        text: "-90°"
        font.pointSize: 15
    }


    Slider {
        id: root
        value: 0
        wheelEnabled: true
        stepSize: 1
        from: -90
        to: 90
        // onFocusChanged: {

        // }1
        onValueChanged: {
            textInput.text = value.toFixed(0);
        }
    }


    Text {
        id: endValueSlider
        text: "90°"
        font.pointSize: 15
    }

}
