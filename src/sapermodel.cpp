#include "sapermodel.h"

SaperModel::SaperModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    //m_grid.resize(m_rows, QList<CellData>(m_cols));
}

int SaperModel::rowCount(const QModelIndex &) const {
    return m_rows;
}

int SaperModel::columnCount(const QModelIndex &) const {
    return m_cols;
}

QVariant SaperModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) return QVariant();
    const CellData &cell = m_grid[index.row()][index.column()];

    switch (role) {
    case IsRevealedRole:
        return cell.isRevealed;
    case IsFlaggedRole:
        return cell.isFlagged;
    case IsMineRole:
        return cell.isMine;
    case NeighborMinesRole:
        return cell.neighborMines;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> SaperModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IsRevealedRole] = "isRevealed";
    roles[IsFlaggedRole] = "isFlagged";
    roles[IsMineRole] = "isMine";
    roles[NeighborMinesRole] = "neighborMines";
    return roles;
}

void SaperModel::setGrid(int rows, int cols)
{
    m_rows = rows;
    m_cols = cols;
    qDebug() << "setGrid, rows: " << m_rows << ", cols: " << m_cols;
}
