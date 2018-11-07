import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtPositioning 5.8
import QtLocation 5.9

import com.mongodb 0.7
//import Utility 0.7

Item {

    id: cekgonderitemid

    anchors.fill: parent
    property int w: width > 1024 ? 1024 : width
    property int h: height



    property int imgCount: 0


    Rectangle{
        color: "#b3050505"
        anchors.fill: parent
        anchors.topMargin: 0
        onWidthChanged: {
            if( width > 1024 )
            {
                anchors.topMargin = 20;
            }else{
                anchors.topMargin = 0;
            }
        }

        Rectangle{
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "gray"
            anchors.centerIn: parent


            ScrollView{
                anchors.fill: parent
                clip: true

                Column {
                    anchors.fill: parent

                    Rectangle {
                        width: w
                        height: 150
                        border.width: 2
                        border.color: "red"
                        Text {
                            id: sikayetiniziGirinizid
                            text: qsTr("Şikayetinizi Giriniz!");
                            font.family: "Tahoma"
                            font.bold: true
                            font.pointSize: 12
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            color: "#4d4d4d"
                            anchors.centerIn: parent
                        }
                        Rectangle {
                            border.color: "gray"
                            border.width: 1
                            width: w
                            anchors.top:  sikayetiniziGirinizid.bottom
                            anchors.bottom: parent.bottom

                            TextInput {
                                id: sikayetinputid
                                font.pointSize: 11
                                anchors.fill: parent
                                anchors.leftMargin: 10
                                anchors.rightMargin: 10
                            }
                        }
                    }

                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        Label {
                            id: tcnolabelid
                            text: "TCNO"
                            width: w/2
                        }
                        Rectangle {
                            anchors.left: tcnolabelid.right
                            width: w/2
                            border.width: 1
                            border.color: "gray"
                            height: 35
                            TextInput {
                                id: tcnoinputid
                                font.pointSize: 10
                                horizontalAlignment: Text.AlignHCenter
                                anchors.fill: parent
                                onTextChanged: {

                                    print( "TCNO Changed" );

                                    if( tcnoinputid.text.length == 11 )
                                    {
                                        var filter = QBSON.newBSON();

                                        filter.addString("TCNO",tcnoinputid.text );

                                        var option = QBSON.newBSON();

                                        var e = db.find_one("TC",filter,option);

                                        adsoyadinputid.text = e.getElement("İsimSoyisim").String;
                                        telefonnumarasiid.text = e.getElement("Cep Telefonu").String;
                                    }else{
                                        adsoyadinputid.text = "";
                                        telefonnumarasiid.text = "";
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        Label {
                            id: tellabellabelid
                            text: "Telefon Numarası"
                            width: w/2
                        }
                        Rectangle {
                            anchors.left: tellabellabelid.right
                            width: w/2
                            border.width: 1
                            border.color: "gray"
                            height: 35
                            TextInput {
                                id: telefonnumarasiid
                                font.pointSize: 10
                                horizontalAlignment: Text.AlignHCenter
                                anchors.fill: parent
                                onTextChanged: {

                                    print( "Tel Number Text Changed" );

                                    if( telefonnumarasiid.text.length == 11 )
                                    {
                                        var filter = QBSON.newBSON();

                                        filter.addString("Cep Telefonu",telefonnumarasiid.text );

                                        var option = QBSON.newBSON();

                                        var e = db.find_one("TC",filter,option);

                                        adsoyadinputid.text = e.getElement("İsimSoyisim").String;
                                        tcnoinputid.text = e.getElement("TCNO").String;
                                    }else{
                                        adsoyadinputid.text = "";
                                        tcnoinputid.text = "";
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        Label {
                            id: adinizlabelid
                            text: "Adınız & Soyadınız"
                            width: w/2
                        }
                        Rectangle {
                            anchors.left: adinizlabelid.right
                            width: w/2
                            border.width: 1
                            border.color: "gray"
                            height: 35
                            TextInput {
                                id: adsoyadinputid
                                font.pointSize: 10
                                horizontalAlignment: Text.AlignHCenter
                                anchors.fill: parent
                            }
                        }
                    }



                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        Label {
                            id: adreslabelid
                            text: "Adres"
                            width: w/2
                        }
                        Rectangle {
                            anchors.left: adreslabelid.right
                            width: w/2
                            border.width: 1
                            border.color: "gray"
                            height: 35
                            TextInput {
                                id: adresinputid
                                font.pointSize: 10
                                horizontalAlignment: Text.AlignHCenter
                                anchors.fill: parent
                            }
                        }
                    }

                    Rectangle {
                        id: videooutputrectid
                        width: w
                        height: 450
                        VideoOutput {
                            id: videooutputid
                            source: camera
                            fillMode: VideoOutput.PreserveAspectFit
                            anchors.fill: parent
                            focus : visible
                            anchors.top: parent.top
                            autoOrientation: true
                            Rectangle{
                                id: recid
                                color: "transparent";
                                border.width: 1
                                border.color: "white";
                                radius: w/4
                                anchors.centerIn: parent
                                width: w/2
                                height: w/2
                                Image {
                                    id: camerachechimg
                                    source: ""
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        recid.color= "#88FFFFFF";
                                        camerachechimg.source = "qrc:/img/img/3D Logo.png"
                                    }
                                    onReleased: {
                                        recid.color= "transparent";
                                        camerachechimg.source = "";
                                        camera.imageCapture.capture();
                                    }
                                }

                                Component.onCompleted: {
                                    var list = camera.supportedViewfinderResolutions();
                                    var maxwidth = 0 ;
                                    var maxheight = 0 ;
                                    for( var x in list )
                                    {
                                        if( maxheight < list[x].height )
                                        {
                                            maxheight = list[x].height;
                                        }

                                        if( maxwidth < list[x].width )
                                        {
                                            maxwidth = list[x].width;
                                        }
                                    }
                                }
                            }
                        }
                    }




                    Rectangle{
                        width: w
                        height: 50
                        border.color: "gray"
                        border.width: 1
                        ScrollView{
                            anchors.fill: parent
                            Row{
                                id: photoarrayRowid
                                spacing: 2
                            }
                        }
                    }





                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        PositionSource {
                            id: src
                            updateInterval: 1000
                            active: true

                            onPositionChanged: {
                                var coord = src.position.coordinate;

                                if( !coord.longitude || !coord.latitude ){
                                    messageDialog.text = "Lütfen Telefonunuzun Konum'u Açınız!";
                                    messageDialog.visible = true
                                    geocoor.text = "Cihazınızın Konum Bilgisini Açınız!"
                                    geocoor.color = "red";
                                    return;
                                }

                                cekgonderMap.longtidue = coord.longitude;
                                cekgonderMap.altitude = coord.latitude;




                                cekgonderMap.center = QtPositioning.coordinate(coord.latitude , coord.longitude );

    //                            console.log("Coordinate:", coord.longitude, coord.latitude);
                                geocoor.text = coord.longitude + " - " + coord.latitude;
                                geocoor.color = "black";
                            }
                        }

                        Text {
                            id: geocoor
                            text: qsTr("Koordinat Bilgileri")
                        }
                    }

                    Rectangle {
                        width: w
                        height: 35
                        anchors.margins: 5
                        ComboBox {
                            id: comboboxmahalleid
                            width: w
                            Component.onCompleted: {
                                var filter = QBSON.newBSON();

                                var option = QBSON.newBSON();

                                var mahlist = db.find("Mahalleler",filter,option);

                                var alist = new Array;
                                for( var x in mahlist )
                                {
                                    var e = mahlist[x];
                                    alist[x] = e.getElement("Mahalle").String;
                                }

                                comboboxmahalleid.model = alist;

                            }
                        }


                    }

                    Rectangle {
                        width: w
                        height: 250

                        color: "red"
                        Plugin {
                            id: mapPlugin
                            name: "osm" // "mapboxgl", "esri", "osm"...
                            // specify plugin parameters if necessary
                            // PluginParameter {
                            //     name:
                            //     value:
                            // }
                        }

                        Map {
                            id: cekgonderMap;
                            property real longtidue: 0;
                            property real altitude: 0;

                            anchors.fill: parent
                            plugin: mapPlugin
                            center: QtPositioning.coordinate(36.91, 31.10) // Serik
                            zoomLevel: 18

                            Rectangle {
                                anchors.centerIn: parent
                                width: 12
                                height: 12
                                radius: width/2
                                color: "transparent";
                                border.color: "red"
                                border.width: 1
                            }

                        }
                    }


                    Rectangle {
                        width: w
                        height: 50
                        anchors.margins: 5
                        Button {
                            text: "Gönder";
                            highlighted: true
                            anchors.centerIn: parent
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {


                                    if( adsoyadinputid.length == 0 )
                                    {
                                        messageDialog.title = "Uyarı";
                                        messageDialog.text = "Ad & Soyad Bilgisi Girmediniz";
                                        messageDialog.visible = true;
                                        return;
                                    }

                                    if( telefonnumarasiid.length != 11 )
                                    {
                                        messageDialog.title = "Uyarı";
                                        messageDialog.text = "Telefon Numarası 05351234567 Formatında Olmalı";
                                        messageDialog.visible = true;
                                        return;
                                    }

                                    if( sikayetinputid.length <= 20 )
                                    {
                                        messageDialog.title = "Uyarı";
                                        messageDialog.text = "Şikayetiniz Minimum 20 Karakter Olmalı";
                                        messageDialog.visible = true;
                                        return;
                                    }

                                    if( adresinputid.length == 0 )
                                    {
                                        messageDialog.title = "Uyarı";
                                        messageDialog.text = "Adres Bilgisi Girmediniz";
                                        messageDialog.visible = true;
                                        return;
                                    }

                                    var _imgPath;

                                    var fotolist = QArray.newArray();

                                    for( var i = 0 ; i < photoarrayRowid.children.length ; i++ )
                                    {
                                        _imgPath = photoarrayRowid.children[i].imgPath;
                                        var e = db.uploadfile( _imgPath , "sikayetFoto" );
                                        fotolist.insertOid( e.Oid );
                                    }



                                    var mobilinsert = QBSON.newBSON();
                                    mobilinsert.addDouble("latitute",cekgonderMap.longtidue);
                                    mobilinsert.addDouble("longtitude",cekgonderMap.altitude);
                                    mobilinsert.addArray("fotooidlist",fotolist);

                                    var insert = QBSON.newBSON();

                                    insert.addBson( "mobilDoc" , mobilinsert );

                                    //tcnoinputid.text

                                    insert.addString( "Şikayet/Talep Sahibi" , tcnoinputid.text );
//                                    insert.addString( "Şikayet/Talep Sahibi" , telefonnumarasiid.text );
                                    insert.addString( "Konu" , sikayetinputid.text );
                                    insert.addString( "Mahalle" , comboboxmahalleid.currentText );
                                    insert.addString( "Tam Adres" , adresinputid.text );
                                    insert.addString( "Durum" , "Devam Ediyor" );
                                    insert.addString( "Tarih" , utility.currentStringDay() );
                                    insert.addString( "Saat" , utility.currentSaat() );
                                    insert.addInt64( "julianDay" , utility.currentJulianDay() );
                                    insert.addString( "julianDay" , utility.currentJulianDay() );



                                    if( !db.insert_one("Sikayet",insert) )
                                    {
                                        messageDialog.title = "Hata";
                                        messageDialog.text = "Şikayetiniz Kayıt Edilemedi";
                                        messageDialog.visible = true;
                                    }else{
                                        messageDialog.title = "Bilgi";
                                        messageDialog.text = "Talebinizi başarı ile Aldık";
                                        messageDialog.visible = true;
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: w
                        height: 50
                        anchors.margins: 5
                        Button {
                            text: "Kapat";
                            highlighted: true
                            anchors.centerIn: parent
                            onClicked: {
                                cekgonderitemid.destroy();
                            }
                        }
                    }
                }
            }
        }

    }



    MessageDialog {
        id: messageDialog
        title: "UYARI"
        text: "En Fazla 7 Resim Çekebilirsiniz!";
        onAccepted: {
            visible = false;
            cekgonderitemid.destroy();
        }
        Component.onCompleted: visible = false
    }



    Camera {
        id: camera
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        imageCapture {
            onImageCaptured: {
                print( "on Image Captured" );
                var imgPath = camera.imageCapture.capturedImagePath

                if( imgPath )
                {

                }else{
                    print("no img Captured");
                    return;
                }



                if( imgCount >= 7 && imgPath )
                {
                    messageDialog.text = "En Fazla 7 Resim Çekebilirsiniz!";
                    messageDialog.visible = true
                }else{
                    takePhoto(preview,imgPath);
                }
            }
        }
    }


    function takePhoto(imgSource,imgPath){
        var imgComponent = Qt.createComponent("CekGonderImg.qml");
        if (imgComponent.status === Component.Ready) {
            var obj = imgComponent.createObject(photoarrayRowid);
            imgCount++;
            obj.index = imgCount;
            obj.imgSource = imgSource;
            obj.imgPath = imgPath;

            obj.onDeletedimg.connect(function(_index){
                for( var i = 0 ; i < photoarrayRowid.children.length ; i++ )
                {
                    if( _index === photoarrayRowid.children[i].index )
                    {
                        imgCount--;
                        photoarrayRowid.children[i].destroy();
                    }
                }
            });
        }
    }
}
