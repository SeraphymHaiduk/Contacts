import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

ListView{
    id:root
    spacing: 10
    property int id: id
    signal contactOpen(int id,string ico,string name,string number)
    delegate: Button{
        id:bt
       height: root.height*0.1
       width: root.width
       background: Rectangle{
           radius: 5
           color: bt.pressed?"white":"red"
       }
        onReleased: {
            contactOpen(id,image,name,number)
        }
       Image {
           id: img
           source: image==""?"pics/defaultIcon.png":image
           anchors{
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            margins: 5
           }
           width: height
           layer.enabled: true
           layer.effect: OpacityMask{
                maskSource:  Rectangle{
                    id:imgRect
                    width: img.width
                    height: img.height
                    anchors.centerIn: parent
                    radius: height/2
                 }
           }
       }

       Text {
           id: nm
           text: name==""?"name":name
           anchors{
                left: img.right
                verticalCenter: parent.top
                verticalCenterOffset: parent.height*0.25
                leftMargin: 5
           }
       }
       Text{
            id:nmbr
            text: number===""?"number":number
            anchors{
                 left: img.right
                 verticalCenter: parent.bottom
                 verticalCenterOffset: -parent.height*0.25
                 leftMargin: 5
            }
       }

    }
}
