#include "sapercontroller.h"

SaperController::SaperController(QObject *parent)
    : QObject{parent}
{}

GameSettingsManager::DifficultyLevel SaperController::getDifficultyLevel()
{
    return difficultyLevel;
}

void SaperController::setDifficultyLevel(GameSettingsManager::DifficultyLevel _difficultyLevel)
{
    difficultyLevel = _difficultyLevel;
    emit difficultyLevelChanged(_difficultyLevel);
}


