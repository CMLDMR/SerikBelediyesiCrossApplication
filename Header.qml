import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {

    property int imgWidthHeight: 75
    // Header
    Rectangle{
        id: headerRect
        color: "transparent"
        width: root.width
        height: 75
        z: 2

        Image {
            id: logoheadermenu
            source: "qrc:/Header/Header/logo.jpg"
            width: headerRect.height
            height: headerRect.height
            fillMode: Image.PreserveAspectCrop
            anchors.left: parent.left
            anchors.leftMargin: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if( menuresposiveiconid.rotation == 0 )
                    {
                        openMenu();
                    }else{
                        closeMenu();

                    }
                }
                onPressed: {
                    print( "Pressed");
                    logoshadow.color = "white";

                }

                onReleased: {
                    print( "Released");
                    logoshadow.color = "#80000000";
                }
            }
            z: 10
        }

        DropShadow {
            id: logoshadow
            anchors.fill: logoheadermenu
            horizontalOffset: 0
            verticalOffset: 2
            radius: 16.0
            samples: 32
            color: "#80000000"
            source: logoheadermenu
            z: 10
        }



        Rectangle{
            width: parent.width - logoheadermenu.width
            x: logoheadermenu.width
            //            x: 0
            height: 20
            color: "black"
            y: 0
            Text {
                id: applicationtitleTr
                height: parent.height
                width: parent.width/2
                text: qsTr("Türkçe")
                x: 0
                y: parent.height/2-applicationtitleTr.height/2
                font.pointSize: 10
                font.family: "Tahoma"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            Text {
                id: applicationtitleEn
                height: parent.height
                width: parent.width/2
                text: qsTr("English")
                x: applicationtitleTr.width
                y: parent.height/2-applicationtitleEn.height/2
                font.pointSize: 10
                font.family: "Tahoma"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
        }

        Rectangle{
            id: headerLineWidth
            width: parent.width
            x: logoheadermenu.width
            //            x: 0
            height: 1
            color: "white"
            y: 20
        }



        Rectangle{
            id: subgrayid
            width: parent.width-logoheadermenu.width
            x: logoheadermenu.width
            height: parent.height-40
            anchors.top: headerLineWidth.bottom
            anchors.left: logoheadermenu.right
            color: "DimGray"


            Rectangle{
                id: menuresponsiverowid
                color: "transparent"
                height: parent.height
                width: 60
                anchors.right: parent.right

                Image {
                    id: menuresposiveiconid
                    property bool rotated: false
                    source: "qrc:/img/img/menu-512.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    smooth: true
                    clip: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if( menuresposiveiconid.rotation == 0 )
                            {
                                openMenu();
                            }else{
                                closeMenu();
                            }
                        }
                    }
                }




                PropertyAnimation{
                    id: responsivemenurotate
                    target: menuresposiveiconid
                    property: "rotation"
                    from: 0
                    to: -90
                    duration: 250
                }
                PropertyAnimation{
                    id: responsivemenurotateback
                    target: menuresposiveiconid
                    property: "rotation"
                    from: -90
                    to: 0
                    duration: 250
                }
            }








            Rectangle{
                id: menurowid
                anchors.centerIn: parent
                color: "transparent"
                width: 1024
                height: parent.height
                Row{
                    anchors.fill: parent
                    spacing: 5
                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: meclismenuitemid
                            text: qsTr("Meclis")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                // Load Meclis Kararları

                                var com = Qt.createComponent("qrc:/Meclis/MeclisKararlari.qml");

                                if( com.status === Component.Ready )
                                {
                                    var e = com.createObject(mainRectid);
                                    if( e === null )
                                    {
                                        Utility.information = "Meclis Paneli Oluşturulamadı";
                                    }
                                }else{
                                    Utility.information = "Meclis Paneli Oluşturulamadı";
                                }

                            }
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: projecalismamenuitemid
                            text: qsTr("Proje & Çalışma")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                var com = Qt.createComponent("qrc:/ProjeCalisma/ProjeCalisma.qml");

                                if( com.status === Component.Ready )
                                {

                                    var e = com.createObject(mainRectid);

                                    if( e === null )
                                    {
                                        Utility.information = "Proje&Çalışma Paneli Oluşturulamadı";
                                    }else{

                                    }
                                }else{
                                    Utility.information = com.errorString + "\nProje&Çalışma Paneli Oluşturulamadı";
                                }
                            }
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: haberlermenuitemid
                            text: qsTr("Haberler")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                var com = Qt.createComponent("qrc:/Haberler/Haberlist.qml");

                                if( com.status === Component.Ready )
                                {

                                    var e = com.createObject(mainRectid);

                                    if( e === null )
                                    {
                                        Utility.information = "Haberler Paneli Oluşturulamadı";
                                    }else{

                                    }
                                }else{
                                    Utility.information = com.errorString + "\nHaberler Paneli Oluşturulamadı";
                                }
                            }
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: etkinliklermenuid
                            text: qsTr("Etkinlikler")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: gerimenuitemid
                            text: qsTr("Galeri")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: bilgiedinmemenuitem
                            text: qsTr("Bilgi Edinme")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Text {
                            id: iletisimmenuitemid
                            text: qsTr("İletişim")
                            color: "white"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        Rectangle{
                            color: "orange"
//                            anchors.centerIn: parent
                            anchors.fill: parent
                            Text {
                                id: serikmenuitem
                                text: qsTr("Serik")
                                color: "white"
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 10
                                font.family: "Tahoma"
                                anchors.centerIn: parent
                                width: parent.width
                                wrapMode: Text.WordWrap
                            }
//                            width: serikmenuitem.width
//                            height: serikmenuitem.height
                            radius: 3
                        }
                    }

                    Rectangle{
                        color: "transparent"
                        height: parent.height
                        width: 100
                        visible: !(User.logined || Personel.logined)
                        Rectangle{
                            color: "DeepSkyBlue "
                            anchors.fill: parent
                            Text {
                                id: girismenuitem
                                text: qsTr("Giriş")
                                color: "white"
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 10
                                font.family: "Tahoma"
                                anchors.centerIn: parent
                                width: parent.width
                                wrapMode: Text.WordWrap
                            }
                            radius: 3
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {

                                    print ( "User Logined: " + User.logined );

                                    print ( "Personel Logined: " + Personel.logined );

                                    print ("Visibility : " + !(User.logined || Personel.logined) );


                                    var component = Qt.createComponent("qrc:/Personel/Giris.qml");
                                    if( component.status === Component.Ready )
                                    {
                                        var girisitem = component.createObject( mainRectid );
                                        if( girisitem === null )
                                        {
                                            Utility.information = "Giriş Paneli Oluşturulamadı";
                                        }else{
                                            closeMenu();
                                        }
                                    }else{
                                        Utility.information = "Giriş Paneli Oluşturulamadı";
                                    }
                                }
                            }
                        }
                    }
                }
            }




        }


        ResponsiveMenu{
            id: responsivemenu
            width: parent.width/2
            height: 350
            anchors.centerIn: parent
//            onTriggered: {
//                if( menuresposiveiconid.rotation == 0 )
//                {
//                    responsivemenu.openup();
//                    responsivemenurotate.running = true;
//                }else{
//                    responsivemenu.closeup();
//                    responsivemenurotateback.running = true;
//                }
//            }
        }

        // Meclis ve Diğer Menüler Aktifleştirilince menurowid Gösterilecek
        onWidthChanged: {
            if( headerRect.width > 1024 )
            {
                menurowid.visible = true
                menuresponsiverowid.visible = false
                logoheadermenu.width = 150
                logoheadermenu.height = 150
                subgrayid.height = 60;
                responsivemenu.closeup();
            }else{
                menurowid.visible = false
                menuresponsiverowid.visible = true
                logoheadermenu.width = 75
                logoheadermenu.height = 75
                subgrayid.height = 40;
            }

//            menurowid.visible = false
        }

        DropShadow {
            anchors.fill: subgrayid
            horizontalOffset: 0
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: subgrayid
            z: 2
        }


    }



    function openMenu(){

        responsivemenu.openup();
        responsivemenurotate.running = true;

    }

    function closeMenu() {
        responsivemenu.closeup();
        responsivemenurotateback.running = true;
    }
}



