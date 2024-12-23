#include "WidgetListDynmaic_cordsAuto.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>
#include <QThread>
WidgetListDynmaic_cordsAuto::WidgetListDynmaic_cordsAuto(QQuickItem *parent)
    : WidgetListDynmaic_cords(parent)
{
    autoAngles = new std::vector<SerialPort::angles>;
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
    case Claw:
        return QString::number(angles.claw);
    case Step:
        return QString::number(autoAngles->size()-1);
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

void WidgetListDynmaic_cordsAuto::deleteRow(int row)
{
    beginRemoveRows(QModelIndex(), 0, 0);
    if(autoAngles->size() >= row && 0 <= row){
        autoAngles->erase(autoAngles->begin() + row);
    }
    endRemoveRows();
}

QVariantList WidgetListDynmaic_cordsAuto::startAutoMode(int i)
{

    emit sendToSerialPort(autoAngles->at(i));
    return QVariantList() << QVariant(autoAngles->at(i).theta_1)
                          << QVariant(autoAngles->at(i).theta_2)
                          << QVariant(autoAngles->at(i).theta_3)
                          << QVariant(autoAngles->at(i).claw);

}

int WidgetListDynmaic_cordsAuto::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return autoAngles->size();
    }
    return 0;
}

int WidgetListDynmaic_cordsAuto::getSize()
{
 return autoAngles->size();
}
