import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks
import "root:/"

Scope {
  IpcHandler {
    target: "bar"

    function toggleVis(): void {
      // Toggle visibility of all bar instances
      for (let i = 0; i < Quickshell.screens.length; i++) {
        barInstances[i].visible = !barInstances[i].visible;
      }
    }
  }

  property var barInstances: []

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      property var modelData
      screen: modelData

      Component.onCompleted: {
        barInstances.push(bar);
      }

      color: "transparent"

      Rectangle {
        id: highlight
        anchors.fill: parent
        color: Theme.get.barBgColor
      }

      height: 30

      visible: true

      anchors {
        top: Theme.get.onTop
        bottom: !Theme.get.onTop
        left: true
        right: true
      }

      // Three-section layout using anchors for precise positioning
      Item {
        anchors.fill: parent

        // Left section - workspaces only
        RowLayout {
          id: leftBlocks
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          anchors.leftMargin: 10
          spacing: 10

          //Blocks.Icon {}
          Blocks.Workspaces {}
        }

        // Center section - absolutely centered
        Blocks.Time {
          id: centerTime
          anchors.centerIn: parent
        }

        // Right section - anchored to right
        RowLayout {
          id: rightBlocks
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.rightMargin: 10
          spacing: 0

          Blocks.SystemTray {}
          Blocks.Memory {}
          Blocks.WiFi {}
          Blocks.Sound {}
          Blocks.Battery {}
          Blocks.Date {}
        }
      }
    }
  }
}
