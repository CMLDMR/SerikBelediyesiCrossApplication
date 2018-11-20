#ifndef USER_H
#define USER_H

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

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool logined READ logined WRITE setLogined NOTIFY loginedChanged)
public:
    explicit User(QMongoDB* _db , QObject *parent = nullptr);


    ///
    /// \brief login
    /// \param telefon
    /// \param sifre
    /// \return
    /// Telefon Numarası ve Şifre ile Veritabanını Kontrol et
    /// Kullanıcı var is true yoksa false döndürür.
    Q_INVOKABLE bool login( const QString& telefon , const QString& sifre);

    ///
    /// \brief logout
    /// Kullanıcı Çıkış Yapar. mUserDocument içeriğini Temizler
    Q_INVOKABLE void logout();

    bool logined() const;
    void setLogined(bool logined);

signals:
    void loginedChanged();
public slots:


private:

    ///
    /// \brief db
    /// Veri Tabanı Bağlantısı
    QMongoDB* db;

    ///
    /// \brief mUserDocument
    /// Kullanıcı Bilgileri
    std::unique_ptr<QBSON> mUserDocument;

    ///
    /// \brief mLogined
    /// Kullanıcı Giriş Yapıldığına Dair Bilgi
    bool mLogined;
};

#endif // USER_H
