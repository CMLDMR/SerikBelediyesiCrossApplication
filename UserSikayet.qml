import QtQuick 2.11
import QtQuick.Controls 2.3

import com.mongodb 0.7

Item {
    id: item
    anchors.fill: parent


    Rectangle {
        width: parent.width
        height: parent.height
        color: "#CC000000"
        MouseArea{
            anchors.fill: parent
        }

        Rectangle {
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "white"
            anchors.centerIn: parent


            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                Text {
                    text: qsTr("Taleplerim/Şikayetrim")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "Gray"
                    anchors.centerIn: parent
                }
                anchors.top: parent.top
            }


            Rectangle {
                id: contentRect
                anchors.fill: parent
                anchors.topMargin: 50
                anchors.bottomMargin: 100
                color: "transparent"

                ScrollView{
                    id: scroller
                    clip: true
                    anchors.fill: parent
                    property int rWidth: width
                    onWidthChanged: {
                        if( width < 400 )
                        {
                            rWidth = width
                        }

                        if( width >= 400 && width < 600 )
                        {
                            rWidth = width/2
                        }
                        if( width >= 600 && width < 800 )
                        {
                            rWidth = width/3
                        }
                        if( width >= 800 && width < 1000 )
                        {
                            rWidth = width/4
                        }
                        if( width >= 1000 )
                        {
                            rWidth = width/5
                        }
                    }

                    Flow{
                        width: contentRect.width
                        height: parent.contentHeight

                        Repeater{
                            Rectangle {
                                width: scroller.rWidth
                                height: 65
                                color: "transparent"


                                Rectangle {
                                    id: sitem
                                    width: parent.width-5
                                    height: parent.height-5
                                    color: "Gray"
                                    anchors.centerIn: parent

                                    Column{
                                        anchors.fill: parent
                                        spacing: 1

                                        Rectangle {
                                            width: parent.width
                                            height: 30
                                            color: "transparent"

                                            Text {
                                                text: qsTr(modelData.getElement("Durum").String)
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }

                                            Component.onCompleted: {
                                                if( modelData.getElement("Durum").String === "Tamamlandı" )
                                                {
                                                    sitem.color = "Green"
                                                }else if( modelData.getElement("Durum").String === "Devam Ediyor" )
                                                {
                                                    sitem.color = "steelblue"
                                                }else if( modelData.getElement("Durum").String === "Tekrar Açıldı" )
                                                {
                                                    sitem.color = "Firebrick"
                                                }else if( modelData.getElement("Durum").String === "İptal Edildi" )
                                                {
                                                    sitem.color = "red"
                                                }else if( modelData.getElement("Durum").String === "Beklemede" )
                                                {
                                                    sitem.color = "orange"
                                                }
                                            }
                                        }
                                        Rectangle {
                                            width: parent.width
                                            height: 30
                                            color: "transparent"
                                            Text {
                                                text: qsTr(modelData.getElement("Mahalle").String)
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }

                                    }




                                }

                            }

                            Component.onCompleted: {

                                var filter = QBSON.newBSON();

                                filter.addString("Şikayet/Talep Sahibi",User.telefon)

                                model =db.find("Sikayet",filter,QBSON.newBSON());
                            }

                        }

                    }
                }
            }







            Rectangle {
                width: parent.width
                height: 50
                color: "DarkSlateGray"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                Text {
                    text: qsTr("Yeni Talep/Şikayet Ekle+")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item.destroy();
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: "crimson"
                anchors.bottom: parent.bottom
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
                        item.destroy();
                    }
                }
            }

        }

    }


}
