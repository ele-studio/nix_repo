import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "root:/"

RowLayout {
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    Layout.preferredWidth: 200
    spacing: 8

    Repeater {
        model: 8

        Item {
            required property int index
            property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)

            Layout.preferredWidth: 30
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                radius: 4
                color: focused ? "#FF0000" : "transparent"

                Text {
                    id: workspaceText
                    anchors.centerIn: parent
                    text: (index + 1).toString()
                    color: focused ? "#1f1f28" : "#c8c093"
                    font.pixelSize: 13
                    font.bold: focused
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Utils.HyprlandUtils.switchWorkspace(index + 1)
            }
        }
    }
}
