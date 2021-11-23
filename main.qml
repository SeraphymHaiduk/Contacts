import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
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
            ContactList{
                anchors{
                    fill:parent
                    margins: 8
                }
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
