import QtQuick 2.15
import QtQuick.Controls 2.15
import backEnd.com 1.0

Button {
    id: root
    property int theta_1
    property int theta_2
    property int theta_3
    property int claw

    property color backgroundDefultColor: "#f4f6f7"
    property real lightenFactor: 1.3
    property alias title:rootText.text
    function setAngelsToSlider(theta_1, theta_2, theta_3, claw) {
        flag = !flag
        __sliderWaist.slider.value = theta_1;
        __sliderShoulder.slider.value = theta_2;
        __sliderElbow.slider.value = theta_3;
        __clawToggle.checked = claw
        flag = !flag
    }

    property int sizeAutoMode
    property bool autoModeIsRunning: true

    property int startAutoModeFlag: -1
    property int stopAutoModeFlag: -2

    Timer {
        id: autoModeTimer
        interval: delay.valueCord * 1000  // 1 second delay
        repeat: true    // Repeat until manually stopped
        property int currentIndex
        onTriggered: {
            if (currentIndex >= 0) {
                // Call updateStep with the current index
                let [angle1, angle2, angle3, claw] = AutoModeModel.startAutoMode(currentIndex);
                position1.setAngelsToSlider(angle1, angle2, angle3, claw);
                currentIndex--;

                // Stop the timer if we've processed all steps
                if (currentIndex < 0)
                {
                    currentIndex =  AutoModeModel.getSize()-1;
                }
                if(stopButton.autoModeIsRunning == false)
                {
                    SerialPort.writeFlagToSerialPort(stopAutoModeFlag,delay.valueCord,AutoModeModel.getSize())
                    AutoModeModel.setCountOfArray(0);
                    autoModeTimer.stop();
                }
            }
        }
    }

    function startAutoMode() {
        if (sizeAutoMode === 0) {
            return;
        }
        SerialPort.writeFlagToSerialPort(startAutoModeFlag,delay.valueCord,AutoModeModel.getSize())
        autoModeTimer.currentIndex = sizeAutoMode - 1;
        autoModeTimer.start();
    }

    implicitWidth: 80
    implicitHeight: 40
    highlighted: true

    onClicked: {
        setAngelsToSlider(theta_1, theta_2, theta_3, claw);
        __sliderWaist.sendAngles(theta_1, theta_2, theta_3, claw);
    }


    background: Rectangle {
        anchors.fill: parent
        radius: 20
        // Bind the color to buttonPosition.backgroundDefultColor
        color: root.down ? Qt.darker(
                               root.backgroundDefultColor,
                               root.lightenFactor) : root.backgroundDefultColor
        border.color: "#4d5656"
        border.width: 2
        Text {
            id: rootText
            text: ""
            color: "#313131"
            anchors.centerIn: parent
            font.pixelSize: 15
        }
    }
}
