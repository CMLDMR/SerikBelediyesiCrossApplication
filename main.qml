import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
//import Utility 0.7


import com.mongodb 0.7

import "Header"
import "Main"

Window {
    id: mRoot
    visible: true
    width: 360
    height: 640
    title: qsTr("Serik Belediyesi Resmi Uygulaması - 2018")

//    MongoDB{
//        id: db
//    }


    onWidthChanged: {
        Utility.rootWidth = width;
        Utility.rootHeight = height;
    }



    onHeightChanged: {
        Utility.rootWidth = width;
        Utility.rootHeight = height;
    }

//    Component.onCompleted: {
//        Utility.rootWidth = width;
//        Utility.rootHeight = height;
//    }


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
    }

    Rectangle {
        id: infoRect
        anchors.centerIn: parent
        width: mRoot.width
        height: 0
        color: "#CC000000"
        clip: true

        MouseArea{
            anchors.fill: parent
        }

        Rectangle {
            width: parent.width
            height: 250
            color: "#CC000000"
            anchors.centerIn: parent
            Column{
                anchors.fill: parent

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "Gray"
                    Text {
                        text: qsTr("Bilgi")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 150
                    color: "DarkSlateGray"
                    Text {
                        id: messageText
                        text: qsTr("Bilgi")
                        font.bold: false
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "Crimson"
                    Text {
                        text: qsTr("Kapat")
                        font.bold: false
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            closeinfoRect.start();
                        }
                    }
                }
            }
        }
    }



    Connections{
        target: Utility
        onInformationChanged:{
            messageText.text = Utility.information;
            openinfoRect.start();
        }
    }


    PropertyAnimation{
        id: openinfoRect
        target: infoRect
        property: "height"
        from: 0
        to: mRoot.height
        duration: 250
    }

    PropertyAnimation{
        id: closeinfoRect
        target: infoRect
        property: "height"
        from: mRoot.height
        to: 0
        duration: 250
    }

//    Component.onCompleted: {
//        openinfoRect.start();
//    }


}
