#include "sapercontroller.h"

SaperController::SaperController(QObject *parent)
    : QObject{parent}
{
    m_model = new SaperModel(this);

    m_model->SaperModel::setGrid(18, 18);
    m_model->SaperModel::setBombsNo(40);
    //placeBombsRandomly();

    connect(this, &SaperController::difficultyLevelChanged, this, &SaperController::applyDifficultyLevel);
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

void SaperController::applyDifficultyLevel(GameSettingsManager::DifficultyLevel level)
{
    int rows, cols, bombs;
    switch (level) {
        case GameSettingsManager::DifficultyLevel::RadiationScavenge:
            rows = 6; cols = 6; bombs = 4;
            break;
        case GameSettingsManager::DifficultyLevel::WastelandWanderer:
            rows = 12; cols = 12; bombs = 15;
            break;

        case GameSettingsManager::DifficultyLevel::AshenSurvivor:
            rows = 18; cols = 18; bombs = 40;
            break;

        case GameSettingsManager::DifficultyLevel::NuclearOutlaw:
            rows = 24; cols = 24; bombs = 80;
            break;

        case GameSettingsManager::DifficultyLevel::RadstormVeteran:
            rows = 36; cols = 36; bombs = 205;
            break;

        case GameSettingsManager::DifficultyLevel::GammaReaper:
            rows = 48; cols = 48; bombs = 420;
            break;

        case GameSettingsManager::DifficultyLevel::DoomsdayOverlord:
            rows = 60; cols = 60; bombs = 725;
            break;
    }

    m_model->SaperModel::setGrid(rows, cols);
    m_model->SaperModel::setBombsNo(bombs);
    //placeBombsRandomly();
    emit modelChanged();
}


