import QtQuick 2.15
import QtQuick.Controls 2.15
import backEnd.com 1.0

Button {
    id: root
    property int sizeAutoMode
    property bool autoModeIsRunning: true
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
                if (currentIndex < 0) {
                currentIndex =  AutoModeModel.getSize()-1;
                }
                if(stopButton.autoModeIsRunning == false)
                    autoModeTimer.stop();
            }
        }
    }

    function startAutoMode() {
        if (sizeAutoMode === 0) {
            return;
        }

        autoModeTimer.currentIndex = sizeAutoMode - 1;
        autoModeTimer.start();
    }


    property color backgroundDefultColor: "red"
    property real lightenFactor: 1.3 // Factor to lighten the color (default is 1.3 for moderate lightening)
    text: "text"

    implicitWidth: 103
    implicitHeight: 47
    background: Rectangle {
        radius: 3
        // Apply lighter color when button is not pressed
        color: root.down ? Qt.lighter(
                               root.backgroundDefultColor,
                               root.lightenFactor) : root.backgroundDefultColor
    }

}
