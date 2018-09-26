import QtQuick 2.0

Item {

    property string imgSource: ""
    property string imgPath: ""

    property int index: 0
    signal deletedimg(var i);

    width: 50
    height: 50


    Image {
        id: imgCekGonderid
        source: imgSource
        width: 50
        height: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                deletedimg(index);
                imgCekGonderid.destroy();
            }
        }
    }

}
