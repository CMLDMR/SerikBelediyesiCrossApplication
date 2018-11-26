import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent


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
            height: parent.height
            color: "white"

            anchors.centerIn: parent

            property int rWidth: width

            onWidthChanged: {
                if( width < 300 )
                {
                    rWidth = width
                }

                if( width >= 300 && width < 500 )
                {
                    rWidth = width/2
                }
                if( width >= 500 && width < 700 )
                {
                    rWidth = width/3
                }
                if( width >= 700 && width < 900 )
                {
                    rWidth = width/4
                }

                if( width >= 900 && width < 1100 )
                {
                    rWidth = width/5
                }
                if( width >= 1100 )
                {
                    rWidth = width/6
                }
            }


            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                anchors.top: parent.top
                Text {
                    text: qsTr("Meclis Kararları")
                    font.bold: true
                    font.pointSize: 12
                    font.family: "Tahoma"
                    color: "Gray"
                    anchors.centerIn: parent
                }
            }




            ScrollView{
                anchors.fill: parent
                clip: true
                anchors.bottomMargin: 50
                anchors.topMargin: 50


                Flow{
                    width: content.width
                    height: parent.contentHeight

                    Repeater{
                        Rectangle {
                            width: content.rWidth
                            height: 85
                            color: "transparent"
                            Rectangle {
                                width: parent.width - 5
                                height: parent.height - 5
                                color: "Gray"
                                Column{

                                    anchors.fill: parent

                                    Rectangle {
                                        width: parent.width
                                        height: 25
                                        color: "transparent"
                                        Text {
                                            text: parseInt(modelData.getElement("Yıl").Double)
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "white"
                                            anchors.centerIn: parent
                                        }
                                    }

                                    Rectangle {
                                        width: parent.width
                                        height: 25
                                        color: "transparent"
                                        Text {
                                            text: modelData.getElement("Ay").String
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
                                    Rectangle {
                                        width: parent.width
                                        height: 25
                                        color: "transparent"
                                        Text {
                                            text: "Karar Sayısı: "+modelData.getElement("kararlar").Array.count
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

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {

                                        var com = Qt.createComponent("qrc:/Meclis/Kararlar.qml");

                                        if( com.status === Component.Ready )
                                        {

                                            var e = com.createObject(item,{"karar":modelData});

                                            if( e === null )
                                            {
                                                Utility.information = "Kararlar Paneli Yüklenemedi";
                                            }

                                        }else{
                                            Utility.information = "Kararlar Paneli Yüklenemedi";
                                        }

                                    }
                                }
                            }

                        }

                        Component.onCompleted: {
                            var filter = QBSON.newBSON();

                            filter.addBool("Yayında",true);

                            var option = QBSON.newBSON();

                            var sortDoc = QBSON.newBSON();

                            sortDoc.addInt("_id",-1);

                            option.addBson("sort",sortDoc);

//                            var projection = QBSON.newBSON();

//                            projection.addBool("Ay",true);
//                            projection.addBool("Yıl",true);
//                            option.addBson("projection",projection);

                            model = db.find("Meclis",filter,option);
                        }

                    }
                }
            }


            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                anchors.bottom: parent.bottom
                Text {
                    text: qsTr("Kapat")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "Gray"
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
