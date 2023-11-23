import QtQuick 2.8
import QtQuick.Controls 2.8
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import QtGraphicalEffects 1.0
import "."

Rectangle {
    id : container
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index

    TextConstants {
        id : textConstants
    }

    FontLoader {
        id : basefont
        source : "assets/weblysleekuisl.ttf"
    }

    Connections {
        target : sddm

        function onLoginSucceeded() {
            errorMessage.color = "#33ffaa"
            errorMessage.text = textConstants.loginSucceeded
        }

        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#f22222"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
            font.family = boldfont.name
        }
    }

    Background {
        anchors.fill : parent
        source : config.background
        fillMode : Image.Stretch

        onStatusChanged : {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Clock2 {
            id : clock
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            color : "#fafcff"
            timeFont.family : basefont.name
        }

    Text {
        id: greeting
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 12
        anchors.leftMargin: 12
        // text: "Welcome to Plasma-Desktop"
        text: textConstants.welcomeText.arg(sddm.hostName)
        font.family: basefont.name
        font.pixelSize: 24
        color : "#fafcff"
    }

    Rectangle {
        id : sessionbehind
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 11
        anchors.topMargin: 19
        width : 174
        height : 26
        color: "#88ffffff"
        radius: 2
    }

    ComboBox {
        id : session
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 12
        anchors.topMargin: 20
        width : 172
        height : 24
        font.pixelSize : 12
        font.family : basefont.name
        arrowIcon : "assets/comboarrow.svg"
        model : sessionModel
        index : sessionModel.lastIndex
        borderColor : "#0c191c"
        color : "#ededed"
        menuColor : "#f2f2f4"
        textColor : "#323232"
        hoverColor : "#c8dde9"
        focusColor : "#36a1d3"
        arrowColor: "#0c191c"
        KeyNavigation.backtab : password
        KeyNavigation.tab : nameinput
    }

    Text {
        id : lblSession
        anchors.right: session.left
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.rightMargin: 12
        text : textConstants.session
        font.pointSize : 12
        font.family: basefont.name
        color : "#dadada"
    }

    Q1.Button {
        id : shutdownButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.rightMargin: 12
        height : 32
        width : 32
        style : ButtonStyle {
            background : Image {
                source : control.hovered
                    ? "assets/shutdownpressed.svg"
                    : "assets/shutdown.svg"
            }
        }

        onClicked : sddm.powerOff()
    }

    Q1.Button {
        id : rebootButton
        anchors.right: shutdownButton.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.rightMargin: 12
        height : 32
        width : 32

        style : ButtonStyle {
            background : Image {
                source : control.hovered
                    ? "assets/rebootpressed.svg"
                    : "assets/reboot.svg"
            }
        }

        onClicked : sddm.reboot()
    }

    Rectangle {
        id: centerlayout
        width: parent.width
        height: 84
        anchors.centerIn: parent
        color: "transparent"

        Image {
            id: imageinput
            source: "assets/input.svg"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 264
            height :28

            TextField {
                id: nameinput
                focus: true
                font.family: basefont.name
                anchors.fill: parent
                text: userModel.lastUser
                font.pixelSize: 12
                color: "#0c191c"
                background: Image {
                    id: textback
                    source: "assets/inputhi.svg"

                    states: [
                        State {
                            name: "yay"
                            PropertyChanges {target: textback; opacity: 1}
                        },
                        State {
                            name: "nay"
                            PropertyChanges {target: textback; opacity: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            to: "yay"
                            NumberAnimation { target: textback; property: "opacity"; from: 0; to: 1; duration: 200; }
                        },

                        Transition {
                            to: "nay"
                            NumberAnimation { target: textback; property: "opacity"; from: 1; to: 0; duration: 200; }
                        }
                    ]
                }

                KeyNavigation.tab: password
                KeyNavigation.backtab: session

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        password.focus = true
                    }
                }

                onActiveFocusChanged: {
                    if (activeFocus) {
                        textback.state = "yay"
                    } else {
                        textback.state = "nay"
                    }
                }
            }
        }

        Text {
            id: userlabel
            anchors.right: imageinput.left
            anchors.bottom: imageinput.bottom
            font.family: basefont.name
            font.pixelSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            rightPadding: 12
            height: 28
            text: textConstants.userName
            color: "#fafcff"
        }

        Image {
            id: imagepassword
            source: "assets/input.svg"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 264
            height :28

            TextField {
                id: password
                font.family: basefont.name
                anchors.fill: parent
                font.pixelSize: 12
                echoMode: TextInput.Password
                color: "#0c191c"

                background: Image {
                    id: textback1
                    source: "assets/inputhi.svg"

                    states: [
                        State {
                            name: "yay1"
                            PropertyChanges {target: textback1; opacity: 1}
                        },
                        State {
                            name: "nay1"
                            PropertyChanges {target: textback1; opacity: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            to: "yay1"
                            NumberAnimation { target: textback1; property: "opacity"; from: 0; to: 1; duration: 200; }
                        },

                        Transition {
                            to: "nay1"
                            NumberAnimation { target: textback1; property: "opacity"; from: 1; to: 0; duration: 200; }
                        }
                    ]
                }

                KeyNavigation.tab: session
                KeyNavigation.backtab: nameinput

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(nameinput.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }

                onActiveFocusChanged: {
                    if (activeFocus) {
                        textback1.state = "yay1"
                    } else {
                        textback1.state = "nay1"
                    }
                }
            }
        }

        Text {
            id: passwordlabel
            anchors.right: imagepassword.left
            anchors.bottom: imagepassword.bottom
            font.family: basefont.name
            font.pixelSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            rightPadding: 12
            height: 28
            text: textConstants.password
            color: "#fafcff"
        }

        Image {
            id : loginButton
            anchors.left: imagepassword.right
            anchors.bottom: imagepassword.bottom
            anchors.leftMargin: 12
            width : 28
            height : 28
            source : "assets/buttonup.svg"
            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "assets/buttonhover.svg"
                }
                onExited : {
                    parent.source = "assets/buttonup.svg"
                }
                onPressed : {
                    parent.source = "assets/buttondown.svg"
                    sddm.login(nameinput.text, password.text, sessionIndex)
                }
                onReleased : {
                    parent.source = "assets/buttonup.svg"
                }
            }
        }
    }

    Text{
        id: errorMessage
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 3
        text: textConstants.prompt
        font.family: basefont.name
        font.pixelSize: 12
        color: "#dadada"
    }

    Component.onCompleted : {
        nameinput.focus = true
        textback1.state = "nay1"  //dunno why both inputs get focused
    }
}
