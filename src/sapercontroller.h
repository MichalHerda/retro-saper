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

    Q_PROPERTY(SaperModel* model READ model NOTIFY modelChanged)
    Q_PROPERTY(bool isFirstMove READ getIsFirstMove WRITE setIsFirstMove NOTIFY isFirstMoveChanged)
    Q_PROPERTY(GameSettingsManager::DifficultyLevel difficultyLevel READ getDifficultyLevel WRITE setDifficultyLevel NOTIFY difficultyLevelChanged)

    SaperModel* model();
    Q_INVOKABLE int getRowsNo();
    Q_INVOKABLE int getColsNo();
    int getBombsNo();
    Q_INVOKABLE void placeBombsRandomly();

    GameSettingsManager::DifficultyLevel getDifficultyLevel();
    void setDifficultyLevel(GameSettingsManager::DifficultyLevel difficultyLevel);

    bool getIsFirstMove();
    void setIsFirstMove(bool isFirstMove);   

public slots:
    void applyDifficultyLevel(GameSettingsManager::DifficultyLevel level);
signals:
    void modelChanged();
    void isFirstMoveChanged(bool isFirstMove);
    void difficultyLevelChanged(GameSettingsManager::DifficultyLevel difficultyLevel);

private:
    bool m_isFirstMove = true;
    GameSettingsManager::DifficultyLevel m_difficultyLevel = GameSettingsManager::DifficultyLevel::AshenSurvivor;
    SaperModel* m_model;
    GameSettingsManager* m_settings;
};

#endif // SAPERCONTROLLER_H
