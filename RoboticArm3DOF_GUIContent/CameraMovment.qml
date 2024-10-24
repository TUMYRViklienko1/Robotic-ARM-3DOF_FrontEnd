import QtQuick 6.7
Item {
    id:root
    focus: true
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_0) {
            sceneCamera.eulerRotation.x = 30
        }
    }
}
