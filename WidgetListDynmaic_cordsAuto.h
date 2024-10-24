#ifndef WIDGETLISTDYNMAIC_CORDSAUTO_H
#define WIDGETLISTDYNMAIC_CORDSAUTO_H

#include <QQuickPaintedItem>
#include <QQmlEngine>
#include <QListWidget>
#include "SerialPort.h"
class WidgetListDynmaic_cordsAuto : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT


public:
    enum Role
    {
        Theta_1 = Qt::UserRole +1,
        Theta_2,
        Theta_3,
        Step
    };
    explicit WidgetListDynmaic_cordsAuto(QQuickItem* parent = nullptr, std::vector<SerialPort::angles>* = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;public slots:
    void addRows(const SerialPort::angles &newAngles);

private:
    std::vector<SerialPort::angles>* autoAngles;

};

#endif // WIDGETLISTDYNMAIC_CORDSAUTO_H
