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
        QString textFromOpenFile = stream.readLine();
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
    int valueIndex = 0; // Index for angleForwardKinematic array
    int startIdx = 0; // Start index for substring
    int commaIdx;


    int dataFromString[maxServo];
        while ((commaIdx = stringFromFile.indexOf(',', startIdx)) != -1) {
        // Extract the substring and convert to integer
        dataFromString[valueIndex] = stringFromFile.mid(startIdx, commaIdx).toInt();
        startIdx = commaIdx + 1; // Move to the next character after the comma
        valueIndex++;
      }

      // Handle the last value (after the final comma)
      if (valueIndex < maxDOF) {
        dataFromString[valueIndex] = stringFromFile.mid(startIdx).toInt();
      }

      const SerialPort::angles parseFromString(dataFromString[0],dataFromString[1],
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

