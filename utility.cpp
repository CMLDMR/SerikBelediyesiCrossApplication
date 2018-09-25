#include "utility.h"

Utility::Utility(QObject *parent) : QObject(parent)
{

}

QString Utility::RepairHTML(QString html, int width)
{
    int count = html.count("src=");
    int index = 0;
    for( int i = 0 ; i < count ; i++ )
    {
        index = html.indexOf("src=",index) +1;
        html = html.insert(index+4,"http://www.serik.bel.tr/");
    }

    count = html.count("width=");
    index = 0;
    for( int i = 0 ; i < count ; i++ )
    {
        index = html.indexOf("width=",index) +1;
        html = html.replace(index+6,4,QString::number(width));
    }
    return html;
}

double Utility::currentDateDouble()
{
    return QDate::currentDate().toString("yyyyMMdd").toDouble();
}

