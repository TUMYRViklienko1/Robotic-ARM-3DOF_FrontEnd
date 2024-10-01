import QtQuick
Item{
    id:root
    property int waistAngle
    property int shouldertAngle
    property int elbowAngle
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
}
