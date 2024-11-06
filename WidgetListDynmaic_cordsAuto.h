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
    Q_PROPERTY(bool autoModeIsRunning READ autoModeIsRunning WRITE setAutoModeIsRunning NOTIFY autoModeIsRunningChanged FINAL)
    Q_PROPERTY(float delayAuto READ delayAuto WRITE setDelayAuto NOTIFY delayAutoChanged FINAL)
    Q_OBJECT
    QML_ELEMENT


public:
    explicit WidgetListDynmaic_cordsAuto(QQuickItem* parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    bool autoModeIsRunning() const;
    void setAutoModeIsRunning(bool newAutoModeIsRunning);

    float delayAuto() const;

public slots:
    void addRows(const SerialPort::angles &newAngles) override;
    void deleteRow(int row);
    QVariantList startAutoMode(int i);
    void setDelayAuto(float newDelayAuto);
    int getSize();
    void delay(int delayTimer);
signals:
    void autoModeIsRunningChanged();
    void sendToSerialPort(const SerialPort::angles &newAngles);
    void delayAutoChanged();

private:
    std::vector<SerialPort::angles>* autoAngles;
    QTimer* debounceTimer;
    bool m_autoModeIsRunning;
    float m_delayAuto;
};

#endif // WIDGETLISTDYNMAIC_CORDSAUTO_H
