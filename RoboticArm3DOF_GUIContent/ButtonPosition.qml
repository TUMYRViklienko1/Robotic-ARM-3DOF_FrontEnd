import QtQuick 2.15
import QtQuick.Controls 2.15

Button{
    id: buttonPosition
    required property int theta_1
    required property int theta_2
    required property int theta_3
    highlighted: true
    onClicked: {
        // Reset sliders, which will automatically update the backend

        __sliderWaist.sendAngles(theta_1,theta_2,theta_3)

    }

}
