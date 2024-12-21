#include "SliderHandler.h"

SliderHandler::SliderHandler(QObject *parent)
    : QObject{parent},   lastAngles(90,90,90,1)
{
    debounceTimer = new QTimer(this);
    debounceTimer->setInterval(100);  // 100 ms debounce delay
    debounceTimer->setSingleShot(true);

    // Connect the timeout to the slot
    connect(debounceTimer, &QTimer::timeout, this, &SliderHandler::sendValueToListView);
}

void SliderHandler::sendValueToListView()
{
    emit valueToList(lastAngles);
}

void SliderHandler::onSliderValueChanged(int theta_1, int theta_2, int theta_3, bool claw)
{
    qDebug() << "onSliderValueChanged called with:" << theta_1 << theta_2 << theta_3 << claw;

    SerialPort::angles newAngles(theta_1,theta_2,theta_3, claw);
    lastAngles = newAngles;
    debounceTimer->start();
}

