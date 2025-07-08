#include "gamesettingsmanager.h"

GameSettingsManager::GameSettingsManager(QObject *parent)
    : QObject{parent}
{
    loadHighScores();
}

void GameSettingsManager::saveHighScores()
{
    for (auto diff : m_highScores.keys()) {
        QVariantList list;
        for (const auto &entry : m_highScores[diff]) {
            list.append(entry.toVariantMap());
        }
        m_settings.setValue(QString("highscores/%1").arg(static_cast<int>(diff)), list);
    }
}

void GameSettingsManager::loadHighScores()
{
    m_highScores.clear();
    for (int i = static_cast<int>(DifficultyLevel::RadiationScavenge); i <= static_cast<int>(DifficultyLevel::DoomsdayOverlord); ++i) {
        auto diff = static_cast<DifficultyLevel>(i);
        QVariantList list = m_settings.value(QString("highscores/%1").arg(i)).toList();

        QList<HighScoreEntry> entries;
        for (const QVariant &item : list) {
            entries.append(HighScoreEntry::fromVariantMap(item.toMap()));
        }
        m_highScores[diff] = entries;
    }
}

void GameSettingsManager::addHighScore(DifficultyLevel diff, const HighScoreEntry &entry)
{
    auto &list = m_highScores[diff];
    list.append(entry);

    // Sortuj rosnąco po czasie (lepszy = mniejszy czas)
    std::sort(list.begin(), list.end(), [](const HighScoreEntry &a, const HighScoreEntry &b) {
        return a.timeSeconds < b.timeSeconds;
    });

    // Przytnij do 20
    if (list.size() > 20) {
        list = list.mid(0, 20);
    }

    saveHighScores();
}


void GameSettingsManager::addHighScoreInvokable(int diff, const QString &playerName, int timeSeconds)
{
    HighScoreEntry entry;
    entry.playerName = playerName;
    entry.timeSeconds = timeSeconds;
    entry.achievedAt = QDateTime::currentDateTime();

    addHighScore(static_cast<DifficultyLevel>(diff), entry);
}

QVariantList GameSettingsManager::getHighScores(int diff) const
{
    QVariantList list;
    auto difficulty = static_cast<DifficultyLevel>(diff);
    for (const auto &entry : m_highScores.value(difficulty)) {
        list.append(entry.toVariantMap());
    }
    return list;
}

