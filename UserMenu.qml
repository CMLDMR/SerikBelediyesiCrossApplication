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
                color: "LightGray"
                anchors.bottomMargin: 50

                ScrollView{
                    id: scrollerid
                    anchors.fill: parent
                    anchors.topMargin: 20
                    clip: true
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

                        if( width >= 1000 && width < 1200 )
                        {
                            rWidth = width/5
                        }
                    }


                    Flow{
                        width: parent.parent.width
                        height: parent.contentHeight
                        spacing: 0

                        //Şikayetler Menü
                        Rectangle {
                            width: scrollerid.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "DarkGray"
                                anchors.centerIn: parent
                                Text {
                                    text: qsTr("Şikayetlerim")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                        //Bilgi Edinme Başvuruları
                        Rectangle {
                            width: scrollerid.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "DarkGray"
                                anchors.centerIn: parent
                                Text {
                                    text: qsTr("Bilgi Edinme Başvurumlarım")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                        //e-Belediye
                        Rectangle {
                            width: scrollerid.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "steelblue"
                                anchors.centerIn: parent
                                Text {
                                    text: qsTr("e-Belediye")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                        //Çek Gönder
                        Rectangle {
                            width: scrollerid.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "RoyalBlue"
                                anchors.centerIn: parent
                                Text {
                                    text: qsTr("Çek Gönder")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                        //Bilgi Danışma
                        Rectangle {
                            width: scrollerid.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "DarkGray"
                                anchors.centerIn: parent
                                Text {
                                    text: qsTr("Bilgi Danışma")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
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
