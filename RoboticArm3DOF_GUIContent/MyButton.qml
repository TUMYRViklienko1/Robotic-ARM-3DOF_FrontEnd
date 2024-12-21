import QtQuick 2.15
import QtQuick.Controls 2.15
import backEnd.com 1.0

Button {
    id: root
    property int theta_1:-1
    property int theta_2:-1
    property int theta_3:-1
    property int claw:-1

    function setAngelsToSlider(theta_1, theta_2, theta_3, claw) {
        console.log("setAngelsToSlider called with angles:", theta_1, theta_2, theta_3, claw);

        flag = !flag
        controllerForward.sliderWaist.sliderValue = theta_1;
        controllerForward.sliderShoulder.sliderValue = theta_2;
        controllerForward.sliderElbow.sliderValue = theta_3;
        controllerForward.clawMode = claw
        flag = !flag
    }
    Connections{
        target: root
        onClicked: {
            if(theta_1 != -1 && theta_2 != -1 && theta_3 != -1 && claw != -1){
                setAngelsToSlider(theta_1, theta_2, theta_3, claw);
                controllerForward.sendAngles(theta_1, theta_2, theta_3, controllerForward.clawMode);
            }
        }
    }



    property int sizeAutoMode
    property bool autoModeIsRunning: true

    property int startAutoModeFlag: -1
    property int stopAutoModeFlag: -2

    Timer {
        id: autoModeTimer
        interval: automaticMode.mDelay.valueCord * 1000  // 1 second delay
        repeat: true    // Repeat until manually stopped
        property int currentIndex

        onTriggered: {


            if (currentIndex >= 0) {
                let [angle1, angle2, angle3, claw] = AutoModeModel.startAutoMode(currentIndex);
                position1.setAngelsToSlider(angle1, angle2, angle3, claw);
                currentIndex--;

                if (currentIndex < 0) {
                    currentIndex = AutoModeModel.getSize() - 1;
                }
                if (stopButton.autoModeIsRunning === false) {
                    SerialPort.writeFlagToSerialPort(stopAutoModeFlag, delay.valueCord, AutoModeModel.getSize());
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

    property color backgroundDefultColor: "#f4f6f7"
    property real lightenFactor: 1.3
    property alias title:rootText.text
    implicitWidth: 90
    implicitHeight: 45
    highlighted: true




    background: Rectangle {
        anchors.fill: parent
        // Bind the color to buttonPosition.backgroundDefultColor
        color: root.down ? Qt.darker(
                               root.backgroundDefultColor,
                               root.lightenFactor) : root.backgroundDefultColor
        Text {
            id: rootText
            text: ""
            color: "#313131"
            anchors.centerIn: parent
            font.pixelSize: 16
            font.family: "Segoe UI"
        }
    }
}
