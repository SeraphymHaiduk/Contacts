import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import ContactListProvider 1.0
Window {
    id: root
    width: 640
    height: 480
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
    Page{
        anchors.fill: parent

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
             ContactList{
                anchors{
                    fill:parent
                    margins: 8
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
