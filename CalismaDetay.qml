import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7
import Utility 0.7


Item {

    anchors.fill: parent
    id: calismaDetayitem


    property string oid: ""



    Rectangle{
        id: toprect
        anchors.fill: parent
        color: "#80000000"

        onWidthChanged: {
            listcolounm.anchors.topMargin = toprect.width > 1024 ? 30 : 15;
        }
        Rectangle{

            id: calismadetayRect
            width: 0
            height: parent.height
            color: "red"
            anchors.centerIn: parent

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    closeCalismaDetay.start();
                }
            }


            // Calisma Header

            Rectangle{
                id: calismaheaderid
                width: parent.width
                height: 200
                color: "orange"
                anchors.top: parent.top
                property var calismaObj;

                Image {
                    id: img
                    fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                }

                Rectangle{
                    anchors.fill: parent
                    color: "#80000000"




                    Column{
                        id: listcolounm
                        anchors.fill: parent
                        anchors.topMargin: parent.width > 1024 ? 30 : 15
                        spacing: 3
                        onWidthChanged: {
                            parent.height = height
                        }

                        Text {
                            id: baslamatext
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            id: songuncellemeid
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            text: calismaheaderid.calismaObj.getElement("Başlik").String;
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            text: "Birim: " + calismaheaderid.calismaObj.getElement("Birim").String;
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            text: "Durum: " + calismaheaderid.calismaObj.getElement("Durum").String;
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            text: "Kategori: " + calismaheaderid.calismaObj.getElement("Kategori").String;
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            text: calismaheaderid.calismaObj.getElement("Tanım").String;
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            font.bold: true
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                    }
                }



            }

            Rectangle{
                id: calismacontent
                anchors.top: calismaheaderid.bottom
                width: parent.width
                height: parent.height - calismaheaderid.height
                color: "steelblue"
                ScrollView{
                    anchors.fill: parent
                    clip: true

                    Column{
                        anchors.fill: parent
                        spacing: 10

                        Repeater{
                            id: asamalistid
                            property var list
                            Rectangle{
                                id: itemrect
                                color: "#FF000000"
                                width: calismacontent.width
                                height: 100
                                property var asama: asamalistid.list.getElement(index).Bson
                                Text {
                                    id: name
                                    text: asama.getElement("Açıklama").String
                                    font.family: "Tahoma"
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 10
                                    color: "white"
                                    anchors.top: parent.top
                                    width: parent.width
                                    horizontalAlignment: Text.AlignHCenter
                                    wrapMode: Text.WordWrap
                                }

                                Rectangle{
                                    id: resimlisttoprect
                                    anchors.top: name.bottom
                                    width: parent.width
                                    height: parent.height
                                    color: "transparent"
                                    property int itemcount: 0
                                    clip: true
                                    Rectangle{
                                        id: flowtoprect
                                        width: parent.width
                                        height: parent.height
                                        Flow{
                                            id: itemlistflowlayout
                                            anchors.fill: parent
                                            spacing: 0
                                            Repeater{
                                                id: resimlist
                                                property var itemlist
                                                property int itemwidth: 100
                                                Rectangle{
                                                    id: imgrectid
                                                    width: resimlist.itemwidth
                                                    height: 100
                                                    color: "transparent"
                                                    property string itemoid: resimlist.itemlist.getElement(index).Oid
                                                    Image {
                                                        id: itemimg
                                                        anchors.fill: parent
                                                        fillMode: Image.PreserveAspectCrop
                                                        source: db.fileurl(parent.itemoid);
                                                        anchors.margins: 5
                                                    }
                                                }

                                                Component.onCompleted: {
                //                                    print( "asama+ " + itemrect.asama.getElement("Görseller").Array.count);
                                                    resimlist.model = itemrect.asama.getElement("Görseller").Array.count;
                                                    resimlist.itemlist = itemrect.asama.getElement("Görseller").Array;
                                                    resimlisttoprect.itemcount = itemrect.asama.getElement("Görseller").Array.count;

                                                    var itemswidth = resimlisttoprect.itemcount*105+5;

                                                    if( itemswidth > resimlisttoprect.width )
                                                    {

                                                        var _itemcount = itemswidth / resimlisttoprect.width ;

                                                        _itemcount = Math.ceil(_itemcount);

                                                        var perlineitemnewwidth =  resimlisttoprect.width / (Math.ceil(resimlisttoprect.width / resimlist.itemwidth)-1)

                                                        resimlist.itemwidth = perlineitemnewwidth;

                                                        print( "item width " + resimlist.itemwidth );

                                                        print( "Line Count " + _itemcount );
                                                        print( "per Line widt " + itemswidth );
                                                        itemrect.height = _itemcount * 100 + name.height + 5;
                                                        print( "items Height: " + itemrect.height );
                                                    }else{

                                                        perlineitemnewwidth =  resimlisttoprect.width / (Math.ceil(resimlisttoprect.width / resimlist.itemwidth)-1)
                                                        resimlist.itemwidth = perlineitemnewwidth;
                                                        itemrect.height += name.height + 15;
                                                        print( "Line widt " + itemswidth );
                                                        print( "Line item widt " + perlineitemnewwidth );
                                                        print( "else items Height: " + itemrect.height  + " - " + name.height + " - " + 15);
                                                    }

                                                }
                                            }
                                        }


                                    }
                                }



                            }
                        }
                    }
                }
            }








        }


    }


    Component.onCompleted: {
        openCalismaDetay.start();
        print( "COmponent Completed Oid: " + oid );
    }





    PropertyAnimation{
        id: openCalismaDetay
        target: calismadetayRect
        property: "width"
        to: parent.width > 950 ? 950 : parent.width
        duration: 250
        onStopped: {
            loadCalisma();
        }
    }


    PropertyAnimation{
        id: closeCalismaDetay
        target: calismadetayRect
        property: "width"
        to: 0
        duration: 250
        onStopped: {
            calismaDetayitem.destroy();
        }
    }


    function loadCalisma(){

        var filter = QBSON.newBSON();

        filter.addOid("_id",oid);

        var option = QBSON.newBSON();



        var obj = db.find_one("Çalışmalar",filter,option);

        calismaheaderid.calismaObj = obj;

        img.source = db.fileurl( calismaheaderid.calismaObj.getElement("Küçük Resim").Oid );
        baslamatext.text = "Başlama Tarihi: "+utility.julianDaytoString(calismaheaderid.calismaObj.getElement("Başlama Tarihi").Int64);
        songuncellemeid.text = "Son Güncelleme: "+utility.julianDaytoString(calismaheaderid.calismaObj.getElement("updateDate").Int64);


        asamalistid.list = obj.getElement("Aşama").Array;

        asamalistid.model = obj.getElement("Aşama").Array.count;



    }
}
