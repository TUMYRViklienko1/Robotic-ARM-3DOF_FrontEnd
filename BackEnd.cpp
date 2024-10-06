#include "BackEnd.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QMessageBox>
#include <QWidget>
bool BackEnd::serialPortIsAvailable(){
    qDebug() << "Number of available ports:" << QSerialPortInfo::availablePorts().length();
    foreach (const QSerialPortInfo &serialPortInfo,QSerialPortInfo::availablePorts() ) {
        qDebug() << "Has vendor ID: " << serialPortInfo.hasVendorIdentifier();
        if(serialPortInfo.hasVendorIdentifier()){
            qDebug() << "Vendor ID: " << serialPortInfo.vendorIdentifier();
        }
        qDebug() << "Has product ID: " << serialPortInfo.hasProductIdentifier();
        if(serialPortInfo.hasVendorIdentifier()){
            qDebug() << "Product ID: " << serialPortInfo.productIdentifier();
        }
    }

    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier()){
            if(serialPortInfo.vendorIdentifier() == arduino_uno_vendor_id && serialPortInfo.productIdentifier() == arduino_uno_product_id){
                arduino_port_name = serialPortInfo.portName();
                arduino_is_available = true;
                return true;
            }
        }

    }

    return false;
}

BackEnd::BackEnd(QObject *parent) : QObject(parent)
{
    arduino_is_available = false;
    arduino_port_name = "";
    arduino = new QSerialPort;

    if(serialPortIsAvailable()){
        // opean and configure the port
        arduino->setPortName(arduino_port_name);
        arduino->open(QSerialPort::WriteOnly);
        arduino->setBaudRate(QSerialPort::Baud9600);
        arduino->setDataBits(QSerialPort::Data8);
        arduino->setParity(QSerialPort::NoParity);
        arduino->setStopBits(QSerialPort::OneStop);
        arduino->setFlowControl(QSerialPort::NoFlowControl);
    }


}
qint64 BackEnd::writeToSerialPort(QString data){
    if(arduino->isWritable()){
        return arduino->write(data.toStdString().c_str());
    }
    else{
        qDebug() << "Couldn't write to serial";
        return -1;
    }
}

BackEnd::~BackEnd(){
    if(arduino->isOpen()){
        arduino->close();
    }
}

