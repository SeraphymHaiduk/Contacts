import QtQuick 2.0
import QtQuick 2.12

ListView{
    id:root
    spacing: 10
    delegate: Rectangle{
       height: root.height*0.1
       width: root.width
       Text {
           text: txt
       }
       radius: 5
       color: "red"
    }
    model: ListModel{
        id:listModel
    }
}
