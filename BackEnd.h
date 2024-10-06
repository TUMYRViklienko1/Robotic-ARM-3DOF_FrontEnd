#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QSerialPort>
#include <QDialog>

class BackEnd : public QObject
{
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr);
    bool serialPortIsAvailable();
    qint64 writeToSerialPort(QString);
    ~BackEnd();
private:
    QSerialPort *arduino;

    static const quint16 arduino_uno_vendor_id = 9025;
    static const quint16 arduino_uno_product_id = 67;
    QString arduino_port_name;
    bool arduino_is_available;
signals:

};

#endif // BACKEND_H
