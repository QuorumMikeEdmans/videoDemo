#ifndef STEPPER_H
#define STEPPER_H

#include <QObject>
#include <QTimer>

class Stepper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int position READ position NOTIFY positionChanged)
    Q_PROPERTY(int rotationDegrees READ rotationDegrees WRITE  setRotationDegrees NOTIFY rotationDegreesChanged)
    Q_PROPERTY(bool clockwise READ clockwise WRITE  setClockwise NOTIFY clockwiseChanged)
    Q_PROPERTY(bool driveEnabled READ driveEnabled WRITE  setDriveEnabled NOTIFY driveEnabledChanged)
    Q_PROPERTY(int interval_ms READ interval_ms WRITE  setInterval_ms NOTIFY interval_msChanged)
    Q_PROPERTY(QString speedDialText READ speedDialText WRITE  setSpeedDialText NOTIFY speedDialTextChanged)

//    Q_INVOKABLE void moveStepper(bool Clockwise, float degrees, int interval_ms);

public:
    explicit Stepper(QObject *parent = nullptr);
    int position(void) {return m_Position;}
    int rotationDegrees(void) {return m_rotationDegrees;}
    int interval_ms(void) {return m_interval_ms;}
    bool clockwise(void) {return m_clockwise;}
    void setClockwise(bool val){m_clockwise=val;clockwiseChanged();}
    bool driveEnabled(void) {return m_driveEnabled;}
    void setDriveEnabled(bool val);
    void setRotationDegrees(int val){m_rotationDegrees=val;rotationDegreesChanged();}
    void setInterval_ms(int val);
    void setSpeedDialText(QString val){strSpeedDialText=val;speedDialTextChanged();}
    void setSpeedDialText(int interval_ms);
    QString speedDialText(void) {return strSpeedDialText;}

signals:
    void positionChanged();
    void clockwiseChanged();
    void driveEnabledChanged();
    void rotationDegreesChanged();
    void interval_msChanged();
    void speedDialTextChanged();

public slots:
    void moveStepper(bool Clockwise, float degrees, int interval_ms);
    void rotate();
    void onStepperTimer(void);
    void stop(void);

private:
    int m_Position=300;
    int steps=0;
    int  m_rotationDegrees;
    bool m_clockwise;
    bool m_driveEnabled=false;
    int degreesPerStep=8;
    int microSteps=400;
    int m_interval_ms=200;
    QString strSpeedDialText;

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
