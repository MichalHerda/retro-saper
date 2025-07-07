#ifndef GAMESETTINGSMANAGER_H
#define GAMESETTINGSMANAGER_H

#include <QObject>
#include <QQmlEngine>
#include <QMetaEnum>
#include <QSettings>

class GameSettingsManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum class DifficultyLevel {
        RadiationScavenge,
        WastelandWanderer,
        AshenSurvivor,
        NuclearOutlaw,
        RadstormVeteran,
        GammaReaper,
        DoomsdayOverlord,
    };
    Q_ENUM(DifficultyLevel)

    explicit GameSettingsManager(QObject *parent = nullptr);

signals:

private:
    QSettings m_settings;
};

#endif // GAMESETTINGSMANAGER_H
