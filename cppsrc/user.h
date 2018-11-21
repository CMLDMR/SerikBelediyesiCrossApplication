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
    Q_PROPERTY(QString telefon READ telefon WRITE setTelefon NOTIFY telefonChanged)
    Q_PROPERTY(QString nameSurname READ nameSurname WRITE setNameSurname NOTIFY nameSurnameChanged)
    Q_PROPERTY(QString mahalle READ mahalle NOTIFY mahalleChanged)
    Q_PROPERTY(QString tcno READ tcno NOTIFY tcnoChanged)

public:
    explicit User(QMongoDB* _db , QObject *parent = nullptr);


    ~User();


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

    QString telefon() const;
    void setTelefon(const QString &telefon);

    QString nameSurname() const;
    void setNameSurname(const QString &nameSurname);


    ///
    /// \brief mahalle
    /// \return
    /// Kullanıcın İkamet Ettiği Mahalle
    QString mahalle() const;


    ///
    /// \brief tcno
    /// \return
    /// Kullanıcının TCNOsu
    QString tcno() const;

signals:
    void loginedChanged();
    void telefonChanged();
    void nameSurnameChanged();
    void mahalleChanged();
    void tcnoChanged();

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

    ///
    /// \brief mTelefon
    /// Kullanıcının Telefon Numarası
    QString mTelefon;

    ///
    /// \brief mNameSurname
    /// Kullanıcın Adı Soyadı
    QString mNameSurname;
};

#endif // USER_H
