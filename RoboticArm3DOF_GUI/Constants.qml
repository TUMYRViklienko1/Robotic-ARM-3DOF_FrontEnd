pragma Singleton
import QtQuick 6.7
//import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1100
    readonly property int height: 650
    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#2e2f30"

    readonly property int spacing: 5



    // property StudioApplication application: StudioApplication {
    //     fontPath: Qt.resolvedUrl("../../RoboticArm3DOF_GUIContent/" + relativeFontDirectory)
    // }
}
