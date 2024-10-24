#include "WidgetListDynmaic_cordsAuto.h"
#include <qpainter.h>
#include <QDebug>
#include <QListWidget>

QVariant WidgetListDynmaic_cordsAuto::data(const QModelIndex &index, int role) const
{

    if (!checkIndex(index, CheckIndexOption::IndexIsValid))
    {
        return QVariant();
    }

    const int row = index.row();

    switch (role) {
    case Theta_1:
        return QString::number(autoAngles[row].data()->theta_1);
        break;
    case Theta_2:
        return QString::number(autoAngles[row].data()->theta_2);
        break;
    case Theta_3:
        return QString::number(autoAngles[row].data()->theta_3);
        break;
    case Step:
        return QString::number(autoAngles->size());
        break;
    default:
        return QVariant();
        break;
    }

}
void WidgetListDynmaic_cordsAuto::addRows(const SerialPort::angles &newAngles)
{
    qDebug()<< "--" <<autoAngles->size();

   beginInsertRows(QModelIndex(), 0,0);
   if(newAngles.theta_1 >= 0 && newAngles.theta_1 <= 180 &&
           newAngles.theta_2 >= 0 && newAngles.theta_2 <= 180 &&
           newAngles.theta_3 >= 0 && newAngles.theta_3 <= 180)
   {
       autoAngles->insert(autoAngles->begin(),newAngles);
   }
   endInsertRows();
}
