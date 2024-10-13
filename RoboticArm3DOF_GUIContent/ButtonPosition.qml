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
        flag = !flag
        __sliderWaist.slider.value = theta_1;   // This will set it to 90 degrees
        __sliderShoulder.slider.value = theta_1;
        __sliderElbow.slider.value = theta_1;
        flag = !flag
        __sliderWaist.sendAngles(theta_1+90,theta_2+90,theta_3+90);
    }

}
