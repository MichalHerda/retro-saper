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
    Q_PROPERTY(bool isGameOver READ getIsGameOver WRITE setIsGameOver NOTIFY isGameOverChanged)
    Q_PROPERTY(bool isWin READ getIsWin WRITE setIsWin NOTIFY isWinChanged)
    Q_PROPERTY(GameSettingsManager::DifficultyLevel difficultyLevel READ getDifficultyLevel WRITE setDifficultyLevel NOTIFY difficultyLevelChanged)

    SaperModel* model();
    Q_INVOKABLE int getRowsNo();
    Q_INVOKABLE int getColsNo();
    int getBombsNo();
    Q_INVOKABLE void placeBombsRandomly(int safeRow, int safeCol);
    Q_INVOKABLE void revealCell(int row, int col);
    Q_INVOKABLE void setFlagged(int row, int col, bool flagged);
    Q_INVOKABLE void resetBoard();
    Q_INVOKABLE bool checkForGameOver();

    GameSettingsManager::DifficultyLevel getDifficultyLevel();
    void setDifficultyLevel(GameSettingsManager::DifficultyLevel difficultyLevel);

    bool getIsFirstMove();
    void setIsFirstMove(bool isFirstMove);

    bool getIsGameOver();
    void setIsGameOver(bool isGameOver);

    bool getIsWin();
    void setIsWin(bool isWin);

public slots:
    void applyDifficultyLevel(GameSettingsManager::DifficultyLevel level);
signals:
    void modelChanged();
    void isFirstMoveChanged(bool isFirstMove);
    void isGameOverChanged(bool isGameOver);
    void isWinChanged(bool isWin);
    void difficultyLevelChanged(GameSettingsManager::DifficultyLevel difficultyLevel);

private:
    bool m_isFirstMove = true;
    bool m_isGameOver = false;
    bool m_isWin = false;
    GameSettingsManager::DifficultyLevel m_difficultyLevel = GameSettingsManager::DifficultyLevel::AshenSurvivor;
    SaperModel* m_model;
    GameSettingsManager* m_settings;
};

#endif // SAPERCONTROLLER_H
