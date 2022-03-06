import QtQuick 2.8
import QtQuick.Controls 2.8
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import QtGraphicalEffects 1.0
import "."
Rectangle {
    id : container
    width : 640
    height : 480
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index
    TextConstants {
        id : textConstants
    }
    FontLoader {
        id : basefont
        source : "selawk.ttf"
    }
    FontLoader {
        id : boldfont
        source : "selawksb.ttf"
    }

    Connections {
        target : sddm
        onLoginSucceeded : {
            errorMessage.color = "#33ff99"
            errorMessage.text = textConstants.loginSucceeded
        }
        onLoginFailed : {
            password.text = ""
            errorMessage.color = "#ff99cc"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
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
    Text {
        id: greeting
        anchors.top : parent.top
        anchors.horizontalCenter :parent.horizontalCenter
        font.pointSize : 16
        anchors.topMargin : 28
        color : "#ffffff"
        text : textConstants.welcomeText.arg(sddm.hostName)
    }
            DropShadow {
            source : greeting
            anchors.fill : greeting
            verticalOffset : 1
            horizontalOffset : 1
            color : "#97001177"
            radius : 3
            samples : 7
        }

    Row {
        anchors.verticalCenter : parent.verticalCenter
        anchors.horizontalCenter : parent.horizontalCenter
        spacing: 96

    Clock2 {
        id : clock
        anchors.verticalCenter : parent.verticalCenter
        color : "#fafafa"
        timeFont.family : lightfont.name
        dateFont.family : boldfont.name
    }
    Column {
        Text {
            id : lblLoginName
//             height : 32
            text : textConstants.promptUser
            font.pointSize : 10
            verticalAlignment : Text.AlignVCenter
            color : "#fafafa"
            font.family : basefont.name
            bottomPadding : 5
        }
        TextField {
            id : name
            font.family : basefont.name
            width : 320
            height : 32
            text : userModel.lastUser
            font.pointSize : 11
            color : "#323232"
            background : Image {
                source : "input.svg"
            }
            KeyNavigation.backtab : rebootButton
            KeyNavigation.tab : password
            Keys.onPressed : {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(name.text, password.text, sessionIndex)
                    event.accepted = true
                }
            }
        }
                    Rectangle {
                height : 12
                width : 12
                color : "transparent"
            }
        Text {
            id : lblLoginPassword
//             height : 32
            text : textConstants.promptPassword
            verticalAlignment : Text.AlignVCenter
            color : "#fafafa"
            font.pointSize : 10
            font.family : basefont.name
        }
        Row {
            spacing : 4
            TextField {
                id : password
                anchors.verticalCenter : parent.verticalCenter
                font.pointSize : 11
                echoMode : TextInput.Password
                font.family : basefont.name
                color : "#323232"
                width : 320
                height : 32
                background : Image {
                    source : "input.svg"
                }
                KeyNavigation.backtab : name
                KeyNavigation.tab : loginButton
                Keys.onPressed : {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(name.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }
            }
            Image {
                id : loginButton
                width : 42
                height : 42
                source : "buttonup.svg"
                MouseArea {
                    anchors.fill : parent
                    hoverEnabled : true
                    onEntered : {
                        parent.source = "buttonhover.svg"
                    }
                    onExited : {
                        parent.source = "buttonup.svg"
                    }
                    onPressed : {
                        parent.source = "buttondown.svg"
                        sddm.login(name.text, password.text, sessionIndex)
                    }
                    onReleased : {
                        parent.source = "buttonup.svg"
                    }
                }
                KeyNavigation.backtab : password
                KeyNavigation.tab : shutdownButton
            }
        }
    }
    }
    Column {
        anchors.right : parent.right
        anchors.rightMargin : 24
        anchors.topMargin : 12
        anchors.top : parent.top
        width : 144
        Text {
            //height : 30
            id : lblSession
            width : parent.width
            text : textConstants.session
            font.pointSize : 10
            verticalAlignment : Text.AlignVCenter
            color : "#fafafa"
        }

        ComboBox {
            id : session
            width : parent.width
//             height : 30
            font.pixelSize : 11
            font.family : basefont.name
            arrowIcon : "comboarrow.svg"
            model : sessionModel
            index : sessionModel.lastIndex
            borderColor : "#3db5f0"
            color : "#f4f4f8"
            menuColor : "#f4f4f8"
            textColor : "#323232"
            hoverColor : "#36a1d3"
            focusColor : "#36a1d3"
            KeyNavigation.backtab : password
            KeyNavigation.tab : shutdownButton
        }
    }
    Row {
        anchors.bottom : parent.bottom
        anchors.right : parent.right
        anchors.bottomMargin : 18
        anchors.rightMargin : 24
        height : 64
        spacing : 24
        Column {
            width : 72
            Text {
                id : rebootName2
                anchors.horizontalCenter : parent.horizontalCenter
                height : 26
                text : textConstants.shutdown
                font.family : basefont.name
                font.pointSize : 10
                verticalAlignment : Text.AlignVCenter
                color : "#fafafa"
            }
            Q1.Button {
                id : shutdownButton
                anchors.horizontalCenter : parent.horizontalCenter
                height : 44
                width : 44
                style : ButtonStyle {
                    background : Image {
                        source : control.hovered
                            ? "shutdownpressed.svg"
                            : "shutdown.svg"
                    }
                }
                onClicked : sddm.powerOff()
                KeyNavigation.backtab : loginButton
                KeyNavigation.tab : rebootButton
            }
        }
        Column {
            Text {
                id : rebootName
                anchors.horizontalCenter : parent.horizontalCenter
                height : 26
                text : textConstants.reboot
                font.family : basefont.name
                font.pointSize : 10
                verticalAlignment : Text.AlignVCenter
                color : "#fafafa"
            }
            Q1.Button {
                id : rebootButton
                anchors.horizontalCenter : parent.horizontalCenter
                height : 44
                width : 44
                style : ButtonStyle {
                    background : Image {
                        source : control.hovered
                            ? "rebootpressed.svg"
                            : "reboot.svg"
                    }
                }
                onClicked : sddm.reboot()
                KeyNavigation.backtab : shutdownButton
                KeyNavigation.tab : name
            }
        }
    }
    Component.onCompleted : {
        if (name.text == "")
            name.focus = true
         else
            password.focus = true

    }
}
