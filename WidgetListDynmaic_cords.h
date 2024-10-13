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
    //Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)


public:




    enum Role
    {
        Theta_1 = Qt::UserRole +1,
        Theta_2,
        Theta_3,
        Step
    };
    explicit WidgetListDynmaic_cords(QQuickItem* parent = nullptr, std::vector<SerialPort::angles>* = nullptr);
    void paint();
    // QAbstractItemModel interface
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void addRows(const SerialPort::angles &newAngles);

private:

    std::vector<SerialPort::angles>* forwardKinematicsData;

};

#endif // WIDGETLISTDYNMAIC_CORDS_H
