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
        Theta_1 = Qt::UserRole +1,
        Theta_2,
        Theta_3,
        Step
    };
    explicit WidgetListDynmaic_cords(QQuickItem* parent = nullptr, std::vector<SerialPort::angles>* = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
signals:
    void anglesToAuto(const SerialPort::angles& toAutoList);
public slots:
    virtual void addRows(const SerialPort::angles& newAngles);
    void duplicateData(int row);
private:

    std::vector<SerialPort::angles>* forwardKinematicsData;

    // QAbstractItemModel interface
};

#endif // WIDGETLISTDYNMAIC_CORDS_H
