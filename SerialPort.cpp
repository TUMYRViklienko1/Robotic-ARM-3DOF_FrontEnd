#include "SerialPort.h"

#include <QMessageBox>

SerialPort::SerialPort(QObject *parent)
    : QObject{parent},
      m_forwardAngles(90,90,90)
{
    if(!_portConector.serialPortIsAvailable()){
        qDebug() << "Error serial port Coudn't find the arduino";
    }


}


void SerialPort::writeToSerialPort(){
    qDebug()<< listAngles.back().theta_1;
    qDebug()<< listAngles.back().theta_2;
    qDebug()<< listAngles.back().theta_3;
    _portConector.writeToSerialPort(QString::number(listAngles.back().theta_1) + 'b');
    _portConector.writeToSerialPort(QString::number(listAngles.back().theta_2) + 's');
    _portConector.writeToSerialPort(QString::number(listAngles.back().theta_3) + 'e');

}


// void SerialPort::build()
// {

// }


SerialPort::angles::angles(int t1, int t2, int t3)
    : theta_1(t1),
      theta_2(t2),
      theta_3(t3) {
}

bool SerialPort::angles::operator==(const angles &newAngles)
{
    if(this->theta_1 == newAngles.theta_1 && this->theta_2 == newAngles.theta_2 && this->theta_3 == newAngles.theta_3)
        return true;
    return false;
}

SerialPort::angles SerialPort::forwardAngles() const
{
    return m_forwardAngles;
}

void SerialPort::setForwardAngles(const angles &newForwardAngles)
{
     qDebug()<< "$" << m_forwardAngles.theta_1;
     qDebug()<< "$" << m_forwardAngles.theta_2;
     qDebug()<< "$" << m_forwardAngles.theta_3;

    if (m_forwardAngles == newForwardAngles)
        return;
    m_forwardAngles = newForwardAngles;

    listAngles.push_back(m_forwardAngles);

    emit forwardAnglesChanged();
}

void SerialPort::setToStructAngles(int inputTheta_1 , int inputTheta_2, int inputTheta_3)
{

    // if (inputTheta_1 == 0) {
    //     inputTheta_1 = listAngles.data()->theta_1;
    // }
    // if (inputTheta_2 == 0) {
    //     inputTheta_2 = listAngles.data()->theta_2;
    // }
    // if (inputTheta_3 == 0) {
    //     inputTheta_3 = listAngles.data()->theta_3;
    // }


    if (valid_angles( inputTheta_1,  inputTheta_2,  inputTheta_3) != 1)
        throw std::invalid_argument("Error: Invalid angle values.");
    angles newAngle(inputTheta_1,inputTheta_2,inputTheta_3);
    setForwardAngles(newAngle);
}

bool SerialPort::valid_angles(int inputTheta_1, int inputTheta_2, int inputTheta_3) const
{
    return (inputTheta_1 >= 0 && inputTheta_1 <= 180 &&
            inputTheta_2 >= 0 && inputTheta_2 <= 180 &&
            inputTheta_3 >= 0 && inputTheta_3 <= 180);
}
