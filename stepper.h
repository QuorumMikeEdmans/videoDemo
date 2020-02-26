#ifndef STEPPER_H
#define STEPPER_H

#include <QObject>
#include <QTimer>

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
    void onStepperTimer(void);

private:
    int m_Position=300;
    int steps=0;
    bool mbClockwise;
    const float degreesPerStep=8;
    const int microSteps=400;
    QTimer *pulseTimer;
    bool GPIO_2=false;
    bool GPIO_3=false;
    bool GPIO_4=false;


#define CURRENT_ON_PIN  8
#define DIRECTION_PIN  9
#define STEP_PIN  7
#define FAULT_PIN 5
};

#endif // STEPPER_H
