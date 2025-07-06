#include "gametimer.h"

GameTimer::GameTimer(QObject *parent)
    : QObject{parent}
{
    m_updateTimer.setInterval(10);
    connect(&m_updateTimer, &QTimer::timeout, this, &GameTimer::updateElapsed);
}

void GameTimer::start()
{
    if (!m_running) {
        m_timer.start();
        m_updateTimer.start();
        m_running = true;
        emit elapsedChanged(elapsedSeconds());
    }
}

void GameTimer::stop()
{
    if (m_running) {
        m_updateTimer.stop();
        m_running = false;
        emit elapsedChanged(elapsedSeconds());
    }
}

void GameTimer::reset()
{
    m_timer.invalidate();
    m_updateTimer.stop();
    m_running = false;
    emit elapsedChanged(0.0);
}

double GameTimer::elapsedSeconds() const
{
    if (m_timer.isValid()) {
        return m_timer.elapsed() / 1000.0;
    }
    else {
        return 0.0;
    }
}

void GameTimer::updateElapsed()
{
    emit elapsedChanged(elapsedSeconds());
}
