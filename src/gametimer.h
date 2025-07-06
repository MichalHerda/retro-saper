#ifndef GAMETIMER_H
#define GAMETIMER_H

#include <QObject>
#include <QTimer>
#include <QElapsedTimer>

class GameTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double elapsedSeconds READ elapsedSeconds NOTIFY elapsedChanged)
public:
    explicit GameTimer(QObject *parent = nullptr);

    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void reset();

    double elapsedSeconds() const;
signals:
    void elapsedChanged(double elapsed);
    void timeLimitReached();

private slots:
    void updateElapsed();

private:
    QElapsedTimer m_timer;
    QTimer m_updateTimer;
    bool m_running = false;
};

#endif // GAMETIMER_H
