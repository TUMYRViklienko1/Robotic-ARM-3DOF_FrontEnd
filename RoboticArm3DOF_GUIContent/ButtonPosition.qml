import QtQuick 2.15
import QtQuick.Controls 2.15

Button{
    id: buttonPosition
    required property int theta_1
    required property int theta_2
    required property int theta_3
     property int claw
    highlighted: true
    function setAngelsToSlider(theta_1,theta_2,theta_3,claw){
        flag = !flag
        __sliderWaist.slider.value = theta_1;
        __sliderShoulder.slider.value = theta_2;
        __sliderElbow.slider.value = theta_3;
        __clawToggle.checked = claw
        flag = !flag
    }
    onClicked: {
        setAngelsToSlider(theta_1,theta_2,theta_3,claw);
       // __sliderWaist.sendAngles(theta_1,theta_2,theta_3,claw);
    }

}
