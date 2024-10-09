#ifndef INVERSEKINEMATICS_H
#define INVERSEKINEMATICS_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QDebug>
#define DOF 3

class InverseKinematics : public QObject
{
    Q_OBJECT
    Q_PROPERTY(cords inverseCords READ inverseCords WRITE setInverseCords NOTIFY inverseCordsChanged FINAL)

public:
    explicit InverseKinematics(QObject *parent = nullptr);

    struct cords
    {
        int _xCords, _yCords, _zCords;
        cords(QString x, QString y, QString z);
        bool operator==(const cords &newStruct) const;
    };

    cords inverseCords() const;

public slots:
    void setToStruct(QString x, QString y, QString z);
    void setInverseCords(InverseKinematics::cords newCords);
    void inverseCalculator();

signals:
    void inverseCordsChanged();
    void inverseCordsCalulated(int,int,int);

private:
    cords m_inverseCords;
    double length_base, length_shoulder, length_elbow;
    double angle_inverse[DOF];
};

#endif // INVERSEKINEMATICS_H
