#ifndef WIDGETLISTDYNMAIC_CORDSAUTO_H
#define WIDGETLISTDYNMAIC_CORDSAUTO_H

#include <QQuickPaintedItem>
#include <QQmlEngine>
#include <QListWidget>
#include "SerialPort.h"
#include "WidgetListDynmaic_cords.h"
class WidgetListDynmaic_cordsAuto : public WidgetListDynmaic_cords
{
    Q_OBJECT
    QML_ELEMENT


public:

    explicit WidgetListDynmaic_cordsAuto(QQuickItem* parent = nullptr)  : WidgetListDynmaic_cords(parent){};
    virtual QVariant data(const QModelIndex &index, int role) const override;
public slots:
    void addRows(const SerialPort::angles &newAngles);

private:
    std::vector<SerialPort::angles>* autoAngles;

};

#endif // WIDGETLISTDYNMAIC_CORDS_H
