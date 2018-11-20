#include "user.h"

User::User(QMongoDB *_db, QObject *parent) : QObject(parent) , db(_db)
{
    mUserDocument = std::make_unique<QBSON>();

    this->setLogined(false);
}

bool User::login(const QString &telefon, const QString &sifre)
{

    QBSON filter;

    filter.append("Cep Telefonu",telefon);

    filter.append("password",sifre);


    auto val = this->db->find_one("TC",filter);

    if( val.isEmpty() )
    {
        return false;
    }else{
        this->setLogined(true);
        return true;
    }


}

void User::logout()
{
    mUserDocument.get()->clear();
    this->setLogined(false);
}

bool User::logined() const
{
    return mLogined;
}

void User::setLogined(bool logined)
{
    mLogined = logined;
    emit loginedChanged();
}
