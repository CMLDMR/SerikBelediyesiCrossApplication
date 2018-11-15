#include "utility.h"

Utility::Utility(QObject *parent) : QObject(parent)
{

    mRootHeight = 0;
    mRootWidth = 0;
}

QString Utility::repairHTML(QString html, int width)
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

QString Utility::currentSaat() const
{
    return QTime::currentTime().toString("hh:mm");
}

QString Utility::currentStringDay() const
{
    return QDate::currentDate().toString("dddd dd/MM/yyyy");
}

QString Utility::julianDaytoString(qint64 julianday) const
{
    return QDate::fromJulianDay(julianday).toString("dddd dd/MM/yyyy");
}

QString Utility::uniqueString() const
{

    return QString("%1%2").arg(QDate::currentDate().toJulianDay()).arg(QTime::currentTime().toString("hhmmsszzz"));

}

int Utility::rootWidth() const
{
    return mRootWidth;
}

void Utility::setRootWidth(int rootWidth)
{
//    std::cout << "Width Changed " << rootWidth << std::endl;

    mRootWidth = rootWidth;
    emit rootWidthChanged();
}

int Utility::rootHeight() const
{
    return mRootHeight;
}

void Utility::setRootHeight(int rootHeight)
{
//    std::cout << "Height Changed " << rootHeight << std::endl;
    mRootHeight = rootHeight;
    emit rootHeightChanged();
}

qint64 Utility::currentJulianDay() const
{
    return QDate::currentDate().toJulianDay();
}

qint64 Utility::stringToJulianDay(const QString &date) const
{
    std::cout << date.toStdString().c_str() << std::endl;

    return QDate::fromString(date,"ddd MMM d yyyy").toJulianDay();
}

