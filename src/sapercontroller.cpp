#include "sapercontroller.h"

SaperController::SaperController(QObject *parent)
    : QObject{parent}
{
    m_model = new SaperModel(this);
    m_gameTimer = new GameTimer(this);
    m_settings = new GameSettingsManager(this);

    m_model->SaperModel::setGrid(18, 18);
    m_model->SaperModel::setBombsNo(40);

    connect(this, &SaperController::difficultyLevelChanged, this, &SaperController::applyDifficultyLevel);
    connect(m_gameTimer, &GameTimer::timeLimitReached, this, &SaperController::handleTimeLimitReached);
}

SaperController::~SaperController()
{
    delete m_model;
}

SaperModel *SaperController::model()
{
    return m_model;
}

int SaperController::getRowsNo()
{
    return m_model->rowCount();
}


int SaperController::getColsNo()
{
    return m_model->columnCount();
}

int SaperController::getBombsNo()
{
    return m_model->getBombsNo();
}

void SaperController::placeBombsRandomly(int safeRow, int safeCol)
{
    m_model->placeBombsRandomly(getBombsNo(), safeRow, safeCol);
    emit modelChanged();
}

void SaperController::revealCell(int row, int col)
{
    m_model->revealCell(row, col);
}

void SaperController::setFlagged(int row, int col, bool flagged)
{
    m_model->setFlagged(row, col, flagged);
}

void SaperController::resetBoard()
{
    m_model->resetRevealed();
    m_isFirstMove = true;
}

bool SaperController::checkForGameOver()
{
    if(m_model->checkForWin()) {
        qDebug() << "controller, check for win, emit isGameOverChanged)";
        m_gameTimer->stop();
        //setLastGameTime(static_cast<int>(m_gameTimer->elapsedSeconds()));
        setLastGameTime(m_gameTimer->elapsedSeconds());
        qDebug() << "controller, last game time: " << getLastGameTime();
        setIsWin(true);
        setIsGameOver(true);
        return true;
    }
    if(m_model->checkForLose()) {
        qDebug() << "controller, check for lose, emit isGameOverChanged)";
        m_gameTimer->stop();
        setIsWin(false);
        setIsGameOver(true);
        return true;
    }

    qDebug() << "controller, check for win/lose false ";
    return false;
}

QVariantList SaperController::highScoresForDifficulty(int difficulty) const
{
    QVariantList all = m_settings->getHighScores(difficulty);
    QVariantList filtered;

    for (const QVariant &v : all) {
        QVariantMap m = v.toMap();
        if (m.value("difficultyLevel").toInt() == difficulty)
            filtered << m;
    }

    return filtered;
}

void SaperController::addHighScore(int diff, const QString &playerName, double timeSeconds)
{
    if (!m_settings)
        return;

    m_settings->addHighScoreInvokable(diff, playerName, timeSeconds);

    loadHighScoresForDifficulty(diff);
}

GameSettingsManager::DifficultyLevel SaperController::getDifficultyLevel()
{
    return m_difficultyLevel;
}

void SaperController::setDifficultyLevel(GameSettingsManager::DifficultyLevel difficultyLevel)
{
    m_difficultyLevel = difficultyLevel;
    emit difficultyLevelChanged(difficultyLevel);
}

bool SaperController::getIsFirstMove()
{
    return m_isFirstMove;
}

void SaperController::setIsFirstMove(bool isFirstMove)
{
    if(isFirstMove == m_isFirstMove) {
        qDebug() << "isFirstMove not changed";
        return;
    }

    m_isFirstMove = isFirstMove;
    emit isFirstMoveChanged(isFirstMove);
}

bool SaperController::getIsGameOver()
{
    return m_isGameOver;
}

void SaperController::setIsGameOver(bool isGameOver)
{
    if(isGameOver == m_isGameOver) {
        qDebug() << "isGameOver not changed";
        return;
    }

    m_isGameOver = isGameOver;
    emit isGameOverChanged(isGameOver);
}

bool SaperController::getIsWin()
{
    return m_isWin;
}

void SaperController::setIsWin(bool isWin)
{
    if(isWin == m_isGameOver) {
        qDebug() << "isWin not changed";
        return;
    }

    m_isWin = isWin;

    emit isWinChanged(isWin);
}

double SaperController::getLastGameTime()
{
    return m_lastGameTime;
}

void SaperController::setLastGameTime(double timeSeconds)
{
    m_lastGameTime = timeSeconds;
    emit lastGameTimeChanged(m_lastGameTime);
}

GameTimer *SaperController::gameTimer() const
{
    return m_gameTimer;
}

QVariantList SaperController::getHighScores()
{
    QSettings settings;
    QVariant value = settings.value("highscores");

    return value.toList();
}

void SaperController::applyDifficultyLevel(GameSettingsManager::DifficultyLevel level)
{
    int rows, cols, bombs;
    switch (level) {
        case GameSettingsManager::DifficultyLevel::RadiationScavenge:
            rows = 8; cols = 8; bombs = 7;
            break;
        case GameSettingsManager::DifficultyLevel::WastelandWanderer:
            rows = 12; cols = 12; bombs = 17;
            break;

        case GameSettingsManager::DifficultyLevel::AshenSurvivor:
            rows = 18; cols = 18; bombs = 35;
            break;

        case GameSettingsManager::DifficultyLevel::NuclearOutlaw:
            rows = 24; cols = 24; bombs = 55;
            break;

        case GameSettingsManager::DifficultyLevel::RadstormVeteran:
            rows = 34; cols = 34; bombs = 110;
            break;

        case GameSettingsManager::DifficultyLevel::GammaReaper:
            rows = 42; cols = 42; bombs = 190;
            break;

        case GameSettingsManager::DifficultyLevel::DoomsdayOverlord:
            rows = 50; cols = 50; bombs = 300;
            break;
    }

    m_model->SaperModel::setGrid(rows, cols);
    m_model->SaperModel::setBombsNo(bombs);
    emit modelChanged();
}

void SaperController::handleTimeLimitReached()
{
    setIsGameOver(true);
    setIsWin(false);
}

void SaperController::loadHighScoresForDifficulty(int difficulty)
{
    if (!m_settings) {
        return;
    }
    m_highScores = m_settings->getHighScores(difficulty);
    emit highScoresChanged(m_highScores);
}


