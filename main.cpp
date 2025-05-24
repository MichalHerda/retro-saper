#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "gamesettingsmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    GameSettingsManager gameSettingsManager;

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
