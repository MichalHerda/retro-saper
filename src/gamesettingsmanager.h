#ifndef GAMESETTINGSMANAGER_H
#define GAMESETTINGSMANAGER_H

#include <QObject>
#include <QQmlEngine>
#include <QMetaEnum>

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

    Q_INVOKABLE void setDifficultyLevel(GameSettingsManager::DifficultyLevel _difficultyLevel);
    Q_PROPERTY(GameSettingsManager::DifficultyLevel difficultyLevel READ difficultyLevelRead WRITE difficultyLevelWrite NOTIFY difficultyLevelChanged);

    GameSettingsManager::DifficultyLevel difficultyLevel = DifficultyLevel::WastelandWanderer;
    GameSettingsManager::DifficultyLevel difficultyLevelRead()const;
    void difficultyLevelWrite(GameSettingsManager::DifficultyLevel _difficultyLevel);

signals:
    void difficultyLevelChanged(GameSettingsManager::DifficultyLevel _difficultyLevel);
private:
    //GameSettingsManager::DifficultyLevel m_difficultyLevel;
};

#endif // GAMESETTINGSMANAGER_H
