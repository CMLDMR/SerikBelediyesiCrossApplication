import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
//import Utility 0.7


import com.mongodb 0.7

Item {

    id: girisPage
    anchors.fill: parent

    Rectangle{
        id: toprect
        width: parent.width
        height: parent.height
        color: "#D0000000"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //                girisPage.destroy();
            }
        }

        Rectangle{
            id: loginscreenRectid
            width: parent.width > 950 ? 950 : parent.width
            height: parent.height
            anchors.top: parent.top
            anchors.centerIn: parent
            anchors.topMargin: parent.height/3-50
            color: "transparent"

            Rectangle{

                width: parent.width > 400 ? 400 : parent.width
                height: 150
                anchors.top: parent.top
                anchors.topMargin: parent.height/3-50
                anchors.centerIn: parent
                color: "transparent"

                Column{
                    anchors.fill: parent
                    Rectangle{
                        width: parent.width
                        height: 50
                        TextInput{
                            id: telefoninput
                            anchors.fill: parent
                            text: "05326778051"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter

                            Text {
                                id: telefonnumarasiText
                                color: "#bdbdbd"
                                text: qsTr("Telefon Numaranızı Giriniz")
                                font.family: "Tahoma"
                                font.bold: true
                                font.underline: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 10
                                visible: !parent.text
                                anchors.centerIn: parent
                            }
                            font.family: "Tahoma"
                            font.bold: true
                            font.pointSize: 10
                        }
                    }

                    Rectangle{
                        border.color: "black"
                        border.width: 1
                        width: parent.width
                        height: 2
                    }

                    //                    Rectangle{
                    //                        id: sifreToprect
                    //                        width: 0
                    //                        height: 50
                    //                        clip: true
                    //                        TextInput{
                    //                            id: sifreinput
                    //                            anchors.fill: parent
                    //                            text: ""
                    //                            verticalAlignment: Text.AlignVCenter
                    //                            horizontalAlignment: Text.AlignHCenter
                    //                            echoMode: TextInput.PasswordEchoOnEdit
                    //                            Text {
                    //                                id: sifre
                    //                                color: "#bdbdbd"
                    //                                text: qsTr("Personel Şifrenizi Giriniz")
                    //                                font.family: "Tahoma"
                    //                                font.bold: true
                    //                                font.underline: true
                    //                                verticalAlignment: Text.AlignVCenter
                    //                                horizontalAlignment: Text.AlignHCenter
                    //                                font.pointSize: 10
                    //                                visible: !parent.text
                    //                                anchors.centerIn: parent
                    //                            }
                    //                            font.family: "Tahoma"
                    //                            font.bold: true
                    //                            font.pointSize: 10
                    //                        }
                    //                    }


                    //                    PropertyAnimation{
                    //                        id: sifreopen
                    //                        target: sifreToprect
                    //                        property: "width"
                    //                        to: parent.width
                    //                        duration: 250
                    //                    }

                    Rectangle{
                        width: parent.width
                        height: 100

                        property int giristipi: 0

                        SwipeView{
                            id: loginstates
                            anchors.fill: parent
                            interactive: false
                            currentIndex: 0
                            clip: true



                            /// INDEX: 0 PERSONEL&VATANDAS
                            Item {

                                id: girisButtonSayfasi

                                Rectangle{

                                    color: "steelblue"
                                    width: parent.width
                                    height: 100

                                    Text {
                                        color: "white"
                                        text: qsTr("Giriş")
                                        font.family: "Tahoma"
                                        font.bold: true
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pointSize: 10
                                        anchors.centerIn: parent
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {





                                            if( loginstates.currentIndex === 0 )
                                            {
                                                var filter = QBSON.newBSON();
                                                filter.addString( "telefon" , telefoninput.text );
                                                var filterv = QBSON.newBSON();
                                                filterv.addString( "Cep Telefonu" , telefoninput.text );
                                                var PersonelCount = db.count("Personel",filter);
                                                var VatandasCount = db.count("TC",filterv);
                                                if( PersonelCount !== 0 && VatandasCount !== 0 )
                                                {
                                                    loginstates.currentIndex = 1;
                                                }else{
                                                    if( PersonelCount !== 0 )
                                                    {
                                                        loginstates.currentIndex = 2;
                                                    }else{
                                                        if( VatandasCount !== 0 )
                                                        {
                                                            loginstates.currentIndex = 3;
                                                        }else{
                                                            loginstates.currentIndex = 4;
                                                        }
                                                    }
                                                }
                                            }else{

                                            }
                                        }
                                    }
                                }
                            }

                            /// INDEX: 1 PERSONEL&VATANDAS
                            Item {
                                id: personelVatandas
                                Rectangle{
                                    color: "white"
                                    width: parent.width
                                    height: 100
                                    Row
                                    {
                                        spacing: 5
                                        anchors.fill: parent
                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            color: "DeepPink"
                                            Text {
                                                text: qsTr("  Vatandaş Olarak Devam Et  ");
                                                font.bold: true
                                                color: "white"
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                font.letterSpacing: 1
                                                width: parent.width
                                                wrapMode: Text.WordWrap
                                                anchors.centerIn: parent
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    loginstates.currentIndex = 3
                                                }
                                            }
                                        }

                                        Rectangle{
                                            width: parent.width/2
                                            height: parent.height
                                            color: "DarkSlateBlue"
                                            Text {
                                                text: qsTr("  Personel Olarak Devam Et  ");
                                                font.bold: true
                                                color: "white"
                                                font.pointSize: 10
                                                width: parent.width
                                                wrapMode: Text.WordWrap
                                                anchors.centerIn: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                font.family: "Tahoma"
                                                font.letterSpacing: 1
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    loginstates.currentIndex = 2
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            /// INDEX: 2 PERSONEL
                            Item {
                                id: personel
                                Rectangle{
                                    color: "white"
                                    width: parent.width
                                    height: 100
                                    Column{
                                        anchors.fill: parent
                                        TextInput{
                                            id: passwordinput
                                            width: parent.width
                                            height: parent.height/2
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "black"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            echoMode: TextInput.PasswordEchoOnEdit
                                            text: "64091"
                                            Text {
                                                text: qsTr("Şifrenizi Giriniz")
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "gray"
                                                anchors.centerIn: parent
                                                visible: !parent.text
                                            }
                                        }
                                        Rectangle {
                                            width: parent.width
                                            height: parent.height/2
                                            color: "black"
                                            Text {
                                                text: qsTr("Giriş")
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    if( Personel.login( telefoninput.text , passwordinput.text ) ){
                                                        girisPage.destroy();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            /// INDEX: 3 VATANDAS
                            Item {
                                id: vatandas
                                Rectangle{
                                    color: "LightSteelBlue"
                                    width: parent.width
                                    height: 100
                                    Column{
                                        anchors.fill: parent
                                        TextInput{
                                            id: vatpasswordinput
                                            width: parent.width
                                            height: parent.height/2
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                            color: "black"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            echoMode: TextInput.PasswordEchoOnEdit
                                            text: "8564091"
                                            Text {
                                                text: qsTr("Şifrenizi Giriniz")
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "gray"
                                                anchors.centerIn: parent
                                                visible: !parent.text
                                            }
                                        }
                                        Rectangle {
                                            width: parent.width
                                            height: parent.height/2
                                            color: "black"
                                            Text {
                                                text: qsTr("Giriş")
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    if( User.login( telefoninput.text , vatpasswordinput.text ) ){
                                                        girisPage.destroy();
                                                    }else{
                                                        Utility.information = "Yanlış Telefon Numarası yada Şifre Girdiniz"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            /// INDEX: 4 ERROR
                            Item {
                                id: hatalinumara
                                Rectangle{
                                    color: "white"
                                    width: parent.width
                                    height: 100
                                    Column{
                                        anchors.fill: parent
                                        Text {
                                            text: qsTr("Hatalı Giriş Yaptınız");
                                            height: 50
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            color: "black"
                                            font.pointSize: 10
                                            font.bold: true
                                            width: parent.width
                                            wrapMode: Text.WordWrap
                                        }
                                        Rectangle{
                                            width: parent.width
                                            height: 50
                                            color: "black"
                                            Text{
                                                anchors.centerIn: parent
                                                font.bold: true
                                                font.family: "Tahoma"
                                                font.pointSize: 10
                                                text: "Geri Dön"
                                                color: "white"
                                            }
                                        }
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            loginstates.currentIndex = 0;
                                        }
                                    }
                                }
                            }


                        }




                    }

                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        Rectangle{
                            color: "#88888888"
                            anchors.centerIn: parent
                            width: parent.width/3*2
                            height: parent.height
                            Text {
                                color: "white"
                                text: qsTr("Kapat")
                                font.family: "Tahoma"
                                font.bold: false
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 10
                                anchors.centerIn: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    print( "Login Screen Login Clicked" );
                                    closeanimation.start();
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    PropertyAnimation{
        id: closeanimation
        target: toprect
        property: "width"
        to: 0
        duration: 250
        onStopped: {
            girisPage.destroy();
        }
    }


}
