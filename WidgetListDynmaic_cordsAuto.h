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
    Q_PROPERTY(int countOfArray READ countOfArray WRITE setCountOfArray NOTIFY countOfArrayChanged FINAL)

public:
    explicit WidgetListDynmaic_cordsAuto(QQuickItem* parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    QString getData(int positionOfElement) const;
    int countOfArray() const;
    void deleteAllRows();

public slots:
    void addRows(const SerialPort::angles &newAngles) override;
    void deleteRow(int row);
    QVariantList startAutoMode(int i);
    int getSize();
    void setCountOfArray(int newCountOfArray);
    WidgetListDynmaic_cordsAuto* getReference();
signals:
    void sendToSerialPort(const SerialPort::angles &newAngles);

    void countOfArrayChanged();

private:

    std::vector<SerialPort::angles>* autoAngles;
    QTimer* debounceTimer;

    int m_countOfArray;
};

#endif // WIDGETLISTDYNMAIC_CORDSAUTO_H
