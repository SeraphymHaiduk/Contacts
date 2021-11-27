import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import ContactListProvider 1.0

Window {
    id: mainWindow
    width: 400
    height: 600
    visible: true
    title: qsTr("Hello World")
    /*FileDialog {
                     id: fileDialog
                     title: "Please choose a file"
                     folder: shortcuts.home
                     onAccepted: {
                         console.log("You chose: " + fileDialog.fileUrls)
                         fileDialog.close()
                     }
                     onRejected: {
                         console.log("Canceled")
                         fileDialog.close()
                     }
                     Component.onCompleted: visible = true
                 }*/
    Provider{
     id:provider
    }
    Component{
       id:pageCompoment

        Page{
        SwipeView{
            id:swipeControl
            currentIndex: 1
            anchors{
               fill: parent
            }
            Rectangle{
                id:favoritesPage
                Image {
                    id: img
                    source: fileDialog.fileUrl
                }
            }
            Rectangle{
                id: recentCallsPage
                 ContactList{
                    anchors{
                        fill:parent
                        margins: 8
                    }
                 }
            }
            Rectangle{
                id:contactsPage
                property variant map: []
                 ContactList{
                    id:mainContactsList
                    anchors{
                        fill:parent
                        margins: 8
                    }
                    function showContacts(){
                        console.log("axaxa")
                        contactsPage.map = provider.getChunk(1,20)
                        console.log(contactsPage.map[7]) //настроить отрисовку контактов
                    }

                    Component.onCompleted: {
                        showContacts()
                    }

                 }

            }
            onCurrentIndexChanged : {
                console.log(currentIndex)
            }
            Connections{
                target: head
                function onPageChanged(index){
                    swipeControl.setCurrentIndex(index)
                }
            }
        }
        Button{
           id:addBt
           height: parent.height*0.1
           width: height
           anchors{
               right: parent.right
               bottom: parent.bottom
               margins: 8
           }
           background: Rectangle{
              radius: height
              color: addBt.pressed?"white":"blue"
              Text {
                  text: qsTr("+")
                  font.pixelSize: parent.height
                  color: "white"
                  anchors{
                      left: parent.left
                      right: parent.right
                      bottom: parent.bottom
                      top: parent.top
                      leftMargin: parent.width*0.22
                      topMargin: -parent.height*0.1
                  }
              }

           }
           onReleased:{
                stack.push(infoComponent)
           }
        }

         header: Header{
             id:head
             anchors{
                left: parent.left
                right: parent.right
             }
             height: parent.height*0.15
             pageActive: swipeControl.currentIndex


         }
        }
    }
    StackView{
        id:stack
        anchors.fill: parent
        initialItem: pageCompoment
    }
    Component{
        id:infoComponent
        ContactInfo{
            id:info
            onBackPressed: {
                stack.pop()
                console.log("back pressed")
            }
           onContactChanged: {
                console.log(ico,name,number)
                provider.addContact(ico,name,number)
           }
        }
    }
}
