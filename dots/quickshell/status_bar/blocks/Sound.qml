import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../"
import "root:/" 

BarBlock {
    id: root
    property var sink: Pipewire.defaultAudioSink

    PwObjectTracker { 
        objects: [Pipewire.defaultAudioSink]
        onObjectsChanged: {
            sink = Pipewire.defaultAudioSink
            if (sink?.audio) {
                sink.audio.volumeChanged.connect(updateVolume)
            }
        }
    }

    function updateVolume() {
        if (sink?.audio) {
            const icon = sink.audio.muted ? "󰖁" : "󰕾"
            content.symbolText = `${icon} ${Math.round(sink.audio.volume * 100)}%`
        }
    }

    content: BarText { symbolText: `${sink?.audio?.muted ? "󰖁" : "󰕾"} ${Math.round(sink?.audio?.volume * 100)}%` }

    MouseArea {
        anchors.fill: parent
        onClicked: toggleMenu()
        onWheel: function(event) {
            if (sink?.audio) {
                sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + (event.angleDelta.y / 120) * 0.05))
            }
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
        running: false
    }

    PopupWindow {
        id: menuWindow
        implicitWidth: 200
        implicitHeight: 120
        visible: false

        anchor {
            window: root.QsWindow?.window
            edges: Edges.Top
            gravity: Edges.Bottom
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onExited: {
                if (!containsMouse) {
                    closeTimer.start()
                }
            }
            onEntered: closeTimer.stop()

            Timer {
                id: closeTimer
                interval: 500
                onTriggered: menuWindow.visible = false
            }

            Rectangle {
                anchors.fill: parent
                color: Theme.get.buttonBackgroundColor
                border.color: Theme.get.buttonBorderColor
                border.width: 1
                radius: 4

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    // Volume Control Row
                    Rectangle {
                        width: parent.width
                        height: 40
                        color: "transparent"

                        Row {
                            anchors.fill: parent
                            anchors.margins: 5
                            spacing: 10

                            // Speaker Icon
                            Rectangle {
                                width: 30
                                height: 30
                                color: "transparent"
                                anchors.verticalCenter: parent.verticalCenter

                                Text {
                                    id: speakerIcon
                                    anchors.centerIn: parent
                                    font.pixelSize: 18
                                    color: sink?.audio?.muted ? "#666666" : Theme.get.iconColor
                                    text: {
                                        if (sink?.audio?.muted) return "󰖁"
                                        const vol = (sink?.audio?.volume || 0) * 100
                                        if (vol === 0) return "󰖁"
                                        else if (vol < 30) return "󰕿"
                                        else if (vol < 70) return "󰖀"
                                        else return "󰕾"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (sink?.audio) {
                                            sink.audio.muted = !sink.audio.muted
                                        }
                                    }
                                    hoverEnabled: true
                                    onEntered: speakerIcon.color = Theme.get.iconPressedColor
                                    onExited: speakerIcon.color = sink?.audio?.muted ? "#666666" : Theme.get.iconColor
                                }
                            }

                            // Volume Slider
                            Slider {
                                id: volumeSlider
                                width: parent.width - 50
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                from: 0
                                to: 1
                                value: sink?.audio?.volume || 0
                                onValueChanged: {
                                    if (sink?.audio) {
                                        sink.audio.volume = value
                                        if (sink.audio.muted && value > 0) {
                                            sink.audio.muted = false
                                        }
                                    }
                                }

                                background: Rectangle {
                                    x: volumeSlider.leftPadding
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                    width: volumeSlider.availableWidth
                                    height: 12
                                    radius: 6
                                    color: Theme.get.buttonBorderColor

                                    Rectangle {
                                        width: volumeSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: sink?.audio?.muted ? "#666666" : Theme.get.iconColor
                                        radius: 6
                                    }
                                }

                                handle: Rectangle {
                                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                    width: 18
                                    height: 18
                                    radius: 9
                                    color: volumeSlider.pressed ? Theme.get.iconPressedColor : "#ffffff"
                                    border.color: Theme.get.buttonBorderColor
                                    border.width: 1
                                }
                            }
                        }
                    }

                    Repeater {
                        model: [
                            { text: "Pavucontrol", action: () => { pavucontrol.running = true; menuWindow.visible = false } }
                        ]

                        Rectangle {
                            width: parent.width
                            height: 35
                            color: mouseArea.containsMouse ? Theme.get.buttonBorderColor : "transparent"
                            radius: 4

                            Text {
                                anchors.fill: parent
                                anchors.leftMargin: 10
                                text: modelData.text
                                color: "white"
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    modelData.action()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function toggleMenu() {
        if (root.QsWindow?.window?.contentItem) {
            menuWindow.anchor.rect = root.QsWindow.window.contentItem.mapFromItem(root, 0, root.height + 5, root.width, root.height)
            menuWindow.visible = !menuWindow.visible
        }
    }
}