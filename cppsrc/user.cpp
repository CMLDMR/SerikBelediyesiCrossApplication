#include "user.h"

User::User(QMongoDB *_db, QObject *parent) : QObject(parent) , db(_db)
{
    mUserDocument = std::make_unique<QBSON>();

    this->setLogined(false);
}

User::~User()
{
    mUserDocument.release();
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

        mUserDocument.get()->clear();

        mUserDocument.get()->append(val.getMaplist());



        try {
            this->setTelefon(mUserDocument.get()->value("Cep Telefonu").getValue().toString());
        } catch (QError &e) {
            std::cout << "Error: " << e.what() << std::endl;
        }

        try {
            this->setNameSurname(mUserDocument.get()->value("İsimSoyisim").getValue().toString());
        } catch (QError &e) {
            std::cout << "Error: " << e.what() << std::endl;
        }

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

QString User::telefon() const
{
    return mTelefon;
}

void User::setTelefon(const QString &telefon)
{
    mTelefon = telefon;
    emit telefonChanged();
}

QString User::nameSurname() const
{
    return mNameSurname;
}

void User::setNameSurname(const QString &nameSurname)
{
    mNameSurname = nameSurname;
    emit nameSurnameChanged();
}

QString User::mahalle() const
{
    try {
        return this->mUserDocument.get()->value("Mahalle").getValue().toString();
    } catch (QError &e) {
        return e.what();
    }
}

QString User::tcno() const
{
    try {
        return this->mUserDocument.get()->value("TCNO").getValue().toString();
    } catch (QError &e) {
        return e.what();
    }
}
