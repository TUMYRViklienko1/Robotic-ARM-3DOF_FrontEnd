#ifndef INVERSEKINEMATICS_H
#define INVERSEKINEMATICS_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QDebug>
#include "SerialPort.h"
#define DOF 3
struct cords
{
    int _xCords, _yCords, _zCords;
    cords(QString _xCords, QString _yCords, QString _zCords);
    cords():_xCords(1),_yCords(1),_zCords(1){};
    bool operator==(const cords &newStruct) const;
};

Q_DECLARE_METATYPE(cords)

class InverseKinematics : public QObject
{
    Q_OBJECT
    Q_PROPERTY(cords inverseCords READ inverseCords WRITE setInverseCords NOTIFY inverseCordsChanged FINAL)
public:
    explicit InverseKinematics(QObject *parent = nullptr);



    cords inverseCords() const;

public slots:
    void setInverseCords(cords newInverseCords);
    QVariantList inverseCalculator();



signals:
    void inverseCordsChanged();
    void inverseCordsCalulated(const SerialPort::angles& newAngles);

private:
    cords m_inverseCords;
    double length_base, length_shoulder, length_elbow;
    double angle_inverse[DOF];
};

#endif // INVERSEKINEMATICS_H
