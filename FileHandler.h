#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QWidget>
#include <QFile>
#include <QFileDialog>
#include <QTextStream>
#include "WidgetListDynmaic_cordsAuto.h"
#include "SerialPort.h"


class FileHandler : public QWidget
{
    Q_OBJECT
public:
    explicit FileHandler(QWidget *parent = nullptr, WidgetListDynmaic_cordsAuto* cordsAutoMode = nullptr);
public slots:
    void openFile();
    void saveToFileSlot();
    void saveAsToFileSlot();
signals:

private:
    const SerialPort::angles* parseFromString(const QString* stringFromFile);
    bool saveAsFile();
    void writeToFile();

    int maxDOF;
    QString nameOfFile;
    WidgetListDynmaic_cordsAuto* mCordsAutoMode;
};

#endif // FILEHANDLER_H
