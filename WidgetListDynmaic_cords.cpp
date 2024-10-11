#include "WidgetListDynmaic_cords.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>
WidgetListDynmaic_cords::WidgetListDynmaic_cords(QQuickItem* parent, std::vector<SerialPort::angles>* anglesVector)
    : QAbstractListModel(parent)
{
    m_forwardCords = anglesVector;
}



int WidgetListDynmaic_cords::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return m_forwardCords->size();
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
    const QString result = QString::number( m_forwardCords[row].data()->theta_1 + 'w');

    return result;
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

