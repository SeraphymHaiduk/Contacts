import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4

Rectangle{
        id:root
        color: "blue"
        property int pageActive: 1
        signal finding(bool b)
        signal find(string text)
        signal pageChanged(int index)
        Column{
            height: parent.height/2
            anchors{
                fill:parent
                topMargin: 8
            }
        Rectangle{
            height: parent.height/2
            anchors{
                left: parent.left
                right: parent.right
                margins: 8
            }
            color:"white"
            radius: height/2
            Text{
                text: "🔍"
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                    verticalCenterOffset: 5
                }
                height: parent.height
                width: height
                font.pixelSize: parent.height*0.6
            }
            MouseArea{
                anchors.fill: parent
                onReleased: {
                    finding(true)
                    findingHead.opacity = 1
                    console.log("finding pressed")
                }
            }
        }
            Row{
                height: parent.height/2
                anchors{
                    left: parent.left
                    right: parent.right
                }
                Button{
                    id: favoriteBt
                    width: parent.width/3
                    height: parent.height
                    property bool active: root.pageActive==0?1:0
                    background: Rectangle{
                            anchors.fill: parent
                            color: favoriteBt.pressed?"white": root.color
                            }
                    onReleased: {
                        console.log("favorites")
                        pageChanged(0)
                    }

                    Text{
                        anchors.centerIn: parent
                        text: "★"
                        font.pixelSize: parent.height/2
                        color: "white"
                    }
                    Rectangle{
                        visible: favoriteBt.active
                        anchors{
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        height: 3
                        color: "white"
                    }
                }
                Button{
                    id: recentBt
                    width: parent.width/3
                    height: parent.height
                    property bool active: root.pageActive==1?1:0
                    background: Rectangle{
                            anchors.fill: parent
                            color: recentBt.pressed?"white": root.color
                            }
                    onReleased: {
                        console.log("recent calls")
                        pageChanged(1)
                    }
                    Text{
                        anchors.centerIn: parent
                        text: "⌚"
                        font.pixelSize: parent.height/2
                        color: "white"
                    }
                    Rectangle{
                        visible: recentBt.active
                        anchors{
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        height: 3
                        color: "white"
                    }
                }
                Button{
                    id: contactsBt
                    width: parent.width/3
                    height: parent.height
                    property bool active: root.pageActive==2?1:0
                    background: Rectangle{
                            anchors.fill: parent
                            color: contactsBt.pressed?"white": root.color
                            }
                    onReleased: {
                        console.log("contacts")
                        pageChanged(2)
                    }
                    Text{
                        anchors.centerIn: parent
                        text: "🙍"
                        font.pixelSize: parent.height/2
                        color: "white"
                    }
                    Rectangle{
                        visible: contactsBt.active
                        anchors{
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        height: 3
                        color: "white"
                    }
                }
            }
        }
        Rectangle{
            id:findingHead
            anchors.fill: parent
            opacity: 0
            color: "#fff0f0f0"
            MouseArea{
                anchors.fill: parent
                enabled: findingHead.opacity
            }
            Rectangle{
                color: "white"
                height: parent.height/2
                width: parent.width
                anchors{
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 10
                }
                Button{
                    id:backBt
                    enabled: findingHead.opacity
                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: height
                    onReleased: {
                        finding(false)
                        findingHead.opacity = 0

                    }
                }
                Rectangle{
                    anchors{
                        fill: parent
                        leftMargin: backBt.width
                    }
                    clip: true
                    TextInput{
                        id:findingTextInput
                        anchors.fill: parent
                        enabled: findingHead.opacity
                        font.pixelSize: parent.height*0.7
                        onTextChanged: find(findingTextInput.text)
                    }
                }



            }
            Behavior on opacity{
                    NumberAnimation{ duration: 200}
            }

        }
     }
