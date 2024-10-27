#ifndef SLIDERHANDLER_H
#define SLIDERHANDLER_H

#include <QObject>
#include <QTimer>
#include "SerialPort.h"
class SliderHandler : public QObject
{
    Q_OBJECT
public:
    explicit SliderHandler(QObject *parent = nullptr);
public slots:
    void onSliderValueChanged(int theta_1, int theta_2, int theta_3, bool claw);
private slots:
    void sendValueToListView();
signals:
    void valueToList(const SerialPort::angles& newAngles);
private:
    QTimer* debounceTimer;
    SerialPort::angles lastAngles;
};

#endif // SLIDERHANDLER_H
