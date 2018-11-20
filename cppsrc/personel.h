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


    ///
    /// \brief login
    /// \param tel
    /// \param password
    /// \return
    /// Veritabanında Kullanıcı adı ve şifreyi kontrol eder ve bilgileri çeker.
    Q_INVOKABLE bool login(const QString& tel , const QString& password);

    ///
    /// \brief refresh
    /// \return
    /// Personel Bilgilerini Veritabanından Yeniden Çeker
    Q_INVOKABLE bool refresh();


    ///
    /// \brief logout
    /// Çıkış Yapar ve Personel Bilgilerini Nesneden Siler
    Q_INVOKABLE void logout();


    ///
    /// \brief checkYetki
    /// \param yetki
    /// \return
    /// Yetkiye Sahip olup olmadığını Kontrol eder.
    Q_INVOKABLE bool checkYetki( const QString& yetki);


    ///
    /// \brief logined
    /// \return
    /// Giriş Yapılıp Yapılmadığını Kontrol Eder.
    bool logined() const;


    ///
    /// \brief setLogined
    /// \param logined
    /// Giriş Yapıldığını İşaretler
    void setLogined(bool logined);

signals:

    ///
    /// \brief loginned
    /// Giriş Yapıldığı Anda Signal Tetiklenir.
    void loginned();

public slots:


private:
    std::unique_ptr<QBSON> mPersonelDocument;

    ///
    /// \brief db
    /// Veri Tabanı Bağlantısı
    QMongoDB* db;

    ///
    /// \brief mLogined
    /// Giriş Yapıldığına Dair Bilginin Saklandığı Değişken.
    bool mLogined;

};

#endif // PERSONEL_H
