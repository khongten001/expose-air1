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

    Image {
        id: backing
        source: "airlogin3.png"
        width: parent.width
        height: parent.height
    }

    Rectangle {
        id: topBox
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 24
        height: 128
        width: parent.width
        color: "transparent"

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 24
            Clock2 {
                id: clock
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                timeFont.family: basefont.name
                dateFont.family: basefont.name
            }
        }
    }

    Rectangle {
        id: mainGrid
        color: "transparent"
        width: 520
        height: 240
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        //             anchors.topMargin: 112
        //anchors.leftMargin: 48
        //spacing: 64
        // Row {
        //     spacing: 64

            // Image {
            //     id: funny
            //     source: "system-users.png"
            //     anchors.top: parent.top
            //     anchors.topMargin: 16
            //     //Layout.rowSpan: 4
            // }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: lblLoginName
                    height: 32
                    text: textConstants.promptUser
                    font.pointSize: 8
                    verticalAlignment: Text.AlignVCenter
                    color: "#f4f4f2"
                    font.family: basefont.name
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
                    if (event.key === Qt.Key_Return
                    || event.key === Qt.Key_Enter){
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
            font.pointSize: 8
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
                color: "#404040"
                width: 320
                height: 28

                background: Image {
                source: "input.svg"
            }

            KeyNavigation.backtab: name
            //                        KeyNavigation.tab: loginButton

            Keys.onPressed: {
                if (event.key === Qt.Key_Return
                || event.key === Qt.Key_Enter){
                sddm.login(name.text, password.text,
                sessionIndex)
                event.accepted = true
            }
        }
    }

    Image {
        width: 44
        height: 44
        source: "buttonup.svg"

        //                     anchors.right: parent.right
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
                sddm.login(name.text, password.text,
                sessionIndex)
            }
            onReleased: {
                parent.source = "buttonup.svg"
            }
        }

        KeyNavigation.backtab: password
        KeyNavigation.tab: shutdownButton
    }
}
}
// }
Text {
    id: errorMessage
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    text: textConstants.prompt
    font.pointSize: 10
    color: "#f4f4f2"
    font.family: basefont.name
}
}

Rectangle {
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 12
    width: 560
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
            font.pointSize: 8
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
            borderColor: "#9c8e78"
            color: "#2c2c2c"
            textColor: "#f4f4f2"
            hoverColor: "#bfad93"

            KeyNavigation.backtab: password
            KeyNavigation.tab: shutdownButton
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
            source: control.hovered ? "shutdownpressed.svg": "shutdown.svg"
        }
    }

    onClicked: sddm.powerOff()
    //                KeyNavigation.backtab: loginButton
    KeyNavigation.tab: rebootButton
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
        source: control.hovered ? "rebootpressed.svg": "reboot.svg"
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
