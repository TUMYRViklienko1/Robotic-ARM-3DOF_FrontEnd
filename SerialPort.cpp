#include "SerialPort.h"

#include <QMessageBox>

SerialPort::SerialPort(QObject *parent)
    : QObject{parent}{
    if(!_portConector.serialPortIsAvailable()){
        qDebug() << "Error serial port Coudn't find the arduino";
    }
}

int SerialPort::theta_1() const
{
    return m_theta_1;
}

void SerialPort::setTheta_1(int newTheta_1)
{
    if (m_theta_1 == newTheta_1)
        return;
    m_theta_1 = newTheta_1;
    emit theta_1Changed(1,newTheta_1);
}

int SerialPort::theta_2() const
{
    return m_theta_2;
}

void SerialPort::setTheta_2(int newTheta_2)
{
    if (m_theta_2 == newTheta_2)
        return;
    m_theta_2 = newTheta_2;
    emit theta_2Changed(2,newTheta_2);




}

int SerialPort::theta_3() const
{
    return m_theta_3;
}

void SerialPort::setTheta_3(int newTheta_3)
{
    if (m_theta_3 == newTheta_3)
        return;
    m_theta_3 = newTheta_3;
    emit theta_3Changed(3,newTheta_3);
}

void SerialPort::writeToSerialPort(const int id, const int newTheta)
{

    QString whaistToString = QString::number(newTheta);
    switch (id) {
    case 1:
         whaistToString += 'b';
        _portConector.writeToSerialPort(whaistToString);
        qDebug() << whaistToString;
        break;
    case 2:
        whaistToString += 's';
        _portConector.writeToSerialPort(whaistToString);
        qDebug() << whaistToString;
        break;
    case 3:
        whaistToString += 'e';
        _portConector.writeToSerialPort(whaistToString);
        qDebug() << whaistToString;
        break;

    default:
        break;
    }
}

// void SerialPort::build()
// {

// }

