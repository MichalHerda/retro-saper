#include "sapercontroller.h"

SaperController::SaperController(QObject *parent)
    : QObject{parent}
{
    m_model = new SaperModel(this);

    connect(this, &SaperController::difficultyLevelChanged, this, &SaperController::applyDifficultyLevel);
}

SaperController::~SaperController()
{
    delete m_model;
}

int SaperController::getRowsNo()
{
    return m_model->rowCount();
}


int SaperController::getColsNo()
{
    return m_model->columnCount();
}

GameSettingsManager::DifficultyLevel SaperController::getDifficultyLevel()
{
    return difficultyLevel;
}

void SaperController::setDifficultyLevel(GameSettingsManager::DifficultyLevel _difficultyLevel)
{
    difficultyLevel = _difficultyLevel;
    emit difficultyLevelChanged(_difficultyLevel);
}

void SaperController::applyDifficultyLevel(GameSettingsManager::DifficultyLevel level)
{
    int rows, cols;
    switch (level) {
    case GameSettingsManager::DifficultyLevel::RadiationScavenge:
        rows = 6; cols = 6;
        break;
    case GameSettingsManager::DifficultyLevel::WastelandWanderer:
        rows = 12; cols = 12;
        break;

    case GameSettingsManager::DifficultyLevel::AshenSurvivor:
        rows = 18; cols = 18;
        break;

    case GameSettingsManager::DifficultyLevel::NuclearOutlaw:
        rows = 24; cols = 24;
        break;

    case GameSettingsManager::DifficultyLevel::RadstormVeteran:
        rows = 36; cols = 36;
        break;

    case GameSettingsManager::DifficultyLevel::GammaReaper:
        rows = 48; cols = 48;
        break;

    case GameSettingsManager::DifficultyLevel::DoomsdayOverlord:
        rows = 60; cols = 60;
        break;
    }

    m_model->SaperModel::setGrid(rows, cols);
}


