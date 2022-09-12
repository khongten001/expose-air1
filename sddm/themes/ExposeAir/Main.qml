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
        source : "weblysleekuisl.ttf"
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

    Column {
        anchors.verticalCenter : parent.verticalCenter
        anchors.horizontalCenter : parent.horizontalCenter
        spacing: 36

        Clock2 {
            id : clock
            anchors.horizontalCenter : parent.horizontalCenter
            color : "#f8faff"
            timeFont.family : basefont.name
            dateFont.family : basefont.name
        }

        Column {
            spacing: 8

            Row {
                spacing: 4

                Image {
                        width : 64
                        height : 36
                        source: 'assets/system-users.svg'
                }

                TextField {
                    id : name
                    font.family : basefont.name
                    width : 320
                    height : 30
                    text : userModel.lastUser
                    font.pointSize : 10
                    color : "#323232"
                    background : Image {
                        source : "assets/input.svg"
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
            }

            Row {
                spacing : 4

                Image {
                    width : 64
                    height : 36
                    source: 'assets/start-here.svg'
                }

                TextField {
                    id : password
                    anchors.verticalCenter : parent.verticalCenter
                    font.pointSize : 10
                    echoMode : TextInput.Password
                    font.family : basefont.name
                    color : "#323232"
                    width : 320
                    height : 30
                    background : Image {
                        source : "assets/input.svg"
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
                    width : 32
                    height : 32
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
                            sddm.login(name.text, password.text, sessionIndex)
                        }
                        onReleased : {
                            parent.source = "assets/buttonup.svg"
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
        spacing: 4

        Text {
            id : lblSession
            width : parent.width
            text : textConstants.session
            font.pointSize : 10
            verticalAlignment : Text.AlignVCenter
            color : "#0c191c"
        }

        ComboBox {
            id : session
            width : parent.width
            height : 24
            font.pixelSize : 10
            font.family : basefont.name
            arrowIcon : "assets/comboarrow.svg"
            model : sessionModel
            index : sessionModel.lastIndex
            borderColor : "#0c191c"
            color : "#eaeaec"
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
//         anchors.bottomMargin : 12
        anchors.rightMargin : 24
        height : 64
        spacing : 24

        Q1.Button {
            id : shutdownButton
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
            KeyNavigation.backtab : loginButton
            KeyNavigation.tab : rebootButton
        }

        Q1.Button {
            id : rebootButton
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
            KeyNavigation.backtab : shutdownButton
            KeyNavigation.tab : name
        }
    }

    Component.onCompleted : {
        if (name.text == "")
            name.focus = true
         else
            password.focus = true

    }
}
