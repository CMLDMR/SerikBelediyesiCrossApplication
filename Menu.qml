import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent
    property int h: 446


    Rectangle {
        width: parent.width
        height: parent.height
        color: "#AA000000"
        MouseArea{
            anchors.fill: parent
        }



        Rectangle {
            id: content
            width: parent.width > 1024 ? 1024 : parent.width
            height: 0 // 200
            color: "white"
            anchors.centerIn: parent
            clip: true

            Column{
                anchors.fill: parent
                spacing: 3

                Rectangle {
                    width: parent.width
                    height: 20
                    color: "Gray"
                    Text {
                        text: qsTr("Menü")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Meclis")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {

                            var com = Qt.createComponent("qrc:/Meclis/MeclisKararlari.qml");

                            if( com.status === Component.Ready )
                            {
                                var e = com.createObject(item);
                                if( e === null )
                                {
                                    Utility.information = "Meclis Paneli Oluşturulamadı";
                                }else{
//                                    closeDown();
                                }
                            }else{
                                Utility.information = "Meclis Paneli Oluşturulamadı";
                            }

                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Projeler & Çalışmalar")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Haberler")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Etkinlikler")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Galeri")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("Bilgi Edinme")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("İletişim")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "Crimson"
                    Text {
                        text: qsTr("Kapat")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            closeDown();
                        }
                    }
                }
            }
        }

    }

    Component.onCompleted: {
        openUP();
    }


    PropertyAnimation{
        id: openUP_
        target: content
        property: "height"
        from: 0
        to: h
        duration: 250
    }

    PropertyAnimation{
        id: closeDOWN_
        target: content
        property: "height"
        from: h
        to: 0
        duration: 250
        onStopped: {
            item.destroy();
        }
    }



    function openUP(){
        openUP_.start();
    }

    function closeDown(){
        closeDOWN_.start();
    }


}
