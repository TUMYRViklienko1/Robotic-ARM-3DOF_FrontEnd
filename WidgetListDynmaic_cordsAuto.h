#ifndef WIDGETLISTDYNMAIC_CORDSAUTO_H
#define WIDGETLISTDYNMAIC_CORDSAUTO_H

#include <QQuickPaintedItem>
#include <QQmlEngine>
#include <QListWidget>
#include "SerialPort.h"
#include "WidgetListDynmaic_cords.h"
#include <QTimer>
class WidgetListDynmaic_cordsAuto : public WidgetListDynmaic_cords
{
    Q_OBJECT
    QML_ELEMENT


public:
    explicit WidgetListDynmaic_cordsAuto(QQuickItem* parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;

public slots:
    void addRows(const SerialPort::angles &newAngles) override;
    void deleteRow(int row);
    QVariantList startAutoMode(int i);
    int getSize();

signals:
    void sendToSerialPort(const SerialPort::angles &newAngles);

private:
    std::vector<SerialPort::angles>* autoAngles;
    QTimer* debounceTimer;

};

#endif // WIDGETLISTDYNMAIC_CORDSAUTO_H
