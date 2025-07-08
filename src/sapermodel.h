#ifndef SAPERMODEL_H
#define SAPERMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QMetaEnum>
#include <random>
#include <algorithm>
#include <queue>


struct CellData {
    bool isRevealed = false;
    bool isFlagged = false;
    bool isMine = false;
    int neighborMines = 0;
};

class SaperModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    enum SaperRoles {
        IsRevealedRole = Qt::UserRole + 1,
        IsFlaggedRole,
        IsMineRole,
        NeighborMinesRole
    };
    Q_ENUM(SaperRoles)

    explicit SaperModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    QHash<int, QByteArray> roleNames() const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    void setGrid(int rows, int cols);
    void setBombsNo(int bombs);
    int getBombsNo();
    void placeBombsRandomly(int bombsNo, int safeRow, int safeCol);

    void revealCell(int row, int col);
    void setFlagged(int row, int col, bool flagged);
    void resetRevealed();
    bool checkForWin();
    bool checkForLose();

signals:

private:
    int m_rows = 8;
    int m_cols = 8;
    int m_bombs = 3;
    QList<QList<CellData>> m_grid;

    int countNeighborBombs(int row, int col) const;
    void updateAllNeighborCounts();
    bool isValidCell(int row, int col) const;
};

#endif // SAPERMODEL_H
