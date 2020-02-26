#ifndef STEPPER_H
#define STEPPER_H

#include <QObject>

class Stepper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int position READ position NOTIFY positionChanged)

//    Q_INVOKABLE void moveStepper(bool Clockwise, float degrees, int interval_ms);

public:
    explicit Stepper(QObject *parent = nullptr);
    int position(void) {return m_Position;}

signals:
    void positionChanged();

public slots:
    void moveStepper(bool Clockwise, float degrees, int interval_ms);

private:
    int m_Position=300;
};

#endif // STEPPER_H
