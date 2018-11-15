#ifndef PERSONEL_H
#define PERSONEL_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>


#include "qbson.h"
#include "qmongodb.h"
#include "qelement.h"
#include "qerror.h"
#include "qmongodb.h"

#include "qmlbson.h"

#include <iostream>
#include <memory.h>


class Personel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool logined READ logined NOTIFY loginned)
public:
    explicit Personel(QMongoDB* _db , QObject *parent = nullptr);

    virtual ~Personel();


    Q_INVOKABLE bool login(const QString& tel , const QString& password);

    Q_INVOKABLE void logout();

    bool logined() const;

    void setLogined(bool logined);

signals:

    void loginned();

public slots:


private:
    std::unique_ptr<QBSON> mPersonelDocument;

    QMongoDB* db;

    bool mLogined;

};

#endif // PERSONEL_H
