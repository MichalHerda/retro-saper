#include "sapermodel.h"

SaperModel::SaperModel(QObject *parent)
    : QAbstractTableModel(parent)
{

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
    //beginResetModel();

    m_rows = rows;
    m_cols = cols;
    qDebug() << "setGrid, rows: " << m_rows << ", cols: " << m_cols;

    m_grid.clear();
    m_grid.resize(m_rows);
    for (int r = 0; r < m_rows; ++r) {
        m_grid[r].resize(m_cols);
    }

    //endResetModel();
}

void SaperModel::setBombsNo(int bombs)
{
    m_bombs = bombs;
    qDebug() << "setBombsNo, bombs: " << m_bombs;
}

int SaperModel::getBombsNo()
{
    return m_bombs;
}

void SaperModel::placeBombsRandomly(int bombsNo)
{
    //beginResetModel();

    setGrid(m_rows, m_cols);
    // Tworzymy płaską listę wszystkich możliwych pozycji
    std::vector<std::pair<int, int>> positions;
    for (int r = 0; r < m_rows; ++r) {
        for (int c = 0; c < m_cols; ++c) {
            positions.emplace_back(r, c);
        }
    }

    // Tasujemy pozycje
    std::random_device rd;
    std::mt19937 gen(rd());
    std::shuffle(positions.begin(), positions.end(), gen);

    // Wybieramy bombCount pierwszych pól
    for (int i = 0; i < bombsNo && i < static_cast<int>(positions.size()); ++i) {
        int r = positions[i].first;
        int c = positions[i].second;
        m_grid[r][c].isMine = true;
    }

    // Obliczamy liczbę sąsiednich bomb dla każdej komórki
    for (int r = 0; r < m_rows; ++r) {
        for (int c = 0; c < m_cols; ++c) {
            if (!m_grid[r][c].isMine) {
                //m_grid[r][c].neighborMines = countNeighborBombs(r, c);
            }
        }
    }

    //endResetModel();
}
