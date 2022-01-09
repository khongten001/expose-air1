import QtQuick 2.8
import QtQuick.Controls 2.8
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."


Rectangle {
    id: container
    width: 640
    height: 480


    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    TextConstants { id: textConstants }
    FontLoader { id: loginfont; source: "Lato-Regular.ttf" }
    FontLoader { id: loginfontbold; source: "Lato-Bold.ttf" }
    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }

        onLoginFailed: {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
        }
    }

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.Stretch
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }
    
    Rectangle {
        id: topBox
        anchors.top: parent.top
        anchors.left: parent.left
        height: 64
        width: parent.width
        color: "transparent"
        
        Clock2 {
            id: clock
            anchors.centerIn: parent
            color: "white"
            timeFont.family: loginfontbold.name
            dateFont.family: loginfont.name
        }
    }

    Image {
        anchors.centerIn: parent
        id: promptbox
        source: "promptbox.svg"
        
        Rectangle {
            id: titleBar
            color: "#1358dd"
            height: 36
            width: parent.width - 8
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin: 4
            
            Text {
                color: "white"
                text: textConstants.welcomeText.arg(sddm.hostName)
                font.family: loginfontbold.name
                font.pointSize: 12
                font.bold: false
                anchors.centerIn:parent
            }
        }
        

        
        Text {
            id: errorMessage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 72
            text: textConstants.prompt
            font.pointSize: 8
            color: "#606060"
            font.family: loginfont.name
        }
        
        Column {
            id: entryColumn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 32
            anchors.left: parent.left
            anchors.leftMargin: 16
            
            Text {
                id: lblLoginName
                height: 32
                text: textConstants.promptUser
                font.pointSize: 8
                verticalAlignment: Text.AlignVCenter
                color: "#606060"
                font.family: loginfont.name
            }
            
            TextField {
                id: name
                font.family: loginfontbold.name
                width: 276
                height: 32
                text: userModel.lastUser
                font.pointSize: 12
                color: "#404040"
                    background: Image {
                        source: "input.svg"
                    }

                KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(name.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }
            }
            
            Text {
                id: lblLoginPassword
                height: 32
                text: textConstants.promptPassword
                verticalAlignment: Text.AlignVCenter
                color: "#606060"
                font.pointSize: 8
                font.family: loginfont.name
            }
            
                TextField {
                    id: password
                    font.pointSize: 12
                    echoMode: TextInput.Password
                    font.family: loginfontbold.name
                    color: "#404040"
                    
                    background: Image {
                        source: "input.svg"
                    }

                    KeyNavigation.backtab: name; KeyNavigation.tab: loginButton

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }
                }
                
                Rectangle {
                    id: spacerRect
                    color: "transparent"
                    height: 32
                    width: 32
                }
               
                Image {
                    //width: 128
                    //height: 40
                    source: "buttonup.svg"
                    anchors.right: parent.right
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: { parent.source = "buttonhover.svg" }
                        onExited: { parent.source = "buttonup.svg" }
                        onPressed: {
                            parent.source = "buttondown.svg"
                            sddm.login(name.text, password.text, sessionIndex)
                        }
                        onReleased: {parent.source = "buttonup.svg"}
                    }
                    Text {
                        text: textConstants.login
                        anchors.centerIn: parent
                        font.family: loginfont.name
                        font.pointSize: 10
                        color: "#404040"
                    }
                    KeyNavigation.backtab: password; KeyNavigation.tab: shutdownButton
                }
        }
    }

        
    Rectangle {
        anchors.bottom: parent.bottom
//         anchors.bottomMargin: 24
        width: parent.width
        height: 64
        color: "transparent"
        
        Column {
            anchors.left: parent.left
            anchors.leftMargin: 36
            width: 196
            
            Text {
                height: 30
                id: lblSession
                width: parent.width
                text: textConstants.session
                font.pointSize: 10
                verticalAlignment: Text.AlignVCenter
                color: "white"
            } 
                
            ComboBox {
                id: session
                width: parent.width
                height: 24
                font.pixelSize: 12
                arrowIcon: "comboarrow.svg"
                model: sessionModel
                index: sessionModel.lastIndex

                KeyNavigation.backtab: password; KeyNavigation.tab: shutdownButton
            }
        }
        
        
        Column {
            anchors.right: parent.right
            anchors.rightMargin: 96
            width: 72
            
            Text {
                id: rebootName2
                anchors.horizontalCenter: parent.horizontalCenter
                height: 26
                text: textConstants.shutdown
                font.family: loginfont.name
                font.pointSize: 10
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            
            Q1.Button {
                id: shutdownButton
                anchors.horizontalCenter: parent.horizontalCenter
                height: 32
                width: 32
                style: ButtonStyle {
                    background: Image {
                        source: control.pressed ? "shutdownpressed.svg" : "shutdown.svg"
                    }
                }

                onClicked: sddm.powerOff()
                        KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
            }
    }
                Column {
            anchors.right: parent.right
            width: 96
            Text {
                id: rebootName
                anchors.horizontalCenter: parent.horizontalCenter
                height: 26
                text: textConstants.reboot
                font.family: loginfont.name
                font.pointSize: 10
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            Q1.Button {
                id: rebootButton
                anchors.horizontalCenter: parent.horizontalCenter
                height: 32
                width: 32
                style: ButtonStyle {
                    background: Image {
                        source: control.pressed ? "rebootpressed.svg" : "reboot.svg"
                    }
                }

                onClicked: sddm.reboot()
                KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                        }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
