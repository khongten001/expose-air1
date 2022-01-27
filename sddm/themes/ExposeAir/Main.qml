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

    TextConstants {
        id: textConstants
    }
    FontLoader {
        id: basefont
        source: "selawk.ttf"
    }
    FontLoader {
        id: boldfont
        source: "selawksb.ttf"
    }
    FontLoader {
        id: lightfont
        source: "selawkl.ttf"
    }
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

    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        spacing: 24
        anchors.leftMargin: 120

        Clock2 {
            id: clock
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            timeFont.family: lightfont.name
            dateFont.family: boldfont.name
        }
    }

    Column {
        x: parent.width / 2
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: lblLoginName
            height: 32
            text: textConstants.promptUser
            font.pointSize: 9
            verticalAlignment: Text.AlignVCenter
            color: "#f4f4f2"
            font.family: basefont.name
            bottomPadding: 20
        }

        TextField {
            id: name
            font.family: basefont.name
            width: 320
            height: 28
            text: userModel.lastUser
            font.pointSize: 10
            color: "#212121"
            background: Image {
                source: "input.svg"
            }

            KeyNavigation.backtab: rebootButton
            KeyNavigation.tab: password

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
            color: "#f4f4f2"
            font.pointSize: 9
            font.family: basefont.name
        }

        Row {
            spacing: 4
            TextField {
                id: password
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 10
                echoMode: TextInput.Password
                font.family: basefont.name
                color: "#212121"
                width: 320
                height: 28

                background: Image {
                    source: "input.svg"
                }

                KeyNavigation.backtab: name

                KeyNavigation.tab: loginButton
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return
                            || event.key === Qt.Key_Enter) {
                        sddm.login(name.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }
            }

            Image {
                id: loginButton
                width: 44
                height: 44
                source: "buttonup.svg"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.source = "buttonhover.svg"
                    }
                    onExited: {
                        parent.source = "buttonup.svg"
                    }
                    onPressed: {
                        parent.source = "buttondown.svg"
                        sddm.login(name.text, password.text, sessionIndex)
                    }
                    onReleased: {
                        parent.source = "buttonup.svg"
                    }
                }

                KeyNavigation.backtab: password
                KeyNavigation.tab: shutdownButton
            }
        }
        Text {
            id: errorMessage
            topPadding: 24
            text: textConstants.prompt
            font.pointSize: 9
            color: "#f4f4f2"
            font.family: basefont.name
        }
    }

    Column {
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.topMargin: 12
        anchors.top: parent.top
        width: 180

        Text {
            height: 30
            id: lblSession
            width: parent.width
            text: textConstants.session
            font.pointSize: 8
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

        ComboBox {
            id: session
            width: parent.width
            height: 22
            font.pixelSize: 10
            font.family: basefont.name
            arrowIcon: "comboarrow.svg"
            model: sessionModel
            index: sessionModel.lastIndex
            borderColor: "#a0afc3"
            color: "#f9f9f9"
            textColor: "#212121"
            hoverColor: "#909eb0"

            KeyNavigation.backtab: password
            KeyNavigation.tab: shutdownButton
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 18
        anchors.rightMargin: 24
        height: 64
        spacing: 24

        Column {
            width: 72

            Text {
                id: rebootName2
                anchors.horizontalCenter: parent.horizontalCenter
                height: 26
                text: textConstants.shutdown
                font.family: basefont.name
                font.pointSize: 8
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }

            Q1.Button {
                id: shutdownButton
                anchors.horizontalCenter: parent.horizontalCenter
                height: 44
                width: 44
                style: ButtonStyle {
                    background: Image {
                        source: control.hovered ? "shutdownpressed.svg" : "shutdown.svg"
                    }
                }

                onClicked: sddm.powerOff()
                KeyNavigation.backtab: loginButton
                KeyNavigation.tab: rebootButton
            }
        }
        Column {
            Text {
                id: rebootName
                anchors.horizontalCenter: parent.horizontalCenter
                height: 26
                text: textConstants.reboot
                font.family: basefont.name
                font.pointSize: 8
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            Q1.Button {
                id: rebootButton
                anchors.horizontalCenter: parent.horizontalCenter
                height: 44
                width: 44
                style: ButtonStyle {
                    background: Image {
                        source: control.hovered ? "rebootpressed.svg" : "reboot.svg"
                    }
                }

                onClicked: sddm.reboot()
                KeyNavigation.backtab: shutdownButton
                KeyNavigation.tab: name
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
