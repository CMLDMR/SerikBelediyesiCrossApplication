import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7

Item{


    property int childWidth: mainSlider.width
    id: mainslidetitemid

    Rectangle{
        id: mainSlider
        color: "transparent"
        width: parent.width > 1024 ? 1024 : parent.width
        height: parent.height
        anchors.centerIn: parent



        ScrollView{
            anchors.fill: parent

            Column{
                anchors.fill: parent

                Rectangle{
                    id: flowLayoutRectid
                    width: mainSlider.width
                    height: obj1.height+obj2.height+obj3.height+obj4.height+obj5.height+obj6.height+obj7.height;

                    Flow{

                        id: contentFlowid
                        anchors.fill: parent



                        Rectangle{
                            color: "transparent"
                            width: parent.width
                            id: obj1
                            height: 200

                            Rectangle{
                                id: sliderSwipeViewParentid
                                anchors.fill: parent
                                anchors.leftMargin: 60
                                anchors.rightMargin: 60
                                SwipeView{
                                    id: sliderSwipeViewid
                                    anchors.fill: parent
                                    clip: true
                                    Repeater{
                                        id: repeaterid
                                        Rectangle{
                                            width: sliderSwipeViewid.width
                                            height: sliderSwipeViewid.height
                                            border.color: "black"
                                            border.width: 1



                                            Image {
                                                source: db.fileurl(modelData.getElement("sliderImg").Oid);
                                                anchors.fill: parent
                                                fillMode: Image.PreserveAspectCrop

                                                Rectangle{
                                                    id: slideritem
                                                    width: parent.width
                                                    height: parent.height/2
                                                    anchors.bottom: parent.bottom
                                                    property string oid: modelData.getElement("_id").Oid;
                                                    Text {
                                                        id: titleTestid
                                                        text: modelData.getElement("title").String;
                                                        width: parent.width
                                                        wrapMode: Text.WordWrap
                                                        anchors.bottom: parent.bottom
                                                        color: "white"
                                                        font.bold: false
                                                        verticalAlignment: Text.AlignVCenter
                                                        horizontalAlignment: Text.AlignHCenter
                                                        font.pointSize: 16
                                                        font.family: "Tahoma"
                                                        anchors.bottomMargin: 30
                                                    }
                                                    gradient: Gradient {
                                                        GradientStop {
                                                            position: 0.00;
                                                            color: "#00ffffff";
                                                        }
                                                        GradientStop {
                                                            position: 0.24;
                                                            color: "#00ffffff";
                                                        }
                                                        GradientStop {
                                                            position: 0.20;
                                                            color: "#00ffffff";
                                                        }
                                                        GradientStop {
                                                            position: 1.00;
                                                            color: "#FF000000";
                                                        }
                                                    }

                                                }

                                                // Load Slide Title Page
                                                MouseArea{
                                                    anchors.fill: parent
                                                    onClicked: {
                                                        var component = Qt.createComponent("qrc:/Haberler/SliderPage.qml");
                                                        if( component.status === Component.Ready )
                                                        {
                                                            var sprite = component.createObject( mainslidetitemid , {"oid":slideritem.oid});
                                                            if (sprite === null) {
                                                                // Error Handling
                                                                console.log("Error creating object");
                                                            }else{
                                                                console.log("Success init");
//                                                                sprite.width = mainslidetitemid.width;
//                                                                sprite.height = mainslidetitemid.height
                                                            }
                                                        }else{
                                                            print( "SlidePage.qml Component Not Ready");
                                                        }

                                                    }
                                                }



                                            }


                                        }
                                        Component.onCompleted: {
                                            var filter = QBSON.newBSON();
                                            filter.addBool("online",true);
                                            var option = QBSON.newBSON();
                                            option.addInt("limit",12);
                                            var sort = QBSON.newBSON();
                                            sort.addInt("_id",-1);
                                            option.addBson("sort",sort);
                                            repeaterid.model = db.find("Slider",filter,option);
                                        }
                                    }
                                }

                                Rectangle{
                                    id: timeelapsedslideitemid
                                    width: 0
                                    height: 3
                                    anchors.bottom: parent.bottom
                                    x: 0
                                    color: "white"
                                }


                                DropShadow {
                                    anchors.fill: baskantext
                                    horizontalOffset: 0
                                    verticalOffset: -5
                                    radius: 7.0
                                    samples: 17
                                    color: "white"
                                    source: baskantext
                                    z: 2
                                }

                            }

                            PropertyAnimation{
                                id: timeelapsedslideitemanimationid
                                target: timeelapsedslideitemid
                                property: "width"
                                from: 0
                                to: sliderSwipeViewid.width
                                onStopped: {
//                                    timeelapsedslideitemid.width = 0;
                                }
                            }




                            Timer{
                                id: sliderTimer
                                interval: 1000
                                repeat: true
                                running: true
                                onTriggered: {
                                    var randomindex = Math.random();
                                    randomindex *=100;
                                    randomindex = parseInt(randomindex%12);
                                    sliderSwipeViewid.currentIndex = randomindex;

                                    sliderTimer.interval = (randomindex%5+5)*1000;

                                    timeelapsedslideitemanimationid.duration = sliderTimer.interval
                                    timeelapsedslideitemanimationid.running = true

//                                    print( "Ramdom Slide İndex: " + randomindex +" - " + sliderTimer.interval );
                                }
                                Component.onCompleted: {
                                    sliderTimer.running = true;
                                }
                            }

                            PageIndicator {
                                id: indicator

                                count: sliderSwipeViewid.count
                                currentIndex: sliderSwipeViewid.currentIndex

                                anchors.bottom: sliderSwipeViewParentid.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Rectangle{
                            color: "transparent"
                            width: parent.width
                            id: obj2
                            height: 200
                            Image {
                                id: baskanimgld
                                anchors.topMargin: 10
                                anchors.bottomMargin: 10
                                source: "http://serik.bel.tr/tempfile/20180222161848922%7Bb614d2b8-d93a-4ee5-9d5b-072d2ff4e8e8%7D.jpg"
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                Rectangle{
                                    width: parent.width
                                    height: 50
                                    color: "#b35e8ac5"
                                    anchors.bottom: parent.bottom
                                    Text{
                                        id: baskantext
                                        anchors.centerIn: parent
                                        text : "Başkan"
                                        font.bold: true
                                        color: "white"
                                        font.pointSize: 14
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    DropShadow {
                                        anchors.fill: baskantext
                                        horizontalOffset: 0
                                        verticalOffset: 3
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000"
                                        source: baskantext
                                        z: 2
                                    }
                                }
                            }

                            // Load Slide Title Page
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    var component = Qt.createComponent("qrc:/Baskan/BaskanPage.qml");
                                    if( component.status === Component.Ready )
                                    {
                                        var sprite = component.createObject( mainslidetitemid );
                                        if (sprite === null) {
                                            // Error Handling
                                            console.log("Error creating object");
                                        }else{
                                            console.log("Success init");
                                        }
                                    }else{
                                        print( "BaskanPage.qml Component Not Ready");
                                    }

                                }
                            }

                        }





                        //Video Cover
                        Rectangle{
                            color: "transparent"
                            width: parent.width
                            id: obj4
                            height: 200
                            Image {
                                id: videoCoverid
                                anchors.fill: parent
                                anchors.topMargin: 10
                                anchors.bottomMargin: 10
                                source: ""
                                Image {
                                    id: playpngid
                                    source: "qrc:/img/img/videoWidgetPlay.png"// This is available in all editors.
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                    width: 100
                                    height: 100
                                }
                                Rectangle{
                                    width: parent.width
                                    height: 50
                                    color: "#99668fe6"
                                    anchors.bottom: parent.bottom

                                    Text{
                                        id: videoTitleid
                                        anchors.centerIn: parent
                                        font.bold: true
                                        color: "white"
                                        font.pointSize: 14
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    DropShadow {
                                        anchors.fill: videoTitleid
                                        horizontalOffset: 0
                                        verticalOffset: 3
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000"
                                        source: videoTitleid
                                        z: 2
                                    }
                                }



                                Component.onCompleted: {
                                    var filter = QBSON.newBSON();
                                    var option = QBSON.newBSON();
                                    var sort = QBSON.newBSON();
                                    sort.addInt("_id",-1);
                                    option.addBson("sort",sort);
                                    var obj = db.find_one("Videolar",filter,option);
                                    videoTitleid.text = obj.getElement("Title").String
                                    videoCoverid.source = db.fileurl(obj.getElement("VideoLabel").Oid , true )
                                    print( obj.getElement("VideoLabel").Oid + " " + videoCoverid.source );
                                }
                            }
                        }

                        //Haberler
                        Rectangle{
                            color: "white"
                            width: parent.width
                            id: obj5

                            property int itemCount: 0
                            height: obj5.itemCount*70+50

                            Column{
                                anchors.fill: parent
                                spacing: 5
                                anchors.topMargin: 50
                                Repeater{
                                    id: haberlistid
                                    Rectangle{
                                        width: obj5.width
                                        color: "gray"
                                        height: 65

                                        Rectangle{
                                            id: haberlisticonrectid
                                            color: "orange"
                                            width: 65
                                            height: 65
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                        }

                                        Text{
                                            text: modelData.getElement("Başlık").String
                                            width: parent.width-haberlisticonrectid.width
                                            wrapMode: Text.WordWrap
                                            font.pointSize: 10
                                            font.bold: false
                                            anchors.left: haberlisticonrectid.right
                                            anchors.top: parent.top
                                            color: "white"
                                            height: parent.height
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                        }
                                    }
                                }

                            }
                            //                            }

                            Component.onCompleted: {
                                var filter = QBSON.newBSON();
                                var option = QBSON.newBSON();
                                option.addInt("limit",6);
                                var projection = QBSON.newBSON();
                                projection.addBool("Başlık",true);
                                option.addBson("projection",projection);
                                var sort = QBSON.newBSON();
                                sort.addInt("_id",-1);
                                option.addBson("sort",sort);
                                haberlistid.model = db.find( "Haberler" , filter , option );

                                obj5.height = 70 * haberlistid.model.length + 50;
                                obj5.itemCount = haberlistid.model.length;
                                print( "haberlistid Count: " + haberlistid.model.length + " " + obj5.height);
                                contentFlowid.resize();
                            }

                            Rectangle{
                                width: parent.width
                                height: 30
                                color: "#998b8b8b"
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                Text {
                                    color: "#f7f7f7"
                                    text: qsTr("Haberler");
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 13
                                    font.family: "Tahoma"
                                }
                            }
                        }




                        Rectangle{
                            color: "white"
                            width: parent.width
                            id: obj6

                            property int itemCount: 0
                            height: obj6.itemCount*70+50
                            Rectangle{
                                width: parent.width
                                height: 30
                                color: "#99a644"
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                Text {
                                    color: "#f7f7f7"
                                    text: qsTr("Duyurular");
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 13
                                    font.family: "Tahoma"
                                }
                            }
                            Column{
                                anchors.fill: parent
                                spacing: 5
                                anchors.topMargin: 50
                                Repeater{
                                    id: duyurulistid
                                    Rectangle{
                                        width: obj6.width
                                        color: "RosyBrown"
                                        height: 65

                                        Text{
                                            text: modelData.getElement("Başlık").String
                                            width: parent.width
                                            wrapMode: Text.WordWrap
                                            font.pointSize: 10
                                            font.bold: false
                                            anchors.top: parent.top
                                            color: "white"
                                            height: parent.height
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            Component.onCompleted: {
                                                if( text.length > 100 )
                                                {
                                                    text = text.substring(0,100);
                                                    text += "...";
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Component.onCompleted: {
                                var filter = QBSON.newBSON();
                                filter.addString("Yayında","Yayında");
                                var option = QBSON.newBSON();
                                option.addInt("limit",2);
                                var projection = QBSON.newBSON();
                                projection.addBool("Başlık",true);
                                option.addBson("projection",projection);
                                var sort = QBSON.newBSON();
                                sort.addInt("_id",-1);
                                option.addBson("sort",sort);
                                duyurulistid.model = db.find( "Duyurular" , filter , option );

                                obj6.height = 70 * duyurulistid.model.length + 50;
                                obj6.itemCount = duyurulistid.model.length;
                                print( "DuyuruList Count: " + duyurulistid.model.length + " " + obj6.height);
                            }
                        }



                        Rectangle{
                            color: "#ffffff"
                            width: parent.width
                            id: obj7
                            property int itemCount: 0
                            height: obj7.itemCount*70+50
                            Rectangle{
                                width: parent.width
                                height: 30
                                color: "Purple"
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                Text {
                                    color: "#f7f7f7"
                                    text: qsTr("Son Çalışmalar");
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 13
                                    font.family: "Tahoma"
                                }
                            }
                            Column{
                                anchors.fill: parent
                                spacing: 5
                                anchors.topMargin: 50
                                Repeater{
                                    id: calismalistrepeaterid
                                    Rectangle{
                                        width: obj7.width
                                        color: "#2b81b7"
                                        height: 65

                                        Rectangle{
                                            id: calismaiconrectid
                                            color: "purple"
                                            width: 65
                                            height: 65
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                        }

                                        Text{
                                            text: modelData.getElement("Başlik").String
                                            width: parent.width - calismaiconrectid.width
                                            wrapMode: Text.WordWrap
                                            font.pointSize: 10
                                            font.bold: false
                                            anchors.top: parent.top
                                            anchors.left: calismaiconrectid.right
                                            color: "white"
                                            height: parent.height
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            Component.onCompleted: {
                                                if( text.length > 100 )
                                                {
                                                    text = text.substring(0,100);
                                                    text += "...";
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Component.onCompleted: {
                                var filter = QBSON.newBSON();
                                filter.addString("Yayında","Yayınlanıyor");
                                var option = QBSON.newBSON();
                                option.addInt("limit",6);
                                var projection = QBSON.newBSON();
                                projection.addBool("Başlik",true);
                                option.addBson("projection",projection);
                                var sort = QBSON.newBSON();
                                sort.addInt("_id",-1);
                                option.addBson("sort",sort);
                                calismalistrepeaterid.model = db.find( "Çalışmalar" , filter , option );

                                obj7.height = 70 * calismalistrepeaterid.model.length + 50;
                                obj7.itemCount = calismalistrepeaterid.model.length;
                                print( "Çalışmalar Count: " + calismalistrepeaterid.model.length + " " + obj7.height);
                            }
                        }


                        Rectangle{
                            id: projectContectid
                            color: "transparent"
                            width: parent.width
//                            height: 200
                            property int responsiveDivider: 2
                            property int itemHeight: 80
                            property int itemCount: 0
                            property int limit: 12

                            Rectangle{
                                width: parent.width
                                height: 30
                                color: "black"
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                Text {
                                    color: "white"
                                    text: qsTr("Projeler");
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 13
                                    font.family: "Tahoma"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        projectContectid.limit = 12;
                                        projectContectid.loadProject();
                                        contentFlowid.resize();
                                    }
                                }
                            }

                            Rectangle{
                                width: parent.width
                                height: 40
                                color: "steelblue"
                                anchors.bottom: parent.bottom
                                Text{
                                    color: "#ffffff"
                                    text: "Daha Fazla Proje Göster"
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 11
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        projectContectid.limit += 12;
                                        projectContectid.loadProject();
                                        contentFlowid.resize();
                                    }
                                }
                            }

                            Rectangle{
                                width: parent.width
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 50
                                anchors.top: parent.top
                                anchors.topMargin: 40
                                color: "transparent"

                                Flow{
                                    anchors.fill: parent

                                    Repeater{
                                        id: projectContentRepeaterid

                                        Rectangle{
                                            width: projectContectid.width/projectContectid.responsiveDivider
                                            height: projectContectid.itemHeight
                                            color: "transparent"
                                            Image {
                                                id: projecticonid
                                                source: db.fileurl(modelData.getElement("icon").Oid)
                                                anchors.fill: parent
                                            }
                                            Rectangle{
                                                anchors.fill: parent
                                                anchors.margins: 5
                                                color: "#b31a4a6f"
                                                border.color: "white"
                                                border.width: 1
                                                Text {
                                                    id: projectContentTitleid
                                                    color: "#ffffff"
                                                    text: modelData.getElement("Başlık").String
                                                    font.family: "Tahoma"
                                                    font.bold: true
                                                    font.pointSize: 11
                                                    verticalAlignment: Text.AlignVCenter
                                                    horizontalAlignment: Text.AlignHCenter
                                                    anchors.centerIn: parent
                                                    width: parent.width
                                                    wrapMode: Text.WordWrap
                                                }
                                                DropShadow {
                                                    anchors.fill: projectContentTitleid
                                                    horizontalOffset: 0
                                                    verticalOffset: 3
                                                    radius: 8.0
                                                    samples: 17
                                                    color: "#80000000"
                                                    source: projectContentTitleid
                                                    z: 2
                                                }
                                            }
                                        }
                                    }
                                }
                                Component.onCompleted: {
                                    projectContectid.loadProject();
                                }
                            }

                            function loadProject(){
                                var filter = QBSON.newBSON();

                                var option = QBSON.newBSON();

                                var projection = QBSON.newBSON();
                                projection.addBool("Başlık",true);
                                projection.addBool("icon",true);
                                option.addBson("projection",projection);

                                option.addInt("limit",projectContectid.limit);
                                projectContentRepeaterid.model = db.find("Projeler",filter,option);
                                projectContectid.itemCount = projectContentRepeaterid.model.length;
                            }

                        }


                        Rectangle{
                            id: footerinformationid
                            width: parent.width
                            height: 140
                            color: "black"
                            Column{
                                anchors.fill: parent
                                anchors.topMargin: 20
                                spacing: 10
                                Rectangle{
                                    width: parent.width
                                    height: 20
                                    color: "transparent"
                                    Text {
                                        text: qsTr("Serik Belediye Başkanlığı")
                                        font.pointSize: 10
                                        color: "white"
                                        anchors.centerIn: parent
                                    }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: 20
                                    color: "transparent"
                                    Text {
                                        text: qsTr("Bu Uygulama Serik Belediyesi Bilgi İşlem Müdürlüğü Tarafından Açık Kaynak Kodlu Olarak Geliştirilmektedir")
                                        color: "white"
                                        font.pointSize: 10
                                        anchors.centerIn: parent
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                Rectangle{
                                    width: parent.width
                                    height: 20
                                    color: "transparent"
                                    Text {
                                        text: qsTr("© Copyright 2018 <b><i><style=\"red\";>QML</i></b>, <b><i>Qt</i></b> & <b><i>gitHub</i></b>")
                                        color: "steelblue"
                                        font.pointSize: 10
                                        anchors.centerIn: parent
                                    }
                                }

                                Rectangle{
                                    width: parent.width
                                    height: 20
                                    color: "transparent"
                                    Text {
                                        text: qsTr("Kurum içi Portal")
                                        color: "steelblue"
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }

                        onWidthChanged: {
                            print( "Flow Layout Width Changed " + width );
                            resize();
                        }
                        onHeightChanged: {
                            print( "Flow Layout Height Changed " + height );
                            resize();
                        }

                        Component.onCompleted: {
                            print( "Call Resize"  +  flowLayoutRectid.height );
                            contentFlowid.resize();
                            print( "Call Resized: " +  flowLayoutRectid.height);

                        }


                        function resize(){
                            if( width >= 540 )
                            {
                                if( width >= 900 )
                                {
                                    if( width >= 900+360 )
                                    {
                                        obj1.width = width/2; obj1.height = mainSlider.height/3;
                                        obj2.width = width/4; obj2.height = mainSlider.height/3;
                                        obj3.width = width/4; obj3.height = mainSlider.height/3;
                                        obj4.width = width/6; obj4.height = mainSlider.height/3;
                                        obj5.width = width/6*3; obj5.height = mainSlider.height/3;
                                        obj6.width = width/6*2; obj6.height = mainSlider.height/3;
                                        flowLayoutRectid.height = mainSlider.height*3;
                                    }else{

                                        sliderSwipeViewParentid.anchors.leftMargin = 65;
                                        sliderSwipeViewParentid.anchors.rightMargin = 65;

                                        obj1.width = width/5*5; obj1.height = mainSlider.height/7*3;
                                        obj2.width = width/2; obj2.height = mainSlider.height/3;

//                                        obj3.width = width/2; obj3.height = mainSlider.height/3;
                                        obj4.width = width/2; obj4.height = mainSlider.height/3;

                                        obj5.width = width/3; obj5.height = obj5.itemCount*70+50;
                                        obj6.width = width/3; obj6.height = obj6.itemCount*70+50;
                                        obj7.width = width/3; obj7.height = obj7.itemCount*70+50;

                                        projectContectid.width = width; projectContectid.height = 500;
                                        projectContectid.responsiveDivider = 4;
                                        projectContectid.height = projectContectid.itemCount/projectContectid.responsiveDivider*projectContectid.itemHeight+40+50;

                                        print( "project COntent Height: " + projectContectid.height);

                                        var _height = obj1.height;

                                        _height += obj4.height;

                                        var maxheightObj = obj5.height;
                                        if( maxheightObj < obj6.height ) maxheightObj = obj6.height;
                                        if( maxheightObj < obj7.height ) maxheightObj = obj7.height;
                                        _height += maxheightObj;

                                        _height += projectContectid.height;

                                        _height += footerinformationid.height;

                                        flowLayoutRectid.height = _height;
                                    }

                                }else{
                                    sliderSwipeViewParentid.anchors.leftMargin = 65;
                                    sliderSwipeViewParentid.anchors.rightMargin = 65;
                                    obj1.width = width/5*5; obj1.height = mainSlider.height/5*3;
                                    obj2.width = width/2;   obj2.height = mainSlider.height/3;

//                                    obj3.width = width/2;   obj3.height = mainSlider.height/3;
                                    obj4.width = width/2;   obj4.height = mainSlider.height/3;

                                    obj5.width = width/3; obj5.height = obj5.itemCount*70+50;
                                    obj6.width = width/3; obj6.height = obj6.itemCount*70+50;
                                    obj7.width = width/3; obj7.height = obj7.itemCount*70+50;

                                    projectContectid.width = width; projectContectid.height = 500;
                                    projectContectid.responsiveDivider = 3;
                                    projectContectid.height = projectContectid.itemCount/projectContectid.responsiveDivider*projectContectid.itemHeight+40+50;




                                    _height = obj1.height;

                                    _height += obj4.height;

                                    maxheightObj = obj5.height;
                                    if( maxheightObj < obj6.height ) maxheightObj = obj6.height;
                                    if( maxheightObj < obj7.height ) maxheightObj = obj7.height;
                                    _height += maxheightObj;
                                    _height += projectContectid.height;

                                    _height += footerinformationid.height;

                                    flowLayoutRectid.height = _height;
                                }
                            }else{
                                sliderSwipeViewParentid.anchors.leftMargin = 0;
                                sliderSwipeViewParentid.anchors.rightMargin = 0;
                                obj1.width = width; obj1.height = 230;
                                obj2.width = width; obj2.height = 200;
//                                obj3.width = width; obj3.height = 200;
                                obj4.width = width; obj4.height = 200;
                                obj5.width = width; obj5.height = obj5.itemCount*70+50;;
                                obj6.width = width; obj6.height = obj6.itemCount*70+50;
                                obj7.width = width; obj7.height = obj7.itemCount*70+50;
                                projectContectid.width = width; projectContectid.height = 500;
                                projectContectid.responsiveDivider = 2;
                                projectContectid.height = projectContectid.itemCount/projectContectid.responsiveDivider*projectContectid.itemHeight+40+50;

                                _height = obj1.height;
                                _height += obj2.height;
//                                _height += obj3.height;
                                _height += obj4.height;
                                _height += obj5.height;
                                _height += obj6.height;
                                _height += obj7.height;
                                _height += projectContectid.height;
                                _height += footerinformationid.height;

                                flowLayoutRectid.height = _height;
                            }
                        }

                    }

                }




            }





        }





    }


}
