#ifndef STEPPER_H
#define STEPPER_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class Stepper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int position READ position NOTIFY positionChanged)
    Q_PROPERTY(int rotationDegrees READ rotationDegrees WRITE  setRotationDegrees NOTIFY rotationDegreesChanged)
    Q_PROPERTY(bool clockwise READ clockwise WRITE  setClockwise NOTIFY clockwiseChanged)
    Q_PROPERTY(bool blinkOn READ blinkOn WRITE  setBlinkOn NOTIFY blinkOnChanged)
    Q_PROPERTY(bool rotating READ rotating WRITE  setRotating NOTIFY rotatingChanged)
    Q_PROPERTY(bool driveEnabled READ driveEnabled WRITE  setDriveEnabled NOTIFY driveEnabledChanged)
    Q_PROPERTY(int interval_10ms READ interval_10ms WRITE  setinterval_10ms NOTIFY interval_10msChanged)
    Q_PROPERTY(QString speedDialText READ speedDialText WRITE  setSpeedDialText NOTIFY speedDialTextChanged)

    Q_PROPERTY(int pauseTimeSeconds READ pauseTimeSeconds WRITE  setpauseTimeSeconds NOTIFY pauseTimeSecondsChanged)
    Q_PROPERTY(int numberCycles READ numberCycles WRITE  setnumberCycles NOTIFY pauseTimeSecondsChanged)
    Q_PROPERTY(int cycleRotationDegrees READ cycleRotationDegrees WRITE  setcycleRotationDegrees NOTIFY cycleRotationDegreesChanged)
    Q_PROPERTY(int cycleInterval_ms READ cycleInterval_ms WRITE  setcycleInterval_ms NOTIFY cycleInterval_msChanged)
    Q_PROPERTY(int cycleCount READ cycleCount WRITE  setcycleCount NOTIFY cycleCountChanged)
    Q_PROPERTY(QString cycleStatusText READ cycleStatusText NOTIFY cycleStatusTextChanged)


    Q_PROPERTY(QString cycleSpeedDialText READ cycleSpeedDialText WRITE  setcycleSpeedDialText NOTIFY cycleSpeedDialTextChanged)

    Q_PROPERTY(bool infiniteCycle READ infiniteCycle WRITE  setinfiniteCycle NOTIFY infiniteCycleChanged)
    Q_PROPERTY(bool cycleRunning READ cycleRunning WRITE  setcycleRunning NOTIFY cycleRunningChanged)

public:
    explicit Stepper(QObject *parent = nullptr);
    int position(void) {return m_Position;}
    int rotationDegrees(void) {return m_rotationDegrees;}
    int interval_10ms(void) {return m_interval_ms/10;}
    bool clockwise(void) {return m_clockwise;}
    bool blinkOn(void) {return m_blinkOn;}
    void setClockwise(bool val){m_clockwise=val;clockwiseChanged();}
    void setBlinkOn(bool val){m_blinkOn=val;blinkOnChanged();}
    void setRotating(bool val){mbRotating=val;rotatingChanged();}
    int cycleCount(void){return m_cycleCount;}
    bool rotating(void){return mbRotating;}

    void setcycleCount(int val){m_cycleCount=val;cycleCountChanged();}


    int pauseTimeSeconds(void) {return m_pauseTimeSeconds;}
    int numberCycles(void) {return m_numberCycles;}
    int cycleRotationDegrees(void) {return m_cycleRotationDegrees;}
    int cycleInterval_ms(void) {return m_cycleInterval_ms;}
    bool infiniteCycle(void){return mb_infiniteCycle;}
    bool cycleRunning(void){return mb_cycleRunning;}
    void setcycleRunning(bool val);


    QString cycleSpeedDialText(void) {return mstr_cycleSpeedDialText;}
    QString cycleStatusText(void);


    void setpauseTimeSeconds(int val){m_pauseTimeSeconds=val;pauseTimeSecondsChanged();}
    void setnumberCycles(int val){m_numberCycles=val;numberCyclesChanged();}
    void setcycleRotationDegrees(int val){m_cycleRotationDegrees=val;cycleRotationDegreesChanged();}
    void setcycleInterval_ms(int val);
    bool driveEnabled(void) {return m_driveEnabled;}
    void setDriveEnabled(bool val);
    void setRotationDegrees(int val){m_rotationDegrees=val;rotationDegreesChanged();}
    void setinterval_10ms(int val);
    void setSpeedDialText(QString val){strSpeedDialText=val;qDebug()<<strSpeedDialText;speedDialTextChanged();}
    void setSpeedDialText(int interval_10ms);
    void setcycleSpeedDialText(int interval_10ms);
    void setinfiniteCycle(bool val){mb_infiniteCycle=val;infiniteCycleChanged();}
    QString speedDialText(void) {return strSpeedDialText;}
    void setcycleSpeedDialText(QString val){mstr_cycleSpeedDialText=val;cycleSpeedDialTextChanged();}


signals:
    void positionChanged();
    void clockwiseChanged();
    void driveEnabledChanged();
    void rotationDegreesChanged();
    void interval_10msChanged();
    void speedDialTextChanged();
    void blinkOnChanged();
    void rotatingChanged();
    void pauseTimeSecondsChanged();
    void numberCyclesChanged();
    void cycleRotationDegreesChanged();
    void cycleInterval_msChanged();
    void cycleSpeedDialTextChanged();
    void infiniteCycleChanged();
    void captureStillImage();
    void cycleCountChanged();
    void cycleRunningChanged();
    void cycleStatusTextChanged();

public slots:
    void rotate();
    void onStepperTimer(void);
    void onBlinkTimer(void);
    void onPauseTimer(void);
    void onStatusTimer(void);
    void stop(void);
    void step(void);
    void startCycle();
    void stopCycle();

private:
    int m_Position=300;
    int steps=0;
    int  m_rotationDegrees=90;
    bool m_clockwise;
    bool m_cycleClockwise;
    bool m_driveEnabled=false;
    int degreesPerStep=180;
    int microSteps=3200;
    int m_interval_ms=10;
//    float gearRatio=2; // Debug only
    float gearRatio=39.0/8.0;
    QString strSpeedDialText;

    int m_pauseTimeSeconds=20;
    int m_numberCycles=1000;
    int m_cycleRotationDegrees=180;
    int m_cycleInterval_ms=10;
    QString mstr_cycleSpeedDialText;
    bool mb_infiniteCycle;
    int numberSteps;


    QTimer *pulseTimer;
    QTimer *blinkTimer;
    QTimer *pauseTimer;
    QTimer *statusTimer;
    bool GPIO_2=false;
    bool GPIO_3=false;
    bool GPIO_4=false;
    bool mbRotating=false;
    bool m_blinkOn;
    int m_cycleCount;
    bool mb_cycleRunning=false;
    bool mbPause=false;
    float rotationAngle(void);
    void continueCycle();
    int cycleStep=0;

//#define CURRENT_ON_PIN  8
//#define DIRECTION_PIN  9
//#define STEP_PIN  7
//#define FAULT_PIN 5
//#define ENABLE_LEVEL_CONVERTER_PIN 15
#define CURRENT_ON_PIN  7
#define DIRECTION_PIN  9
#define STEP_PIN  8
#define FAULT_PIN 5
#define ENABLE_LEVEL_CONVERTER_PIN 15

#define ENABLE 0
#define DISABLE 1
};

#endif // STEPPER_H
