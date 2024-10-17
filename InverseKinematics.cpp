#include "InverseKinematics.h"

#include <qvariant.h>

InverseKinematics::InverseKinematics(QObject *parent)
    : QObject{parent},
      length_base(0.86),
      length_shoulder(0.76),
      length_elbow(1.03),
      m_inverseCords("0", "0", "0")
{
    QObject::connect(this, &InverseKinematics::inverseCordsChanged, this, &InverseKinematics::inverseCalculator);

}
cords InverseKinematics::inverseCords() const
{
    return m_inverseCords;
}


void InverseKinematics::setInverseCords(cords newInverseCords)
{
    qDebug() << "x:" << newInverseCords._xCords;
    qDebug() << "y:" << newInverseCords._yCords;
    qDebug() << "z:" << newInverseCords._zCords;

    if (m_inverseCords == newInverseCords)
        return;
    m_inverseCords = newInverseCords;
    emit inverseCordsChanged();
}

cords::cords(QString _xCords, QString _yCords, QString _zCords)
{
    bool flag;
    int cordsToInt[DOF];
    QString test[DOF] = {_xCords, _yCords, _zCords};

    for (int i = 0; i < DOF; ++i)
    {
        cordsToInt[i] = test[i].toInt(&flag);
        if (!flag)
        {
            qDebug() << "Invalid coordinate provided at index: " << i;
            _xCords = _yCords = _zCords = 0;  // Set default values to avoid uninitialized state
            return;
        }
    }

    this->_xCords = cordsToInt[0];
    this->_yCords = cordsToInt[1];
    this->_zCords = cordsToInt[2];
}

bool cords::operator==(const cords &newStruct) const
{
    return _xCords == newStruct._xCords &&
           _yCords == newStruct._yCords &&
           _zCords == newStruct._zCords;
}

QVariantList InverseKinematics::inverseCalculator()
{
    const double PI = 3.14159265358979323846;
    auto length = qSqrt(qPow(m_inverseCords._xCords, 2) + qPow(m_inverseCords._yCords, 2));

    if (length == 0)
    {
        qDebug() << "Calculation Error: invalid coordinate length.";
    }

    angle_inverse[0] = (180 * qAsin(m_inverseCords._yCords / length)) / PI;

    double l3 = qPow(length, 2) + qPow(length_base - m_inverseCords._zCords, 2);
    double cosValue = (qPow(length_shoulder, 2) + qPow(length_elbow, 2) - l3) / (2 * length_shoulder * length_elbow);

    if (cosValue < -1 || cosValue > 1)
    {
        qDebug() << "Calculation Error: Invalid values for arccos function.";
    }

    angle_inverse[1] = 180 - (180 * qAcos(cosValue) / PI);

    double atanValue1 = qAtan(length / m_inverseCords._zCords);
    double atanValue2 = qAtan((length_elbow * qSin(angle_inverse[1] * PI / 180)) /
                              (length_shoulder + length_elbow * qCos(angle_inverse[1] * PI / 180)));
    angle_inverse[2] = (180 * (atanValue1 - atanValue2)) / PI;

    qDebug() << "theta_1:" << angle_inverse[0];
    qDebug() << "theta_2:" << angle_inverse[1];
    qDebug() << "theta_3:" << angle_inverse[2];

    // angle_inverse[0] += 90;
    // angle_inverse[1] += 90;
    // angle_inverse[2] += 90;
    SerialPort::angles newAngles(angle_inverse[0],angle_inverse[1],angle_inverse[2]);
    emit inverseCordsCalulated( newAngles);

    return QVariantList() << QVariant(angle_inverse[0]) << QVariant(angle_inverse[1]) << QVariant(angle_inverse[2]);
}
