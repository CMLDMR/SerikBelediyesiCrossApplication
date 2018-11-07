#include <QtCore/qglobal.h>
#if QT_VERSION >= 0x050000
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#else
#endif

#include <QtQml/QQmlContext>

#include <QIcon>

#include "qmlmongodb.h"
#include "utility.h"
#include "../url.h" // Remove this line and put on your own database in QString url and QString dbname

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/img/img/3D_Logox48.png"));

//    qmlRegisterType<Utility>("Utility", 0, 7, "Utility");

    QMLMongoDB::instance(url,dbname);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("db",new QMLMongoDB());

    engine.rootContext()->setContextProperty("Utility",new Utility());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
