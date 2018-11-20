import QtQuick 2.11
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


import com.mongodb 0.7

Item{

    id: item


    anchors.fill: parent

    anchors.topMargin: 60

    onWidthChanged: {
        if( width > 1024 )
        {
            anchors.topMargin = 81
        }else{
            anchors.topMargin = 60
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#CC000000"

        MouseArea{
            anchors.fill: parent
        }


        Rectangle {
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "#CCFFFFFF"
            anchors.centerIn: parent


            Rectangle {
                anchors.fill: parent
                color: "red"
                anchors.bottomMargin: 50
                border.width: 5
                border.color: "white"


            }






            Rectangle {
                width: parent.width
                height: 50
                color: "crimson"
                Text {
                    text: qsTr("Kapat")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }

                anchors.bottom: parent.bottom

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item.destroy();
                    }
                }
            }
        }
    }



}
