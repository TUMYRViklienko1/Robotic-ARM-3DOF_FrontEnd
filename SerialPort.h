#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <qqmlintegration.h>
#include "BackEnd.h"
class SerialPort : public QObject
{
    Q_OBJECT

    Q_PROPERTY(angles forwardAngles READ forwardAngles WRITE setForwardAngles NOTIFY forwardAnglesChanged FINAL)
public:
    explicit SerialPort(QObject *parent = nullptr);

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

public slots:
    void writeToSerialPort();
    void setForwardAngles(const angles &newForwardAngles);
    void setToStructAngles(int inputTheta_1 =-1, int inputTheta_2 =-1, int inputTheta_3 =-1);

signals:
    void forwardAnglesChanged();
private:
    bool valid_angles(int inputTheta_1, int inputTheta_2, int inputTheta_3) const;
    std::vector<angles> listAngles;
    BackEnd _portConector;
    angles m_forwardAngles;
};

#endif // SERIALPORT_H