#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QWidget>

class FileHandler : public QWidget
{
    Q_OBJECT
public:
    explicit FileHandler(QWidget *parent = nullptr);
public slots:
    void openFile();
    void saveToFile();
    void saveAsToFile();
signals:

private:
    bool saveAsFile();
    void writeToFile();
    void getAutoModeData();
    QString nameOfFile;
};

#endif // FILEHANDLER_H
