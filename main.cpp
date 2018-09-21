#include <QtCore/qglobal.h>
#if QT_VERSION >= 0x050000
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#else
#endif

#include <QIcon>

#include "qmlmongodb.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/img/img/3D_Logox48.png"));

    QFile file("../DBoptions");

    QString url;
    QString dbname;
    if( file.open( QIODevice::ReadOnly ) )
    {
        QJsonObject info = QJsonDocument::fromBinaryData(file.readAll()).object();
        url = info["url"].toString();
        dbname = info["dbname"].toString();
        file.close();
        file.flush();
    }else{
        qDebug() << "file Can not Read for DB options";
        return -1;
    }

    QMLMongoDB::instance(url,dbname);


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
