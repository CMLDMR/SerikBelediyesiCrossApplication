import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7


Item {

    id: sliderDetailPage
    anchors.fill: parent

    property string oid: ""

    Rectangle{
        width: parent.width
        height: parent.height
        color: "#80161313"

        MouseArea{
            anchors.fill: parent
        }

        Rectangle{

            id: sliderPageContentRectid
            width: 0
            height: parent.height
            anchors.centerIn: parent
            anchors.margins: 5

            ScrollView{
                anchors.topMargin: 40
                anchors.fill: parent
                clip: true


                Column{
                    anchors.fill: parent
                    spacing: 20

                    Rectangle{
                        id: titleareneid
                        color: "orange"
                        width: parent.width


                        Image {
                            id: slideDetailimg
                            source: "file"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            Rectangle{
//                                color: "#994f4c4c"
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.40;
                                        color: "#000f0c0c";
                                    }
                                    GradientStop {
                                        position: 1.00;
                                        color: "#ff030000";
                                    }
                                }
                                anchors.fill: parent

                                Text {
                                    id: haberTitleid
                                    width: sliderPageContentRectid.width
                                    color: "#ffffff"
                                    text: "Yükleniyor... Lütfen Bekleyiniz"
                                    font.bold: true
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pointSize: 15
                                    wrapMode: Text.WordWrap
                                    anchors.margins: 10
                                    anchors.bottom: parent.bottom
                                }
                            }
                        }
                        height: 200
                    }



                    Rectangle{
                        width: sliderPageContentRectid.width
                        Text {
                            id: haberdetailid
                            text: qsTr("Yükleniyor")
                            textFormat: Text.RichText
                            width: sliderPageContentRectid.width
                            wrapMode: Text.WordWrap
                            anchors.margins: 10
                            Component.onCompleted: {
                                parent.height = haberdetailid.height+20
                            }
                        }
                        anchors.margins: 10
                    }

                    Rectangle{
                        width: sliderPageContentRectid.width
                        height: 50
                        Text {
                            text: qsTr("Geri Dön")
                            font.bold: true
                            font.pointSize: 12
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.RichText
                            width: sliderPageContentRectid.width
                            color: "#fdf8f8"
                            wrapMode: Text.WordWrap
                            anchors.margins: 10
                            anchors.centerIn: parent
                        }
                        color: "#10658f"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                print(sliderDetailPage.oid);
                                haberdetailid.destroy();
                                sliderPageContentRectCloseid.running = true
                            }
                        }
                    }


                }
            }


            Component.onCompleted: {
                sliderPageContentRectOpenid.running = true
            }


        }


        PropertyAnimation{
            id: sliderPageContentRectOpenid
            target: sliderPageContentRectid
            property: "width"
            from: 0
            to: parent.width > 600 ? 600 : parent.width
            duration: 250
            onStopped: {
                loadSlide(sliderDetailPage.oid);
            }
        }

        PropertyAnimation{
            id: sliderPageContentRectCloseid
            target: sliderPageContentRectid
            property: "width"
            from: parent.width > 600 ? 600 : parent.width
            to: 0
            duration: 250
            onStopped: {
                sliderDetailPage.destroy();
            }
        }


    }


    function loadSlide(oid){

        var filter = QBSON.newBSON();

        filter.addOid("_id",oid);

        var option = QBSON.newBSON();

        var e = db.find_one("Slider",filter,option);

        var w = parent.width > 600 ? 600 : parent.width;

        var html = Utility.repairHTML(e.getElement("html").String,w);

        haberdetailid.text = html;
        haberTitleid.text = e.getElement("title").String;

        slideDetailimg.source = db.fileurl(e.getElement("sliderImg").Oid);

        if( titleareneid.width > 360 )
        {
            var w = titleareneid.width / 360;
            titleareneid.height *= w;

        }



    }





}
