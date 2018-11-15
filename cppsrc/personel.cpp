#include "personel.h"

Personel::Personel(QMongoDB *_db, QObject *parent) : QObject(parent) , db( _db)
{

    mPersonelDocument = std::make_unique<QBSON>();


}

Personel::~Personel()
{

    mPersonelDocument.release();
}

bool Personel::login(const QString &tel, const QString &password)
{

    QBSON filter;

    filter.append("telefon",tel);

    filter.append("password",password);

    auto var = this->db->find_one("Personel",filter);


    if( var.isEmpty() )
    {
        mLogined = false;
        return false;


    }else{

        mLogined = true;

        emit loginned();

        mPersonelDocument->append(var.getMaplist());

        return true;
    }


}

void Personel::logout()
{
    mLogined = false;
    emit loginned();
}

bool Personel::logined() const
{
    return mLogined;
}

void Personel::setLogined(bool logined)
{
    mLogined = logined;
}

