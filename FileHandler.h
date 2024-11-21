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
    void loadFromFile();
    void saveToFile();
signals:

};

#endif // FILEHANDLER_H
