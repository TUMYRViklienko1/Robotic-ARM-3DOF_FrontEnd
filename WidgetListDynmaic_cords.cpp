#include "WidgetListDynmaic_cords.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>
WidgetListDynmaic_cords::WidgetListDynmaic_cords(QQuickItem* parent, std::vector<SerialPort::angles>* anglesVector)
    : QAbstractListModel(parent)
{
    //list = QColor::colorNames();

    forwardKinematicsData = anglesVector;
}



int WidgetListDynmaic_cords::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return forwardKinematicsData->size();
    }
    return 0;
}

QVariant WidgetListDynmaic_cords::data(const QModelIndex &index, int role) const
{

    if (!checkIndex(index, CheckIndexOption::IndexIsValid))
    {
        return QVariant();
    }

    const int row = index.row();

    switch (role) {
    case Theta_1:
        return QString::number(forwardKinematicsData[row].data()->theta_1);
        break;
    case Theta_2:
        return QString::number(forwardKinematicsData[row].data()->theta_2);
        break;
    case Theta_3:
        return QString::number(forwardKinematicsData[row].data()->theta_3);
        break;
    default:
        return QVariant();
        break;
    }
}


QHash<int, QByteArray> WidgetListDynmaic_cords::roleNames() const
{
    QHash<int, QByteArray> result;
    result[Theta_1] = "theta_1";
    result[Theta_2] = "theta_2";
    result[Theta_3] = "theta_3";
    return result;
}


 void WidgetListDynmaic_cords::addRows(const SerialPort::angles &newAngles)
{
     qDebug()<< "--" <<forwardKinematicsData->size();

    beginInsertRows(QModelIndex(), 0,0);
        forwardKinematicsData->insert(forwardKinematicsData->begin(),newAngles);
    endInsertRows();
}


