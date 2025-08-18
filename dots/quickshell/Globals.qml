pragma Singleton

import QtQuick

QtObject {
    property QtObject popupContext: QtObject {
        property var popup: null
    }
}