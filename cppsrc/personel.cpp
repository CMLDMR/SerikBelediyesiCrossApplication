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

    mPersonelDocument->append(var.getMaplist());


    std::cout << mPersonelDocument.get()->tojson().c_str() << std::endl;


    if( var.isEmpty() )
    {
        return false;
    }else{
        return true;
    }


}

