import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7

import "Header"
import "Main"

Window {
    visible: true
    width: 360
    height: 640
    title: qsTr("Serik Belediyesi Resmi Uygulaması - 2018")

    MongoDB{
        id: db
    }

    // Main Rectangle All İtems is İnside
    Rectangle{
        id: root
        anchors.fill: parent

        color: "gray"


        Header{
            id: headerid
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width
            height: 60
            z: 2
        }

        MainRect{
            id: mainRectid
            anchors.top: headerid.bottom
            anchors.bottom: parent.bottom
            width: parent.width
        }

//        Rectangle{
//            id: footerid
//            width: parent.width
//            height: 50
//            color: "orange"
//            anchors.bottom: parent.bottom
//        }







    }

}
