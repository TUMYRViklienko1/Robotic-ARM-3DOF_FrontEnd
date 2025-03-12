import QtQuick
Item{
    id:root
    property int waistAngle
    property int shouldertAngle
    property int elbowAngle
    property int clawAngle
    property int clawMove
    Behavior on waistAngle{
        SmoothedAnimation{
            velocity: 100
        }
    }
    Behavior on shouldertAngle{
        SmoothedAnimation{
            velocity: 100
        }
    }
    Behavior on elbowAngle{
        SmoothedAnimation{
            velocity: 100
        }
    }


    Behavior on clawAngle{
        id: angle
        NumberAnimation{
            property: "clawAngle"
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
    Behavior on clawMove{
        NumberAnimation{
            property: "clawMove"
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }


    }
