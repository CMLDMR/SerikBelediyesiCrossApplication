import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent

    property string oid: ""

    property QBSON sikayet: QBSON.newBSON();


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
            color: "transparent"
            anchors.centerIn: parent


            Rectangle {
                id: itemRect
                anchors.fill: parent
                color: "transparent"
                anchors.bottomMargin: 50

                ScrollView{
                    anchors.fill: parent
                    clip: true

                    Column{
                        anchors.fill: parent
                        spacing: 5
                        Text {
                            text: Utility.currentStringDay(sikayet.getElement("julianDay").Int64);
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: sikayet.getElement("Mahalle").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: sikayet.getElement("Birim").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: sikayet.getElement("Durum").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: sikayet.getElement("Kategori").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: sikayet.getElement("Tam Adres").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            id: konuText
                            text: sikayet.getElement("Konu").String;
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            width: itemRect.width
                            horizontalAlignment: Text.AlignJustify
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                        }


                        Repeater{
//                            model: sikayet.getElement("AŞAMA").Array
                            Rectangle {
                                width: itemRect.width
                                height: 100
                                color: "transparent"
                                Rectangle {
                                    width: parent.width-5
                                    height: parent.height-5
                                    anchors.centerIn: parent
                                    radius: 2
                                    gradient: Gradient {
                                        GradientStop {
                                            position: 0.00;
                                            color: "#dddddd";
                                        }
                                        GradientStop {
                                            position: 0.50;
                                            color: "#ffffff";
                                        }
                                        GradientStop {
                                            position: 1.00;
                                            color: "#f1f1f1";
                                        }
                                    }
                                    Column{
                                        anchors.fill: parent
                                        spacing: 3
                                        Text {
                                            text: modelData.getElement("Tarih").String
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "gray"
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                        }
                                        Text {
                                            text: modelData.getElement("Saat").String
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "black"
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                        }
                                        Text {
                                            text: modelData.getElement("Birim").String
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "black"
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                        }

                                        Text {
                                            font.bold: false
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "black"
                                            width: parent.width
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                            Component.onCompleted: {
                                                if( modelData.getElement("Tip").String === "Açıklama" )
                                                {
                                                    text = modelData.getElement("Açıklama").String;
                                                }else if( modelData.getElement("Tip").String === "Değişiklik" ){
                                                    text = modelData.getElement("Değişim").String
                                                }
                                            }
                                        }


                                    }



                                }

                            }

                            Component.onCompleted: {

                                var list = new Array;

                                var slist = sikayet.getElement("AŞAMA").Array

                                for( var i = 0 ; i < slist.count ; i++ )
                                {
                                    list.push(slist.getElement(i).Bson)
                                }

                                model = list;

                            }
                        }
                    }
                }
            }






//            Text {
//                text: sikayet.getElement("Konu").String
//                font.bold: true
//                font.pointSize: 10
//                font.family: "Tahoma"
//                color: "white"
//                textFormat: Text.RichText
//                anchors.centerIn: parent
//                width: parent.width
//                wrapMode: Text.WordWrap
//                horizontalAlignment: Text.AlignJustify
//            }



            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                Text {
                    text: qsTr("Kapat")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "Gray"
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

    Component.onCompleted: {

        var filter = QBSON.newBSON();

        filter.addOid( "_id" , oid );

        sikayet = db.find_one("Sikayet",filter,QBSON.newBSON());

    }

}
