#ifndef WIDGETLISTDYNMAIC_CORDS_H
#define WIDGETLISTDYNMAIC_CORDS_H

#include <QQuickPaintedItem>
#include <QQmlEngine>
#include <QListWidget>
#include "SerialPort.h"
class WidgetListDynmaic_cords : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT


public:
    enum Role
    {
        Theta_1 = Qt::UserRole,
        Theta_2,
        Theta_3,
        Step,
        Claw
    };
    explicit WidgetListDynmaic_cords(QQuickItem* parent = nullptr, std::vector<SerialPort::angles>* = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
signals:
    void anglesToAuto(const SerialPort::angles& toAutoList);
public slots:
    virtual void addRows(const SerialPort::angles& newAngles);
    void duplicateData(int row);
private:

    std::vector<SerialPort::angles>* forwardKinematicsData;

    // QAbstractItemModel interface

    // QAbstractItemModel interface
};

#endif // WIDGETLISTDYNMAIC_CORDS_H
