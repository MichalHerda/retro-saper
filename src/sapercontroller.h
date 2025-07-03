#ifndef SAPERCONTROLLER_H
#define SAPERCONTROLLER_H

#include <QObject>
#include <QQmlEngine>
#include "sapermodel.h"
#include "gamesettingsmanager.h"

class SaperController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit SaperController(QObject *parent = nullptr);
    ~SaperController();

    Q_PROPERTY(SaperModel* model READ model /*CONSTANT*/NOTIFY modelChanged)
    Q_PROPERTY(GameSettingsManager::DifficultyLevel difficultyLevel READ getDifficultyLevel WRITE setDifficultyLevel NOTIFY difficultyLevelChanged)

    SaperModel* model();
    Q_INVOKABLE int getRowsNo();
    Q_INVOKABLE int getColsNo();
    int getBombsNo();
    Q_INVOKABLE void placeBombsRandomly();

    GameSettingsManager::DifficultyLevel getDifficultyLevel();
    void setDifficultyLevel(GameSettingsManager::DifficultyLevel _difficultyLevel);
    GameSettingsManager::DifficultyLevel difficultyLevel = GameSettingsManager::DifficultyLevel::AshenSurvivor;

public slots:
    void applyDifficultyLevel(GameSettingsManager::DifficultyLevel level);
signals:
    void modelChanged();
    void difficultyLevelChanged(GameSettingsManager::DifficultyLevel _difficultyLevel);

private:
    SaperModel* m_model;
    GameSettingsManager* m_settings;
};

#endif // SAPERCONTROLLER_H
