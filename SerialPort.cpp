#include "SerialPort.h"

#include <QMessageBox>
SerialPort::SerialPort(QObject *parent)
    : QObject{parent},
      m_forwardAngles(90,90,90, 1)
{
    QObject::connect(this, &SerialPort::forwardAnglesChanged, this, &SerialPort::writeToSerialPort);

    if(!_portConector.serialPortIsAvailable()){
        qDebug() << "Error serial port Coudn't find the arduino";
    }
    listAngles.push_back(m_forwardAngles);

}


void SerialPort::writeToSerialPort(){
    qDebug()<< listAngles.begin()->theta_1;
    qDebug()<< listAngles.begin()->theta_2;
    qDebug()<< listAngles.begin()->theta_3;
    qDebug()<< listAngles.begin()->claw;
    _portConector.writeToSerialPort(QString::number(listAngles.begin()->theta_1) + 'b');
    _portConector.writeToSerialPort(QString::number(listAngles.begin()->theta_2) + 's');
    _portConector.writeToSerialPort(QString::number(listAngles.begin()->theta_3) + 'e');
    _portConector.writeToSerialPort(QString::number(listAngles.begin()->claw) + 'c');

}


// void SerialPort::build()
// {

// }


SerialPort::angles::angles(int t1, int t2, int t3, bool claw)
    : theta_1(t1),
      theta_2(t2),
      theta_3(t3),
      claw(claw) {
}

SerialPort::angles::angles(const angles &orign)
{
    this->theta_1 = orign.theta_1;
    this->theta_2 = orign.theta_2;
    this->theta_3 = orign.theta_3;
    this->claw = orign.claw;
}

bool SerialPort::angles::operator==(const angles &newAngles)
{
    if(this->theta_1 == newAngles.theta_1 && this->theta_2 == newAngles.theta_2
            && this->theta_3 == newAngles.theta_3 && this->claw == newAngles.claw)
        return true;
    return false;
}




SerialPort::angles SerialPort::forwardAngles() const
{
    return m_forwardAngles;
}

void SerialPort::setForwardAngles(const angles &newForwardAngles)
{
    if (valid_angles( newForwardAngles.theta_1,  newForwardAngles.theta_2,  newForwardAngles.theta_3) != 1)
        throw std::invalid_argument("Error: Invalid angle values.");
    qDebug()<< "$" << m_forwardAngles.theta_1;
    qDebug()<< "$" << m_forwardAngles.theta_2;
    qDebug()<< "$" << m_forwardAngles.theta_3;
    qDebug()<< "$" << m_forwardAngles.claw;

    if (m_forwardAngles == newForwardAngles)
        return;
    m_forwardAngles = newForwardAngles;
    emit modifyDataModel(m_forwardAngles);
    emit forwardAnglesChanged();
}


bool SerialPort::valid_angles(int inputTheta_1, int inputTheta_2, int inputTheta_3) const
{
    return (inputTheta_1 >= 0 && inputTheta_1 <= 180 &&
            inputTheta_2 >= 0 && inputTheta_2 <= 180 &&
            inputTheta_3 >= 0 && inputTheta_3 <= 180);
}
