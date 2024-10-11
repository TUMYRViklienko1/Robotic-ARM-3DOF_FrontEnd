#include "WidgetListDynmaic_cords.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>
WidgetListDynmaic_cords::WidgetListDynmaic_cords(QQuickItem* parent, std::vector<SerialPort::angles>* anglesVector)
    : QAbstractListModel(parent)
{
    list = QColor::colorNames();
}



int WidgetListDynmaic_cords::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return list.size();
    }
    return 0;
}

QVariant WidgetListDynmaic_cords::data(const QModelIndex &index, int role) const
{
    // if(index.isValid() && index.row() >=0 && index.row() < m_cordsList.length()){
    //     SerialPort* forwadAngles = m_cordsList[index.row()];


    // }
    if(role != Qt::DisplayRole)
    {
        return QVariant();
    }
    const int row = index.row();
    const QString result = list[row];


    switch (role) {
    case Qt::DisplayRole:
        return result;
        break;
    case Qt::DecorationRole:
        return QVariant::fromValue(QColor(result));
        break;
    default:
        return QVariant();
        break;
    }
}


QHash<int, QByteArray> WidgetListDynmaic_cords::roleNames() const
{
    QHash<int, QByteArray> result;
    result[Qt::DisplayRole] = "display";
    return result;
}

// QColor WidgetListDynmaic_cords::color() const
// {
//     return m_color;
// }
// void WidgetListDynmaic_cords::setColor(const QColor& newColor){
//     if (m_color == newColor)
//         return;
//     m_color = newColor;
//     update();
//     emit colorChanged();
// }

