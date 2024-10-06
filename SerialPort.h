#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <qqmlintegration.h>
#include "BackEnd.h"
class SerialPort : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int theta_1 READ theta_1 WRITE setTheta_1 NOTIFY theta_1Changed FINAL)
    Q_PROPERTY(int theta_2 READ theta_2 WRITE setTheta_2 NOTIFY theta_2Changed FINAL)
    Q_PROPERTY(int theta_3 READ theta_3 WRITE setTheta_3 NOTIFY theta_3Changed FINAL)

public:
    explicit SerialPort(QObject *parent = nullptr);

    int theta_1() const;


    int theta_2() const;



    int theta_3() const;


public slots:
    void setTheta_1(int newTheta_1);
    void setTheta_2(int newTheta_2);
    void setTheta_3(int newTheta_3);


    void writeToSerialPort(int id, int newTheta);

signals:
    void theta_1Changed(int id, int newTheta);
    void theta_2Changed(int id, int newTheta);
    void theta_3Changed(int id, int newTheta);

private:
    int m_theta_1;
    int m_theta_2;
    int m_theta_3;
    BackEnd _portConector;
};

#endif // SERIALPORT_H
