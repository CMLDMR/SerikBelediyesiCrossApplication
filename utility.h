#ifndef UTILITY_H
#define UTILITY_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>
#include <QDate>


class Utility : public QObject
{
    Q_OBJECT
public:
    explicit Utility(QObject *parent = nullptr);

    Q_INVOKABLE QString RepairHTML( QString html , int width );

    Q_INVOKABLE double currentDateDouble();

signals:

public slots:
};

#endif // UTILITY_H
