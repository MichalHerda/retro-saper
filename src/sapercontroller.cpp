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
        rows = 8; cols = 8;
        break;
    case GameSettingsManager::DifficultyLevel::WastelandWanderer:
        rows = 16; cols = 16;
        break;

    case GameSettingsManager::DifficultyLevel::AshenSurvivor:
        rows = 24; cols = 24;
        break;

    case GameSettingsManager::DifficultyLevel::NuclearOutlaw:
        rows = 48; cols = 48;
        break;

    case GameSettingsManager::DifficultyLevel::RadstormVeteran:
        rows = 64; cols = 64;
        break;

    case GameSettingsManager::DifficultyLevel::GammaReaper:
        rows = 96; cols = 96;
        break;

    case GameSettingsManager::DifficultyLevel::DoomsdayOverlord:
        rows = 128; cols = 128;
        break;
    }

    m_model->SaperModel::setGrid(rows, cols);
}


