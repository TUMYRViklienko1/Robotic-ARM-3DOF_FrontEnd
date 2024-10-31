#include "WidgetListDynmaic_cordsAuto.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>

WidgetListDynmaic_cordsAuto::WidgetListDynmaic_cordsAuto(QQuickItem *parent)
    : WidgetListDynmaic_cords(parent), m_delayAuto(1000), m_autoModeIsRunning(true)
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

void WidgetListDynmaic_cordsAuto::startAutoMode(float delay)
{

    while (autoModeIsRunning()) {
        for (int i = 0; i < autoAngles->size(); ++i) {
             qDebug() << autoAngles->at(i).theta_1;
            QEventLoop loop;
            QTimer::singleShot(delay, &loop, SLOT(quit()));
            loop.exec();
        }
    }
}


int WidgetListDynmaic_cordsAuto::rowCount(const QModelIndex &parent) const
{
    if(!parent.isValid())
    {
        return autoAngles->size();
    }
    return 0;
}



bool WidgetListDynmaic_cordsAuto::autoModeIsRunning() const
{
    return m_autoModeIsRunning;
}

void WidgetListDynmaic_cordsAuto::setAutoModeIsRunning(bool newAutoModeIsRunning)
{
    if (m_autoModeIsRunning == newAutoModeIsRunning)
        return;
    m_autoModeIsRunning = newAutoModeIsRunning;
    emit autoModeIsRunningChanged();
}

float WidgetListDynmaic_cordsAuto::delayAuto() const
{
    return m_delayAuto;
}

void WidgetListDynmaic_cordsAuto::setDelayAuto(float newDelayAuto)
{
    if (qFuzzyCompare(m_delayAuto, newDelayAuto))
        return;
    m_delayAuto = newDelayAuto;
    debounceTimer->setInterval(m_delayAuto);
    emit delayAutoChanged();
}
