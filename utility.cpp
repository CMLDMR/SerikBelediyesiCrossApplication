#include "utility.h"

Utility::Utility(QObject *parent) : QObject(parent)
{

}

QString Utility::RepairHTML(QString html)
{

    int count = html.count("src=");
    int index = 0;
    for( int i = 0 ; i < count ; i++ )
    {
        index = html.indexOf("src=",index) +1;
        html = html.insert(index+4,"http://www.serik.bel.tr/");
    }
    return html;
}
