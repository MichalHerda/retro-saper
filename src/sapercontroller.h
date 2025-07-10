#ifndef SAPERCONTROLLER_H
#define SAPERCONTROLLER_H

#include <QObject>
#include <QQmlEngine>
#include "sapermodel.h"
#include "gamesettingsmanager.h"
#include "gametimer.h"

class SaperController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit SaperController(QObject *parent = nullptr);
    ~SaperController();

    Q_PROPERTY(SaperModel* model READ model NOTIFY modelChanged)
    Q_PROPERTY(GameTimer* gameTimer READ gameTimer CONSTANT)
    Q_PROPERTY(bool isFirstMove READ getIsFirstMove WRITE setIsFirstMove NOTIFY isFirstMoveChanged)
    Q_PROPERTY(bool isGameOver READ getIsGameOver WRITE setIsGameOver NOTIFY isGameOverChanged)
    Q_PROPERTY(bool isWin READ getIsWin WRITE setIsWin NOTIFY isWinChanged)
    Q_PROPERTY(double lastGameTime READ getLastGameTime WRITE setLastGameTime NOTIFY lastGameTimeChanged)
    Q_PROPERTY(GameSettingsManager::DifficultyLevel difficultyLevel READ getDifficultyLevel WRITE setDifficultyLevel NOTIFY difficultyLevelChanged)
    Q_PROPERTY(QVariantList highScores READ getHighScores NOTIFY highScoresChanged)

    SaperModel* model();
    Q_INVOKABLE int getRowsNo();
    Q_INVOKABLE int getColsNo();
    int getBombsNo();
    Q_INVOKABLE void placeBombsRandomly(int safeRow, int safeCol);
    Q_INVOKABLE void revealCell(int row, int col);
    Q_INVOKABLE void setFlagged(int row, int col, bool flagged);
    Q_INVOKABLE void resetBoard();
    Q_INVOKABLE bool checkForGameOver();
    Q_INVOKABLE QVariantList highScoresForDifficulty(int difficulty) const;

    GameSettingsManager::DifficultyLevel getDifficultyLevel();
    void setDifficultyLevel(GameSettingsManager::DifficultyLevel difficultyLevel);

    bool getIsFirstMove();
    void setIsFirstMove(bool isFirstMove);

    bool getIsGameOver();
    void setIsGameOver(bool isGameOver);

    bool getIsWin();
    void setIsWin(bool isWin);

    double getLastGameTime();
    void setLastGameTime(double timeSeconds);

    GameTimer* gameTimer() const;
    QVariantList getHighScores();

public slots:
    void applyDifficultyLevel(GameSettingsManager::DifficultyLevel level);
    void handleTimeLimitReached();
    void loadHighScoresForDifficulty(int difficulty);

signals:
    void modelChanged();
    void isFirstMoveChanged(bool isFirstMove);
    void isGameOverChanged(bool isGameOver);
    void isWinChanged(bool isWin);
    void lastGameTimeChanged(double timeSeconds);
    void difficultyLevelChanged(GameSettingsManager::DifficultyLevel difficultyLevel);
    void highScoresChanged(QVariantList highScores);

private:
    bool m_isFirstMove = true;
    bool m_isGameOver = false;
    bool m_isWin = false;
    double m_lastGameTime = 0;
    GameSettingsManager::DifficultyLevel m_difficultyLevel = GameSettingsManager::DifficultyLevel::AshenSurvivor;
    SaperModel* m_model;
    GameSettingsManager* m_settings;
    GameTimer* m_gameTimer;
    QVariantList m_highScores;
};

#endif // SAPERCONTROLLER_H
