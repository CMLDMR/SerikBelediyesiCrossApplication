import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7
//import Utility 0.7


Item {

    id: duyuruitemid
    anchors.fill: parent

    property string oid: ""


    Rectangle{
        id: duyuruMainRectid
        width: 0
        height: parent.height
        anchors.top: parent.top
        color: "#807d7d7d"

        MouseArea{
            anchors.fill: parent
        }

        Rectangle{
            id: contentRect
            width: parent.width > 900 ? 900 : parent.width
            height: parent.height
            anchors.centerIn: parent

            ScrollView{
                anchors.fill: parent
                clip: true
                anchors.bottomMargin: 50

                Column{
                    anchors.fill: parent
                    Rectangle{
                        width: contentRect.width
                        height: contentRect.width/3
                        Image {
                            source: "qrc:/img/img/duyuru1.JPG"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            Text {
                                id: titleid
                                color: "#ffffff"
                                text: qsTr("text")
                                font.family: "Tahoma"
                                font.bold: true
                                font.pointSize: 11
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                anchors.bottom: parent.bottom
                                width: parent.width
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    Text {
                        id: contenttext
                        text: qsTr("Yükleniyor")
                        width: parent.width
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        onLinkActivated: {
                            print( "LINK " + link );
                            Qt.openUrlExternally(link)
                        }
                    }

                }
            }

            Rectangle{
                width: parent.width
                height: 50
                color: "steelblue"
                anchors.bottom: parent.bottom
                Text {
                    color: "#ffffff"
                    text: qsTr("Geri")
                    font.bold: true
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        duyuruMainRectidCloseup.running = true
                    }
                }
            }
        }



    }


    Component.onCompleted: {
        duyuruMainRectidOpenup.running = true




    }


    PropertyAnimation{
        id: duyuruMainRectidOpenup
        target: duyuruMainRectid
        property: "width"
        from: 0
        to: parent.width
        duration: 250
        onStopped: {
            var filter = QBSON.newBSON();
            filter.addOid("_id",duyuruitemid.oid);

            var option = QBSON.newBSON();

            var obj = db.find_one("Duyurular",filter,option);

            filter.destroy();
            option.destroy();

            titleid.text = obj.getElement("Başlık").String;
            if( titleid.text.length > 150 )
            {
                titleid.text = titleid.text.substring(0,150);
                titleid.text += "...";
            }

            var html = obj.getElement("İçerik").String;
            html = Utility.repairHTML(html,parent.width);

            contenttext.text = html;
        }
    }

    PropertyAnimation{
        id: duyuruMainRectidCloseup
        target: duyuruMainRectid
        property: "x"
        from: 0
        to: parent.width
        duration: 250
        onStopped: {
            duyuruitemid.destroy();
        }
    }

}
