import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 6.7


RowLayout {
    id: root
    property alias forward: forward
    property alias inverse: inverse
    // function restart(){
    //     __sliderWaist.textInputValue = 90;
    //     __sliderShoulder.textInputValue = 90;
    //     __sliderElbow.textInputValue = 90;
    //     root.state = "opean";
    // }
    Button {
        id: forward
        text: qsTr("Forward")
        onClicked: {
            controllerForward.visible = true
            columnLayoutInverse.visible =  false
            resset.setAngelsToSlider(90,90,90,0)
        }
    }

    Button {
        id: inverse
        text: qsTr("Inverse")
        onClicked: {
            controllerForward.visible = false
            columnLayoutInverse.visible =  true
            resset.setAngelsToSlider(90,90,90,0)
        }
    }

}

