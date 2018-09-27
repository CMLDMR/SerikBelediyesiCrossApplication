#ifndef UTILITY_H
#define UTILITY_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>
#include <QDate>
#include <QTime>


class Utility : public QObject
{
    Q_OBJECT
public:
    explicit Utility(QObject *parent = nullptr);

    Q_INVOKABLE QString RepairHTML( QString html , int width );

    Q_INVOKABLE double currentDateDouble();

    Q_INVOKABLE qint64 currentJulianDay() const;

    Q_INVOKABLE QString currentSaat() const;

    Q_INVOKABLE QString currentStringDay() const;

    Q_INVOKABLE QString julianDaytoString( qint64 julianday ) const;


signals:

public slots:
};

#endif // UTILITY_H
