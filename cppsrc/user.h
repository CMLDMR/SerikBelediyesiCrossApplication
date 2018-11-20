#ifndef USER_H
#define USER_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>

class User : public QObject
{
Q_OBJECT
public:
explicit User(QObject *parent = nullptr);

signals:

public slots:
};

#endif // USER_H