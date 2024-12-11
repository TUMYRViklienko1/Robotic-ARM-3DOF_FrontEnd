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

QString WidgetListDynmaic_cordsAuto::getData(int positionOfElement) const
{
    // autoAngles->at(positionOfElement)
    QStringList angleList {
        QString::number(autoAngles->at(positionOfElement).theta_1),
        QString::number(autoAngles->at(positionOfElement).theta_2), // Assuming theta_2 and others exist.
        QString::number(autoAngles->at(positionOfElement).theta_3),
        QString::number(autoAngles->at(positionOfElement).claw)
    };

    QString dataToSend = angleList.join(',');
    return dataToSend;
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

    if(countOfArray() < autoAngles->size())
    {
        setCountOfArray(++m_countOfArray);
        emit sendToSerialPort(autoAngles->at(i));
    }
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

int WidgetListDynmaic_cordsAuto::countOfArray() const
{
    return m_countOfArray;
}

void WidgetListDynmaic_cordsAuto::setCountOfArray(int newCountOfArray)
{
    if (m_countOfArray == newCountOfArray)
        return;
    m_countOfArray = newCountOfArray;
    emit countOfArrayChanged();
}

WidgetListDynmaic_cordsAuto *WidgetListDynmaic_cordsAuto::getReference()
{
    return this;
}

void WidgetListDynmaic_cordsAuto::deleteAllRows()
{
    int sizeOfArray = getSize();
    if(sizeOfArray){
        for (int i = 0; i <= sizeOfArray; ++i) {
            deleteRow(i);
        }
    }

}
