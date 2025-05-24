#ifndef GAMESETTINGSMANAGER_H
#define GAMESETTINGSMANAGER_H

#include <QObject>
#include <QQmlEngine>

class GameSettingsManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT


public:
    enum DifficultyLevel {
        RadiationScavenge,
        WastelandWanderer,
        AshenSurvivor,
        NuclearOutlaw,
        RadstormVeteran,
        GammaReaper,
        DoomsdayOverlord,
    };

    explicit GameSettingsManager(QObject *parent = nullptr);

signals:
};

#endif // GAMESETTINGSMANAGER_H
