#ifndef PERSONEL_H
#define PERSONEL_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>

class Personel : public QObject
{
    Q_OBJECT
public:
    explicit Personel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // PERSONEL_H