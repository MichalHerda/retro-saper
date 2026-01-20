#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQmlIntegration/qqmlintegration.h>
#include "sapercontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("MH");
    QCoreApplication::setApplicationName("SAPER");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("SAPER", "Main");

    return app.exec();
}
