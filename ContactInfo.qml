import QtQuick 2.4
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
Item{
    signal backPressed()
    signal contactChanged(string ico, string name,string number)
    property bool nameInputChanged: nameInput.text!=""?true:false
    property bool numberInputChanged: numberInput.text!=""?true:false
    property string newIcon: ""
    Page{
        anchors.fill: parent
        background: Rectangle{
            color: "#fff0f0f0"
        }
        Column{
            anchors.fill: parent
            spacing: 10
            Image {
                id: avatar
                source: "pics/defaultIcon.png"
                anchors{
                    left: parent.left
                    right: parent.right
                    margins: 10
                }
                height: width
                smooth: false
            }
            Rectangle{
                anchors{
                    right: parent.right
                    left: parent.left
                    margins: 8
                }
                height: parent.height*0.075
                radius: 8
                clip: true
                Text{
                    id: name
                    visible: !nameInputChanged
                }
                TextInput{
                    id:nameInput
                    anchors{
                        fill: parent
                        margins: 8
                    }
                    text: ""
                }
            }
            Rectangle{
                anchors{
                    right: parent.right
                    left: parent.left
                    margins: 8
                }
                height: parent.height*0.075
                radius: 8
                clip: true
                Text{
                    id:number
                    visible: !numberInputChanged
                }
                TextInput{
                    id:numberInput
                    anchors{
                        fill: parent
                        margins: 8
                    }
                    text: ""
                }

            }
        }
        header: ToolBar{
            id:header
            height: parent.height*0.075
            background: Rectangle{
                id:headerBackground
                color: "blue"
                anchors.fill: parent
            }
            anchors{
                left: parent.left
                right: parent.right
            }
                Button{
                    id:backBt
                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                    }
                    width: height
                    background: Rectangle{
                        color: headerBackground.color
                        Text {
                            id: txt
                            color: backBt.pressed?"black":"white"
                            anchors.centerIn: parent
                            font.pixelSize: parent.height
                            text:"<"
                        }
                    }
                    onReleased: {
                        backPressed()
                    }
                }
                Button{
                    id:acceptChangesBt
                    visible: numberInputChanged || nameInputChanged || newIcon!=""
                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                    }
                    width: height
                    Layout.alignment: Qt.AlignRight
                    background: Rectangle{
                        color: headerBackground.color
                        Text{
                            text:"✓"
                            color: acceptChangesBt.pressed?"black":"white"
                            anchors.centerIn: parent
                            font.pixelSize: parent.height
                        }
                    }
                    onReleased: {
                        contactChanged(newIcon,nameInput.text,numberInput.text)
                        backPressed()
                    }
                }
        }
    }

}
