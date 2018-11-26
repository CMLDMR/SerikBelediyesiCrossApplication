import QtQuick 2.11
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3


Item {


    anchors.fill: parent
    id: responsiveitemid

    Rectangle
    {
        id: responsivemenurect
        width: parent.width/2 > 200 ? 200 : parent.width/2
        height: 200
        x: 0
        y: -height
        color: "RoyalBlue"
        ScrollView{
            anchors.fill: parent

            Column{
                anchors.fill: parent
                property int w: responsivemenurect.width

                Rectangle{
                    width: parent.w;
                    height: 50
                    color: "transparent"
                    Text{
                        anchors.centerIn: parent
                        text: "Menü"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            print ("Standart Menü");
                        }
                    }
                }

//                Rectangle{
//                    width: parent.w;
//                    height: 50
//                    color: "orange"
//                    Text{
//                        anchors.centerIn: parent
//                        text: "Serik"
//                        color: "white"
//                        font.bold: true
//                        font.pointSize: 10
//                    }
//                    MouseArea{
//                        anchors.fill: parent
//                        onClicked: {
//                            print ("Serik Button");
//                            headerid.closeMenu();
//                        }
//                    }
//                }

                Rectangle{
                    width: parent.w;
                    height: 50
                    color: "transparent"
                    id: cekgonderbuttonid
                    Text{
                        anchors.centerIn: parent
                        text: "Çek Gönder"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                        id: cekgondertextid
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            headerid.closeMenu();
                            loadCekGonder();
                        }
                    }
                }

                Rectangle{
                    width: parent.w;
                    height: 50
                    color: "#aa4682b4"
                    id: girisBtn
                    visible: !Personel.logined & !User.logined
                    Text{
                        anchors.centerIn: parent
                        text: "Giriş"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var component = Qt.createComponent("qrc:/Personel/Giris.qml");

                            if( component.status === Component.Ready )
                            {
                                var girisitem = component.createObject( mainRectid );
                                if( girisitem === null )
                                {
                                    Utility.information = "Giriş Paneli Oluşturulamadı";
                                }else{
                                    headerid.closeMenu();
                                }
                            }else{
                                Utility.information = "Giriş Paneli Oluşturalamadı";
                            }
                        }
                    }
                }



                Rectangle{
                    id: personelMenu
                    width: parent.w;
                    height: 50
                    color: "DarkSlateBlue"
                    visible: Personel.logined;
                    Text{
                        anchors.centerIn: parent
                        text: "Personel Menü"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            headerid.closeMenu();
                            loadPersonelMenu();
                        }
                    }
                }

                Rectangle{
                    id: userMenu
                    width: parent.w;
                    height: 50
                    color: "DarkSlateBlue"
                    visible: User.logined;
                    Text{
                        anchors.centerIn: parent
                        text: "Kullanıcı Menü"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            headerid.closeMenu();
                            loadKullaniciMenu();
                        }
                    }
                }

                Rectangle{
                    id: vatandasMenu
                    width: parent.w;
                    height: 50
                    color: "DeepPink"
                    visible: false;
                    Text{
                        anchors.centerIn: parent
                        text: "Personel Menü"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            headerid.closeMenu();
                            loadPersonelMenu();
                        }
                    }
                }



                Rectangle{
                    id: cikis
                    width: parent.w;
                    height: 50
                    color: "crimson"
                    visible: Personel.logined
                    Text{
                        anchors.centerIn: parent
                        text: "Çıkış"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            Personel.logout();
                            headerid.closeMenu();
                        }
                    }
                }

                Rectangle{
                    id: usercikis
                    width: parent.w;
                    height: 50
                    color: "crimson"
                    visible: User.logined
                    Text{
                        anchors.centerIn: parent
                        text: "Çıkış"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    radius: 5
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            User.logout();
                            headerid.closeMenu();
                        }
                    }
                }

            }


        }

    }


    DropShadow {
        anchors.fill: responsivemenurect
        horizontalOffset: 0
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: responsivemenurect
        z: 2
    }


    PropertyAnimation{
        id: responsivemenurectopen
        target: responsivemenurect
        property: "y"
        to: 150
        duration: 250
    }

    PropertyAnimation{
        id: responsivemenurectclose
        target: responsivemenurect
        property: "y"
        to: -350
        duration: 250
    }


    function openup(){
        responsivemenurectopen.running = true;
    }

    function closeup(){
        responsivemenurectclose.running = true;
    }



    function loadCekGonder(){
        var component = Qt.createComponent("qrc:/Main/CekGonder.qml");
        if( component.status === Component.Ready )
        {
            var sprite = component.createObject( mainRectid );
            if ( sprite === null ) {
                Utility.information = "Çek Gönder Uygulaması Açılamadı";
            }
        }else{
            Utility.information = "Çek Gönder Uygulaması Açılamadı";
        }
    }


    function loadPersonelMenu(){

        var com = Qt.createComponent("qrc:/Personel/PersonelMenu.qml");

        if( com.status === Component.Ready )
        {

            var e = com.createObject(root);

            if( e === null )
            {
                print ("load Error: Personel Menu");
            }

        }


    }


    function loadKullaniciMenu(){

        var com = Qt.createComponent("qrc:/User/UserMenu.qml");

        if( com.status === Component.Ready )
        {
            var e = com.createObject(root);

            if( e === null )
            {
                Utility.information = "Bir Hata Oluştu. Kullanıcı Menü Oluşturulamıyor";
            }
        }else{
            Utility.information = "Bir Hata Oluştu. Kullanıcı Menü Oluşturulamıyor";
        }
    }

}
