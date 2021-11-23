import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4

Rectangle{
        id:root
        color: "blue"
        property int pageActive: 1
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
            radius: height
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
     }
