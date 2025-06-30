#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQmlIntegration/qqmlintegration.h>
//#include "gamesettingsmanager.h"
#include "sapercontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    SaperController saperController;
    //GameSettingsManager gameSettingsManager;
    //qRegisterMetaType<GameSettingsManager::DifficultyLevel>("GameSettingsManager::DifficultyLevel");

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
