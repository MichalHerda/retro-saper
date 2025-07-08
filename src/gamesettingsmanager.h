#ifndef GAMESETTINGSMANAGER_H
#define GAMESETTINGSMANAGER_H

#include <QObject>
#include <QQmlEngine>
#include <QMetaEnum>
#include <QSettings>
#include <QDateTime>

struct HighScoreEntry
{
    QString playerName;
    QDateTime achievedAt;
    int timeSeconds;

    QVariantMap toVariantMap() const {
        return {
            {"playerName", playerName},
            {"achievedAt", achievedAt.toString(Qt::ISODate)},
            {"timeSeconds", timeSeconds}
        };
    }

    static HighScoreEntry fromVariantMap(const QVariantMap &map) {
        HighScoreEntry entry;
        entry.playerName = map.value("playerName").toString();
        entry.achievedAt = QDateTime::fromString(map.value("achievedAt").toString(), Qt::ISODate);
        entry.timeSeconds = map.value("timeSeconds").toInt();
        return entry;
    }
};

class GameSettingsManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum class DifficultyLevel {
        RadiationScavenge,
        WastelandWanderer,
        AshenSurvivor,
        NuclearOutlaw,
        RadstormVeteran,
        GammaReaper,
        DoomsdayOverlord,
    };
    Q_ENUM(DifficultyLevel)

    explicit GameSettingsManager(QObject *parent = nullptr);

    void saveHighScores();
    void loadHighScores();
    void addHighScore(DifficultyLevel diff, const HighScoreEntry &entry);
    Q_INVOKABLE bool qualifiesForHighScores(int diff, int timeSeconds) const;
    Q_INVOKABLE void addHighScoreInvokable(int diff, const QString &playerName, int timeSeconds);
    Q_INVOKABLE QVariantList getHighScores(int diff) const;
    //Q_INVOKABLE bool tryAddHighScore(int diff, const QString &playerName, int timeSeconds);

signals:

private:
    QSettings m_settings;
    QMap<DifficultyLevel, QList<HighScoreEntry>> m_highScores;
};

#endif // GAMESETTINGSMANAGER_H
