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
        bool claw = 1; // 1 - is opean
        // Constructor to initialize angles
        angles(int t1, int t2, int t3, bool claw);
        angles(const angles& orign);
        bool operator== (const angles& newAngles);
    };

    angles forwardAngles() const;
    std::vector<angles>* getVector()
    {
        return &listAngles;
    }
public slots:
    void setForwardAngles(const angles &newForwardAngles);
    void autoMode(float interwalStep);
private slots:
    void writeToSerialPort();

signals:
    void forwardAnglesChanged();
    void modifyDataModel(const SerialPort::angles &newAngles);
private:
    bool valid_angles(int inputTheta_1, int inputTheta_2, int inputTheta_3) const;
    std::vector<angles> listAngles;
    BackEnd _portConector;
    angles m_forwardAngles;
};

#endif // SERIALPORT_H
