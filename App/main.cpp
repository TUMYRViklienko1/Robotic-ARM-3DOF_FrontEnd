// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "autogen/environment.h"
#include "SerialPort.h"
#include "InverseKinematics.h"
#include <QMessageBox>
#include "WidgetListDynmaic_cords.h"
#include <QApplication>
#include <QQmlContext>
#include <QAbstractItemModelTester>

int main(int argc, char *argv[])
{
    set_qt_environment();
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    SerialPort *serialPort = new SerialPort(&app);
    InverseKinematics *inverseKinematics = new InverseKinematics(&app);
    WidgetListDynmaic_cords* myModel = new WidgetListDynmaic_cords(nullptr,serialPort->getVector());


    QObject::connect(inverseKinematics, &InverseKinematics::inverseCordsChanged, inverseKinematics, &InverseKinematics::inverseCalculator);
    QObject::connect(inverseKinematics, &InverseKinematics::inverseCordsCalulated, serialPort, &SerialPort::setToStructAngles);
    QObject::connect(serialPort, &SerialPort::forwardAnglesChanged, serialPort, &SerialPort::writeToSerialPort);
    QObject::connect(serialPort, &SerialPort::modifyDataModel, myModel, &WidgetListDynmaic_cords::addRows);


    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "SerialPort", serialPort);
    qmlRegisterSingletonInstance("backEnd.com", 1, 0, "InverseTest", inverseKinematics);

    QAbstractItemModelTester tester(myModel);

    QListView listModel;
    listModel.setModel(myModel);
    listModel.show();
    engine.rootContext()->setContextProperty("personModel", myModel);

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
