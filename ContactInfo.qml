import QtQuick 2.4
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.0
Item{
    signal backPressed()
    signal contactChanged(string ico, string name,string number)
    property bool nameInputChanged: nameInput.text!=""?true:false
    property bool numberInputChanged: numberInput.text!=""?true:false
    property string newIcon: ""
    property string defaultIcon: "pics/defaultIcon.png"
    property string defaultName: "name"
    property string defaultNumber: "number"
    property bool isFavorite: false
    property string recentCall: ""
    property bool existed: false
    property int id: -1

    property alias deleteBt: deleteBt
    property alias addToFavoriteBt: addToFavoriteBt
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            newIcon = fileUrl
            fileDialog.close()
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close()
        }
        Component.onCompleted: visible = false
    }
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
                source: newIcon==""?defaultIcon:newIcon
                anchors{
                    left: parent.left
                    right: parent.right
                    margins: 10
                }
                height: width
                smooth: false
                clip: true

                Button{
                    id:photoBt
                    anchors{
                        right: parent.right
                        top: parent.top
                        margins: 8
                    }
                    height: parent.height*0.15
                    width: height
                    background: Rectangle{
                        color: photoBt.pressed?"white":"#ff808080"
                        radius: height
                        clip: true
                        Image {
                            source: "pics/pen.png"
                            anchors.fill: parent
                            anchors.margins: 5
                            smooth: false
                        }
                    }

                    onReleased: {
                        fileDialog.open()
                    }
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
                    id: name
                    visible: !nameInputChanged
                    text: defaultName
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 10
                    }
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
                    text: defaultNumber
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 10
                    }
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
        Column{
            id:settings
            property bool show: false
            height: show?parent.height*0.12:0
            width: parent.width*0.5
            anchors{
                right: parent.right
                top: parent.top
            }

            Behavior on height{
                NumberAnimation{
                    duration: 200
                }
            }
             Button{
                 id:addToFavoriteBt
                 visible: parent.height
                 text: isFavorite?"Remove from favorites":"Add to favorites"
                 anchors{
                     left: parent.left
                     right: parent.right
                 }

                 height: parent.height/2
                 enabled: parent.show
             }
             Button{
                 id:deleteBt
                 text: "Delete contact"
                 anchors{
                     left: parent.left
                     right: parent.right
                 }
                 height: parent.height/2
                 enabled: parent.show
             }
        }
        header: ToolBar{
            id:header
            height: parent.height*0.075
            background: Rectangle{
                id:headerBackground
                gradient: Gradient{
                     GradientStop{position:0.0;color: "lightblue"}
                     GradientStop{position:1.0;color: "skyblue"}
                }
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
                        gradient: Gradient{
                             GradientStop{position:0.0;color: "lightblue"}
                             GradientStop{position:1.0;color: backBt.pressed?"gray":"skyblue"}
                        }
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
                        id:btBackground
                        gradient: Gradient{
                             GradientStop{position:0.0;color: "lightblue"}
                             GradientStop{position:1.0;color: backBt.pressed?"gray":"skyblue"}
                        }
                        Text{
                            text:"✓"
                            color: acceptChangesBt.pressed?"black":"white"
                            anchors.centerIn: parent
                            font.pixelSize: parent.height
                        }
                    }
                    onReleased: {
                        contactChanged(newIcon,nameInput.text,numberInput.text)
                        defaultIcon = newIcon===""?defaultIcon:newIcon
                        defaultName = nameInput.text===""?defaultName:nameInput.text
                        defaultNumber = numberInput.text===""?defaultNumber:numberInput.text
                        nameInput.text = ""
                        numberInput.text = ""
                        newIcon = ""
                    }
                }
               Button{
                    id:settingsBt
                    visible: !acceptChangesBt.visible
                    enabled: visible

                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                    }
                    width: height
                    background:  Rectangle{
                        gradient: Gradient{
                             GradientStop{position:0.0;color: "lightblue"}
                             GradientStop{position:1.0;color: settingsBt.pressed?"gray":"skyblue"}
                        }
                        Text{
                            text: "⋮"
                            color: settingsBt.pressed?"black":"white"
                            anchors.centerIn: parent
                            font.pixelSize: parent.height*0.6
                        }
                    }
                    onPressed: {
                        settings.show = !settings.show
                    }
               }

        }
    }

}
