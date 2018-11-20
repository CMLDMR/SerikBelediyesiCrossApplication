#ifndef UTILITY_H
#define UTILITY_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>
#include <QDate>
#include <QTime>

#include <iostream>>


class Utility : public QObject
{
    Q_OBJECT
    Q_PROPERTY( int rootWidth READ rootWidth WRITE setRootWidth NOTIFY rootWidthChanged )
    Q_PROPERTY( int rootHeight READ rootHeight WRITE setRootHeight NOTIFY rootHeightChanged )
    Q_PROPERTY( QString information READ information WRITE setInformation NOTIFY informationChanged)
public:
    explicit Utility(QObject *parent = nullptr);

    Q_INVOKABLE QString repairHTML( QString html , int width );

    Q_INVOKABLE double currentDateDouble();

    Q_INVOKABLE qint64 currentJulianDay() const;

    Q_INVOKABLE qint64 stringToJulianDay(const QString& date) const;

    Q_INVOKABLE QString currentSaat() const;

    Q_INVOKABLE QString currentStringDay() const;

    Q_INVOKABLE QString julianDaytoString( qint64 julianday ) const;

    Q_INVOKABLE QString uniqueString() const;


    int rootWidth() const;
    void setRootWidth(int rootWidth);

    int rootHeight() const;

    void setRootHeight(int rootHeight);

    QString information() const;
    void setInformation(const QString &information);

signals:
    void rootWidthChanged();

    void rootHeightChanged();

    void informationChanged();

public slots:


private:

    int mRootWidth;

    int mRootHeight;


    QString mInformation;


};

#endif // UTILITY_H
