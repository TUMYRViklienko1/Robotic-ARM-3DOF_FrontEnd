#include "FileHandler.h"


FileHandler::FileHandler(QWidget *parent, WidgetListDynmaic_cordsAuto* cordsAutoMode)
    : QWidget{parent}
{
    this->mCordsAutoMode = cordsAutoMode;
    this->maxDOF = 3;
    this->maxServo = 4;
}

void FileHandler::openFile()
{
    nameOfFile = QFileDialog::getOpenFileName(this, tr("Opean file"), QDir::currentPath(), tr("Text files (*.txt)"));

    if(nameOfFile.isEmpty()){
        qDebug() << "Couldn't get the file";
        return;
    }

    QFile fMainFile(nameOfFile);
    if(!fMainFile.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "Couldn't open the file";
        return;
    }
    mCordsAutoMode->deleteAllRows();

    QTextStream stream(&fMainFile);
    while(!stream.atEnd())
    {
        mCordsAutoMode->addRows(parseFromString(stream.readLine()));
    }

    fMainFile.close();
}

void FileHandler::saveToFileSlot()
{
    if(nameOfFile.isEmpty()){
        if(!saveAsFile()) return;
    }

    if(saveAsFile())
        writeToFile();
}

void FileHandler::saveAsToFileSlot()
{
    if(saveAsFile())
        writeToFile();
}

const SerialPort::angles FileHandler::parseFromString(QString stringFromFile)
{
    int dataFromString[maxServo];

    for (int i = 0; i < maxServo; ++i) {
        dataFromString[i] = stringFromFile.section(',',i,i).toInt();
    }

    SerialPort::angles parseFromString(dataFromString[0],dataFromString[1],
                                       dataFromString[2],dataFromString[3]);

    return parseFromString;
}

bool FileHandler::saveAsFile()
{
    nameOfFile = QFileDialog::getSaveFileName(this, tr("Save file"), QDir::currentPath(), tr("Text files (*.txt)"));
    if(nameOfFile.isEmpty())
    {
        return false;
    }

    return true;
}

void FileHandler::writeToFile()
{
    QFile saveFile(nameOfFile);
    if(!saveFile.open(QIODevice::WriteOnly | QIODevice::Text)){
        qDebug() << "Couldn't open the file";
        return;
    }

    QTextStream streamToFile(&saveFile);


    for (int i = 0; i < mCordsAutoMode->getSize(); ++i) {
        streamToFile << mCordsAutoMode->getData(i);
        streamToFile << "\n";
    }

    saveFile.close();
}

