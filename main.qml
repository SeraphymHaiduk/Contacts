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
            currentIndex: 2
            anchors{
               fill: parent
            }
            Rectangle{
                id:favoritesPage
                ContactList{
                    id:favoriteContactsList
                    anchors{
                        fill:parent
                        margins: 8
                    }
                    property variant container
                    model: ListModel{
                        id: favoritesListModel
                    }
                    onContactOpen: {
                        stack.push(infoComponent)
                        stack.contactOpen(id,ico,name,number,isFavorite,recentCall)
                    }
                    function showContacts(){
                        container = provider.getFavorites()
                        console.log(container)
                        for(var i = 0;i<container.length;i+=6){
                            favoritesListModel.append({  "id":contactsList.map[i],
                                                 "name":favoriteContactsList.container[i+1],
                                                 "number":favoriteContactsList.container[i+2],
                                                 "image":favoriteContactsList.container[i+3],
                                                 "isFavorite":true,
                                                 "recentCall":favoriteContactsList.container[i+5]
                                             })
                        }
                    }

                    Component.onCompleted: {
                        favoriteContactsList.showContacts()
                    }
                    Connections{
                        target: stack
                        function onUpdateList(){
                            favoritesListModel.clear()
                            favoriteContactsList.showContacts()
                        }
                    }
                }
            }
            Rectangle{
                id:recentCallsPage
                 ContactList{
                    id:recentCallsContactsList
                    anchors{
                        fill:parent
                        margins: 8
                    }

                 }
            }
            Rectangle{
                id: contactPage
                 ContactList{
                    id:contactsList
                    property variant map
                    property variant contactsCount
                    anchors{
                        fill:parent
                        margins: 8
                    }
                    model: ListModel{
                        id:listModel
                    }
                    onContactOpen: {
                        stack.push(infoComponent)
                        stack.contactOpen(id,ico,name,number,isFavorite,recentCall)
                    }
                    onMovementEnded: {
                        if(contactsList.atYEnd){
                            showContacts(listModel.count,10)
                        }
                    }

                    function showContacts(start,count){
                        contactsList.map = provider.getChunk(start,count)
                        for(var i = 0;i<contactsList.map.length;i+=6){
                            listModel.append({  "id":contactsList.map[i],
                                                 "name":contactsList.map[i+1],
                                                 "number":contactsList.map[i+2],
                                                 "image":contactsList.map[i+3],
                                                 "isFavorite":contactsList.map[i+4]?1:0,
                                                 "recentCall":contactsList.map[i+5],
                                             })
                        }
                    }
                    Connections{
                        target: stack
                        function onUpdateList(){
                            listModel.clear()
                            contactsList.showContacts(1,10)
                        }
                    }
                    Component.onCompleted: {
                        contactsList.showContacts(1,10)
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
             onFinding: {
                if(b){
                    findPage.opacity = 1
                }
                else{
                    findPage.opacity = 0
                }
             }
             onFind: {
                findingfContactsList.show(text)
             }

         }

             Rectangle{
                 id:findPage
                 opacity: 0
                 visible: opacity
                 anchors.fill: parent
                 color: "white"
                    MouseArea{
                        anchors.fill: parent
                        visible: findPage.opacity
                        enabled: findPage.opacity

                    }
                    Behavior on opacity{
                            NumberAnimation{ duration: 200}
                    }
                    ContactList{
                        id:findingfContactsList
                        property variant container
                        anchors{
                            fill: parent
                            margins: 8
                        }
                        model: ListModel{
                            id:findingfContactsListModel
                        }
                        onContactOpen: {
                            stack.push(infoComponent)
                            stack.contactOpen(id,ico,name,number,isFavorite,recentCall)
                        }
                        function show(text){
                            findingfContactsListModel.clear()
                            container = provider.find(text,20)
                            for(var i = 0;i<findingfContactsList.container.length;i+=6){
                                findingfContactsListModel.append({  "id":findingfContactsList.container[i],
                                                     "name":findingfContactsList.container[i+1],
                                                     "number":findingfContactsList.container[i+2],
                                                     "image":findingfContactsList.container[i+3],
                                                     "isFavorite":findingfContactsList.container[i+4]?1:0,
                                                     "recentCall":findingfContactsList.container[i+5]
                                                 })
                            }
                        }
                        Connections{
                            target:stack
                            function onUpdateList(){
                                show()
                            }
                        }
                    }
             }

        }
    }
    StackView{
        id:stack
        anchors.fill: parent
        initialItem: pageCompoment
        signal updateList()
        signal contactOpen(int id,string ico,string name,string number,bool favorite,string recentCall)

    }
    Component{
        id:infoComponent
        ContactInfo{
            id:info
            onBackPressed: {
                stack.updateList()
                stack.pop()
            }
           onContactChanged: {
               if(existed){
                    provider.setContactSettings(info.id,
                                                ico==""?info.defaultIcon:ico,
                                                name==""?info.defaultName:name,
                                                number==""?info.defaultNumber:number)
               }
               else{
                    provider.addContact(ico,name,number)
               }
           }
            Connections{
                target: stack
                function onContactOpen(id,ico,name,number,isFavorite,recentCall){
                    console.log("contact opened")
                    info.existed = true
                    info.id = id
                    info.defaultIcon = ico===""?"pics/defaultIcon.png":ico
                    info.defaultName = name===""?"name":name
                    info.defaultNumber = number===""?"number":number
                    info.isFavorite = isFavorite
                    console.log("yes")
                }
            }
            addToFavoriteBt.onReleased: {
                if(isFavorite){
                    provider.removeFromFavorites(info.id)
                }
                else{
                    provider.addToFavorites(info.id)
                }
                info.isFavorite = !info.isFavorite
            }
            deleteBt.onReleased: {
                if(id!=-1){
                    provider.deleteContact(info.id)
                }
                else{
                    console.log("Вы ещё не создали контакт")
                }
                backPressed()
            }
        }
    }
}
