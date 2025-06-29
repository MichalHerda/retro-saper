#ifndef SAPERMODEL_H
#define SAPERMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QMetaEnum>

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
    QHash<int, QByteArray> roleNames() const override;
signals:

private:
    int m_rows = 10;
    int m_cols = 10;
    QList<QList<CellData>> m_grid;
};

#endif // SAPERMODEL_H
