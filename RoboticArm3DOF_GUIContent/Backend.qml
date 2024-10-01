import QtQuick
Item{
    id:root
    property int waistAngle
    property int shouldertAngle
    property int elbowAngle
    property int clawAngle

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
        SmoothedAnimation{
            velocity: 100
        }
    }
}
