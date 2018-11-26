import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7


Item {


    id: baskanPageDetailitem
    anchors.fill: parent

    Rectangle{
//        anchors.fill: parent
        width: parent.width
        height: parent.height
//        color: "transparent"

        Rectangle{
            id: baskanpagerect
            width: 0
            height: parent.height
            anchors.centerIn: parent
            color: "#99000000"
            Component.onCompleted: {
                openbaskanpageid.running = true
            }

            //        MouseArea{
            //            anchors.fill: parent
            //            onClicked: {
            //                baskanPageDetailitem.destroy();
            //            }
            //        }


            Rectangle{
                width: baskanPageDetailitem.width > 1024 ? 1024 : baskanPageDetailitem.width
                height: parent.height
                anchors.centerIn: parent
                ScrollView{
                    id: scrollid
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    clip: true
                    Column{
                        anchors.fill: parent
//                        Image {
//                            id: name
//                            source: "http://serik.bel.tr/tempfile/20180222161848922%7Bb614d2b8-d93a-4ee5-9d5b-072d2ff4e8e8%7D.jpg"
//                            width: scrollid.contentWidth
//                            height: 450
//                            fillMode: Image.PreserveAspectFit
//                        }
                        Rectangle{
                            width: scrollid.width
                            Text {
                                id: baskantext
                                text: qsTr("Yükleniyor")
                                textFormat: Text.RichText
                                font.pointSize: 14
                                wrapMode: Text.WordWrap
                                width: baskanPageDetailitem.width > 1024 ? 1024 : baskanPageDetailitem.width
                                color: "#888888"
                                horizontalAlignment: Text.AlignJustify
                                anchors.centerIn: parent
                            }
                            height: baskantext.height+20
                            clip: true
                        }



                        Rectangle{
                            width: parent.width
                            height: 50
                            color: "steelblue"
                            Text {
                                color: "#ffffff"
                                text: qsTr("Kapat")
                                font.family: "Tahoma"
                                font.bold: true
                                font.pointSize: 11
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                anchors.centerIn: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    baskanPageDetailitem.destroy();

                                }
                            }
                        }
                    }




                }
            }


        }

        PropertyAnimation{
            id: openbaskanpageid
            target: baskanpagerect
            property: "width"
            to: parent.width > 1024 ? 1024 : parent.width
            duration: 1350
            onStopped: {
                var filter = QBSON.newBSON();

                filter.addOid("_id","5a8ec33fae94be25600051a6");

                var baskan = db.find_one("Yonetim",filter,QBSON.newBSON())

                var filelist = baskan.getElement("fileList");

                var array = filelist.Array;

                for( var i = 0 ; i < array.count ; i++ )
                {
                    var e = array.getElement(i);
                }

                var html = Utility.repairHTML( baskan.getElement("html").String , baskanpagerect.width );


                baskantext.text = html;
            }
        }
    }




//    PropertyAnimation{
//        id: openbaskanpageid
//        target: baskanpagerect
//        property: "width"
//        to: parent.width
//        duration: 1350
//        onStopped: {
//            var filter = QBSON.newBSON();

//            filter.addOid("_id","5a8ec33fae94be25600051a6");


//            var option = QBSON.newBSON();

//            var baskan = db.find_one("Yonetim",filter,option)
//            baskantext.text = baskan.getElement("html").String
//        }
//    }

}
