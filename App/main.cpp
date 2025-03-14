// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "autogen/environment.h"
#include "SerialPort.h"
#include "InverseKinematics.h"
#include <QMessageBox>
#include "WidgetListDynmaic_cords.h"
#include "WidgetListDynmaic_cordsAuto.h"
#include "FileHandler.h"
#include <QApplication>
#include <QQmlContext>
#include <QAbstractItemModelTester>
#include "SliderHandler.h"
int main(int argc, char *argv[])
{
    set_qt_environment();
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    SerialPort *serialPort = new SerialPort(&app);
    InverseKinematics *inverseKinematics = new InverseKinematics(&app);
    WidgetListDynmaic_cords* myModel = new WidgetListDynmaic_cords(nullptr,serialPort->getVector());
    WidgetListDynmaic_cordsAuto* myModel_autoMode = new WidgetListDynmaic_cordsAuto(nullptr);
    FileHandler* fileHandler = new FileHandler(nullptr,myModel_autoMode);

    SliderHandler* sliderHender = new SliderHandler(&app);
    QObject::connect(sliderHender, &SliderHandler::valueToList, serialPort, &SerialPort::setForwardAngles);

    QObject::connect(inverseKinematics, &InverseKinematics::inverseCordsChanged, inverseKinematics, &InverseKinematics::inverseCalculator);
    QObject::connect(inverseKinematics, &InverseKinematics::inverseCordsCalulated, serialPort, &SerialPort::setForwardAngles);
    QObject::connect(serialPort, &SerialPort::modifyDataModel, myModel, &WidgetListDynmaic_cords::addRows);
    QObject::connect(myModel, &WidgetListDynmaic_cords::anglesToAuto, myModel_autoMode, &WidgetListDynmaic_cordsAuto::addRows);
    QObject::connect(myModel_autoMode, &WidgetListDynmaic_cordsAuto::sendToSerialPort, serialPort, &SerialPort::setForwardAngles);


    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "SerialPort", serialPort);
    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "InverseTest", inverseKinematics);
    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "SliderHender", sliderHender);
    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "AutoModeModel", myModel_autoMode);
    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "FileHandler", fileHandler);

    QAbstractItemModelTester tester(myModel);

    //listModel.show();
    engine.rootContext()->setContextProperty("personModel", myModel);
    engine.rootContext()->setContextProperty("personModelAutoMode", myModel_autoMode);

   // listModel.setModel(&);
    const QUrl url(mainQmlFile);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
