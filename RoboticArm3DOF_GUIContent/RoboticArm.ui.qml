

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import Generated.QtQuick3D.RoboticArm3
import QtQuick
import QtQuick.Controls
import QtQuick3D
import QtQuick3D.Effects

View3D {
    property alias waistRotation: roboticArm3.waistRotation
    property alias shoulderRotation: roboticArm3.shoulderRotation
    property alias elbowRotation: roboticArm3.elbowRotation
    property alias clawRotation: roboticArm3.clawRotation
    property alias clawMove: roboticArm3.clawMove
    readonly property alias waistJointCord: roboticArm3.waistJointCord
    readonly property alias shoulderJointCord: roboticArm3.shoulderJointCord
    readonly property alias elbowJointCord: roboticArm3.elbowJointCord
    readonly property alias clawJointCord: roboticArm3.clawJointCord
    id: roboticArmView3D
    camera: sceneCamera

    environment: SceneEnvironment {
        id: sceneEnvironment
        skyboxBlurAmount: 0
        aoStrength: 0
        aoEnabled: false
        specularAAEnabled: false

        probeExposure: 1
        backgroundMode: SceneEnvironment.Transparent
        lightProbe: Texture {
            id: symmetrical_garden_02_4k
            source: "images/symmetrical_garden_02_4k.hdr" // Ensure this path is correct
        }
        antialiasingMode: SceneEnvironment.MSAA
        antialiasingQuality: SceneEnvironment.High
    }

    Node {
        id: scene

        DirectionalLight {
            id: directionalLight
        }

        PerspectiveCamera {
            id: sceneCamera
            x: -26.695
            y: 100
            position: Qt.vector3d(0, 200, 300)
            eulerRotation.z: 0
            eulerRotation.y: 0
            z: 524.124
            eulerRotation.x: -20
            fieldOfView: 90
        }

        RoboticArm3 {
            id: roboticArm3

            y: -50
        }
    }

    Item {
        id: __materialLibrary__
    }
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}D{i:3;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/

