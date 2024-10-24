#include "WidgetListDynmaic_cordsAuto.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>

WidgetListDynmaic_cordsAuto::WidgetListDynmaic_cordsAuto(QQuickItem *parent)
    : WidgetListDynmaic_cords(parent)
{
    autoAngles = new std::vector<SerialPort::angles>;
    // SerialPort::angles newAngles(90,95,90);
    // autoAngles->push_back(newAngles) ;
}

QVariant WidgetListDynmaic_cordsAuto::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, CheckIndexOption::IndexIsValid))
    {
        return QVariant();
    }

    const int row = index.row();
    const auto& angles = autoAngles->at(row);  // Access the angles directly

    switch (role) {
    case Theta_1:
        return QString::number(angles.theta_1);
    case Theta_2:
        return QString::number(angles.theta_2);
    case Theta_3:
        return QString::number(angles.theta_3);
    case Step:
        return QString::number(autoAngles->size());
    default:
        return QVariant();
    }
}

void WidgetListDynmaic_cordsAuto::addRows(const SerialPort::angles &newAngles)
{
    beginInsertRows(QModelIndex(), 0, 0);
    if(newAngles.theta_1 >= 0 && newAngles.theta_1 <= 180 &&
       newAngles.theta_2 >= 0 && newAngles.theta_2 <= 180 &&
       newAngles.theta_3 >= 0 && newAngles.theta_3 <= 180)
    {
        autoAngles->insert(autoAngles->begin(), newAngles);
    }
    endInsertRows();
}


int WidgetListDynmaic_cordsAuto::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return autoAngles->size();
    }
    return 0;
}


