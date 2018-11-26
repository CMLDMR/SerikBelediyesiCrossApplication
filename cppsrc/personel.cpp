#include "personel.h"

Personel::Personel(QMongoDB *_db, QObject *parent) : QObject(parent) , db( _db)
{

    mPersonelDocument = std::make_unique<QBSON>();

    this->setLogined(false);

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
        mPersonelDocument.get()->clear();

        mPersonelDocument->append(var.getMaplist());

        this->setLogined(true);

        return true;
    }


}

bool Personel::refresh()
{

    if( !logined() )
    {
        return false;
    }

    QBSON filter;

    filter.append("telefon",mPersonelDocument.get()->value("telefon").getValue().toString());

    filter.append("password",mPersonelDocument.get()->value("password").getValue().toString());

    auto var = this->db->find_one("Personel",filter);

    if( var.isEmpty() )
    {
        return false;
    }else{
        mLogined = true;
        mPersonelDocument->clear();
        mPersonelDocument->append(var.getMaplist());
        return true;
    }
}

void Personel::logout()
{
    mLogined = false;
    emit loginned();
}

bool Personel::checkYetki(const QString &yetki)
{

    bool returnFalse = false;
    try {
        auto yetkilist = mPersonelDocument.get()->value("Yetki").toArray();

        for( auto item : yetkilist )
        {
            if( yetki == item.getValue().toString() ){
                returnFalse = true;
                break;
            }
        }
    } catch (QError &e) {
        std::cout << "Errror: " << e.what() << std::endl;
    }

    return returnFalse;

}

bool Personel::logined() const
{
    return mLogined;
}

void Personel::setLogined(bool logined)
{
    mLogined = logined;
    emit loginned();
}

