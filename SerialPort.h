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

    Q_PROPERTY(angles forwardAngles READ forwardAngles WRITE setForwardAngles NOTIFY forwardAnglesChanged FINAL)
public:
    explicit SerialPort(QObject *parent = nullptr);

    int theta_1() const;


    int theta_2() const;



    int theta_3() const;


    struct angles
    {
        int theta_1;
        int theta_2;
        int theta_3;
        // Constructor to initialize angles
        angles(int t1, int t2, int t3);
        bool operator== (const angles& newAngles);
    };

    angles forwardAngles() const;
    void setForwardAngles(const angles &newForwardAngles);
    void setToStructAngles(int inputTheta_1 =-1, int inputTheta_2 =-1, int inputTheta_3 =-1);

public slots:
    void setTheta_1(int newTheta_1);
    void setTheta_2(int newTheta_2);
    void setTheta_3(int newTheta_3);


    void writeToSerialPort(int id, int newTheta);
    void writeToSerialPort();


signals:
    void theta_1Changed(int id, int newTheta);
    void theta_2Changed(int id, int newTheta);
    void theta_3Changed(int id, int newTheta);

    void forwardAnglesChanged();

private:
    bool valid_angles(int inputTheta_1, int inputTheta_2, int inputTheta_3) const;
    std::vector<angles> listAngles;
    int m_theta_1;
    int m_theta_2;
    int m_theta_3;
    BackEnd _portConector;
    angles m_forwardAngles;
};

#endif // SERIALPORT_H
