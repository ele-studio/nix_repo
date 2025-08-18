import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "../"
import "root:/" 

BarBlock {
    id: root
    
    // WiFi state tracking
    property bool wifiEnabled: true
    property bool connected: false
    property string currentNetwork: "Not Connected"
    property int signalStrength: 0
    property var availableNetworks: []
    property bool connecting: false
    property string connectionStatus: ""

    // Process for nmcli commands
    Process {
        id: nmcliStatus
        command: ["nmcli", "-t", "-f", "WIFI,STATE", "general", "status"]
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                const output = data.trim()
                const parts = output.split(':')
                if (parts.length >= 2) {
                    wifiEnabled = parts[0] === "enabled"
                    connected = parts[1] === "connected"
                }
                updateWifiInfo()
            }
        }
    }

    Process {
        id: nmcliConnection
        command: ["sh", "-c", "nmcli -t -f NAME,TYPE connection show --active | grep '802-11-wireless' | head -1"]
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                const line = data.trim()
                if (line) {
                    const parts = line.split(':')
                    if (parts.length >= 2) {
                        currentNetwork = parts[0].trim()
                        connected = true
                        getSignalStrength()
                        return
                    }
                }
                currentNetwork = "Not Connected"
                connected = false
                scanNetworks()
            }
        }
    }

    Process {
        id: nmcliSignal
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL", "device", "wifi", "list", "--rescan", "no"]
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                if (data.trim() && currentNetwork !== "Not Connected") {
                    const lines = data.split('\n')
                    for (const line of lines) {
                        const parts = line.split(':')
                        if (parts.length >= 2 && parts[0] === currentNetwork) {
                            signalStrength = parseInt(parts[1]) || 0
                            break
                        }
                    }
                }
                scanNetworks()
            }
        }
    }

    function getSignalStrength() {
        nmcliSignal.running = true
    }

    Process {
        id: nmcliScan
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY", "device", "wifi", "list"]
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                const networks = []
                const lines = data.split('\n')
                const seenNetworks = new Set()
                
                for (const line of lines) {
                    const parts = line.split(':')
                    if (parts.length >= 3 && parts[0].trim() && !seenNetworks.has(parts[0])) {
                        seenNetworks.add(parts[0])
                        networks.push({
                            ssid: parts[0],
                            signal: parseInt(parts[1]) || 0,
                            security: parts[2] || ""
                        })
                    }
                }
                // Sort by signal strength
                networks.sort((a, b) => b.signal - a.signal)
                availableNetworks = networks.slice(0, 10) // Limit to 10 networks
            }
        }
    }

    function updateWifiInfo() {
        nmcliConnection.running = true
    }

    function scanNetworks() {
        nmcliScan.running = true
    }

    // Connection process
    Process {
        id: nmcliConnect
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                const result = data.trim()
                if (result.includes("successfully activated")) {
                    connectionStatus = "Connected successfully!"
                    connecting = false
                } else if (result.includes("Error")) {
                    connectionStatus = "Connection failed"
                    connecting = false
                } else if (result) {
                    connectionStatus = result
                }
                // Refresh status after connection attempt
                statusRefreshTimer.start()
            }
        }
    }

    function connectToNetwork(ssid, security) {
        if (security && security.includes("WPA")) {
            // Show password dialog for secured networks
            passwordDialog.networkSSID = ssid
            passwordDialog.visible = true
        } else {
            // Connect directly to open networks
            connectToOpenNetwork(ssid)
        }
    }

    function connectToOpenNetwork(ssid) {
        connecting = true
        connectionStatus = "Connecting to " + ssid + "..."
        nmcliConnect.command = ["nmcli", "device", "wifi", "connect", ssid]
        nmcliConnect.running = true
        menuWindow.visible = false
    }

    function connectToSecuredNetwork(ssid, password) {
        connecting = true
        connectionStatus = "Connecting to " + ssid + "..."
        nmcliConnect.command = ["nmcli", "device", "wifi", "connect", ssid, "password", password]
        nmcliConnect.running = true
        passwordDialog.visible = false
        menuWindow.visible = false
    }

    // Update WiFi status periodically
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: nmcliStatus.running = true
    }

    // Timer for clearing connection status
    Timer {
        id: statusRefreshTimer
        interval: 2000
        repeat: false
        onTriggered: {
            nmcliStatus.running = true
            connectionStatus = ""
        }
    }

    // Initial status check
    Component.onCompleted: {
        nmcliStatus.running = true
    }

    content: BarText { 
        symbolText: {
            if (connecting) return "󰤯 " + connectionStatus
            if (!wifiEnabled) return "󰤭 WiFi Off"
            if (!connected) return "󰤯 Disconnected"
            
            // Signal strength icons
            if (signalStrength >= 75) return "󰤨 " + currentNetwork
            else if (signalStrength >= 50) return "󰤥 " + currentNetwork
            else if (signalStrength >= 25) return "󰤢 " + currentNetwork
            else return "󰤟 " + currentNetwork
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: toggleMenu()
    }

    PopupWindow {
        id: menuWindow
        implicitWidth: 300
        implicitHeight: Math.min(400, 60 + availableNetworks.length * 40)
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
                interval: 1000
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
                    spacing: 5

                    // Header
                    Rectangle {
                        width: parent.width
                        height: 30
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "WiFi Networks"
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                        }

                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            text: "🔄"
                            color: Theme.get.iconColor
                            font.pixelSize: 14
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    nmcliStatus.running = true
                                }
                                hoverEnabled: true
                                onEntered: parent.color = Theme.get.iconPressedColor
                                onExited: parent.color = Theme.get.iconColor
                            }
                        }
                    }

                    // Separator
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: Theme.get.buttonBorderColor
                    }

                    // Network List
                    ScrollView {
                        width: parent.width
                        height: parent.height - 40
                        clip: true

                        Column {
                            width: parent.width
                            spacing: 2

                            Repeater {
                                model: availableNetworks

                                Rectangle {
                                    width: parent.width
                                    height: 35
                                    color: mouseArea.containsMouse ? Theme.get.buttonBorderColor : "transparent"
                                    radius: 4

                                    Item {
                                        anchors.fill: parent
                                        anchors.leftMargin: 10
                                        anchors.rightMargin: 10

                                        // Signal strength icon
                                        Text {
                                            id: signalIcon
                                            anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: Theme.get.iconColor
                                            font.pixelSize: 14
                                            text: {
                                                const signal = modelData.signal
                                                if (signal >= 75) return "󰤨"
                                                else if (signal >= 50) return "󰤥"
                                                else if (signal >= 25) return "󰤢"
                                                else return "󰤟"
                                            }
                                        }

                                        // Network name
                                        Text {
                                            anchors.left: signalIcon.right
                                            anchors.leftMargin: 10
                                            anchors.right: securityIcon.left
                                            anchors.rightMargin: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: modelData.ssid
                                            color: modelData.ssid === currentNetwork ? Theme.get.iconColor : "white"
                                            font.pixelSize: 12
                                            font.bold: modelData.ssid === currentNetwork
                                            elide: Text.ElideRight
                                        }

                                        // Security icon
                                        Text {
                                            id: securityIcon
                                            anchors.right: parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: "#888888"
                                            font.pixelSize: 12
                                            text: modelData.security.includes("WPA") ? "🔒" : ""
                                        }
                                    }

                                    MouseArea {
                                        id: mouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            connectToNetwork(modelData.ssid, modelData.security)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Password Input Dialog
    PopupWindow {
        id: passwordDialog
        implicitWidth: 350
        implicitHeight: 200
        visible: false

        property string networkSSID: ""

        anchor {
            window: root.QsWindow?.window
            edges: Edges.Top
            gravity: Edges.Bottom
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.get.buttonBackgroundColor
            border.color: Theme.get.buttonBorderColor
            border.width: 1
            radius: 4

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                // Title
                Text {
                    width: parent.width
                    text: "Connect to " + passwordDialog.networkSSID
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }

                // Password label
                Text {
                    text: "Password:"
                    color: "white"
                    font.pixelSize: 12
                }

                // Password input
                Rectangle {
                    width: parent.width
                    height: 35
                    color: Theme.get.buttonBorderColor
                    border.color: passwordInput.activeFocus ? Theme.get.iconColor : Theme.get.buttonBorderColor
                    border.width: 2
                    radius: 4

                    TextInput {
                        id: passwordInput
                        anchors.fill: parent
                        anchors.margins: 8
                        color: "white"
                        font.pixelSize: 12
                        echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password
                        selectByMouse: true
                        
                        Keys.onReturnPressed: {
                            if (text.trim()) {
                                connectToSecuredNetwork(passwordDialog.networkSSID, text.trim())
                                text = ""
                            }
                        }
                        
                        Keys.onEscapePressed: {
                            passwordDialog.visible = false
                            text = ""
                        }
                    }
                }

                // Show password checkbox
                Row {
                    spacing: 8
                    
                    Rectangle {
                        width: 16
                        height: 16
                        color: showPassword.checked ? Theme.get.iconColor : "transparent"
                        border.color: Theme.get.iconColor
                        border.width: 1
                        radius: 2
                        
                        Text {
                            anchors.centerIn: parent
                            text: "✓"
                            color: "white"
                            font.pixelSize: 10
                            visible: showPassword.checked
                        }
                        
                        MouseArea {
                            id: showPassword
                            anchors.fill: parent
                            property bool checked: false
                            onClicked: checked = !checked
                        }
                    }
                    
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Show password"
                        color: "white"
                        font.pixelSize: 11
                    }
                }

                // Buttons
                Row {
                    width: parent.width
                    spacing: 10

                    Rectangle {
                        width: (parent.width - 10) / 2
                        height: 35
                        color: cancelMouseArea.containsMouse ? Theme.get.buttonBorderColor : "transparent"
                        border.color: Theme.get.buttonBorderColor
                        border.width: 1
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            text: "Cancel"
                            color: "white"
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: cancelMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                passwordDialog.visible = false
                                passwordInput.text = ""
                            }
                        }
                    }

                    Rectangle {
                        width: (parent.width - 10) / 2
                        height: 35
                        color: connectMouseArea.containsMouse ? Theme.get.iconPressedColor : Theme.get.iconColor
                        border.color: Theme.get.iconColor
                        border.width: 1
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            text: "Connect"
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            id: connectMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                if (passwordInput.text.trim()) {
                                    connectToSecuredNetwork(passwordDialog.networkSSID, passwordInput.text.trim())
                                    passwordInput.text = ""
                                }
                            }
                        }
                    }
                }
            }
        }

        onVisibleChanged: {
            if (visible) {
                passwordInput.forceActiveFocus()
                passwordInput.text = ""
            }
        }
    }

    function toggleMenu() {
        if (root.QsWindow?.window?.contentItem) {
            // Refresh networks when opening
            if (!menuWindow.visible) {
                nmcliStatus.running = true
            }
            menuWindow.anchor.rect = root.QsWindow.window.contentItem.mapFromItem(root, 0, root.height + 5, root.width, root.height)
            menuWindow.visible = !menuWindow.visible
        }
    }
}