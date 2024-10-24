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
    case Step:
        return QString::number(forwardKinematicsData->size());
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
    result[Step] = "step";
    return result;
}


 void WidgetListDynmaic_cords::addRows(const SerialPort::angles &newAngles)
{
     qDebug()<< "--" <<forwardKinematicsData->size();

    beginInsertRows(QModelIndex(), 0,0);
    if(newAngles.theta_1 >= 0 && newAngles.theta_1 <= 180 &&
            newAngles.theta_2 >= 0 && newAngles.theta_2 <= 180 &&
            newAngles.theta_3 >= 0 && newAngles.theta_3 <= 180)
    {
        forwardKinematicsData->insert(forwardKinematicsData->begin(),newAngles);
    }
    endInsertRows();
}

 void WidgetListDynmaic_cords::duplicateData(int row)
 {
    if(row < 0 || row >=forwardKinematicsData->size()){
        return;
    }

    SerialPort::angles *anglesFromList = forwardKinematicsData[row].data();

    emit anglesToAuto(*anglesFromList);
    // beginInsertColumns(QModelIndex(), rowOfInsert, rowOfInsert);

    // autoAngles->insert(forwardKinematicsData->begin(), *anglesFromList);
    // endInsertRows();
 }


