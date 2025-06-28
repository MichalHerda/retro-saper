#ifndef SAPERMODEL_H
#define SAPERMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QMetaEnum>

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

    explicit SaperModel();

signals:
};

#endif // SAPERMODEL_H
