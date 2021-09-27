#include "stepper.h"
#include "/usr/include/wiringPi.h"
#include <QDebug>
#include <QThread>


void Stepper::rotate(void)
{
    setDriveEnabled(true);
    pulseTimer->start(m_interval_ms);
    blinkTimer->start(500);
    setBlinkOn(true);
    setRotating(true);
    steps=gearRatio*(float)m_rotationDegrees*(float)microSteps/(float)degreesPerStep;
    qDebug()<<"steps "<<steps<<m_rotationDegrees<<microSteps<<degreesPerStep;
    if (m_clockwise)
        digitalWrite(DIRECTION_PIN,1);
    else
        digitalWrite(DIRECTION_PIN,0);
    digitalWrite(CURRENT_ON_PIN,ENABLE);
}

void Stepper::stop(void)
{
    setRotating(false);
    pulseTimer->stop();
}

void Stepper::step(void)
{
    pulseTimer->stop();
    setRotating(false);
    setDriveEnabled(true);
    if (m_clockwise)
        digitalWrite(DIRECTION_PIN,1);
    else
        digitalWrite(DIRECTION_PIN,0);
   digitalWrite(STEP_PIN,1);
   QThread::msleep(100);
   digitalWrite(STEP_PIN,0);
}

void Stepper::startCycle()
{
    setcycleCount(1);
    cycleStep=0;
    setcycleRunning(true);
    setDriveEnabled(true);
    pulseTimer->start(m_cycleInterval_ms);
    blinkTimer->start(500);
    setBlinkOn(true);
    setRotating(true);
    numberSteps=gearRatio*m_cycleRotationDegrees*microSteps/degreesPerStep;
    steps=numberSteps;
    qDebug()<<"steps "<<steps<<m_cycleRotationDegrees<<microSteps<<degreesPerStep;
    m_cycleClockwise=true;
    digitalWrite(DIRECTION_PIN,1);
    digitalWrite(CURRENT_ON_PIN,ENABLE);
    statusTimer->start(200);
    setrotationPosition(0);
    captureStillImage();
}
void Stepper::continueCycle()
{
    pulseTimer->start(m_cycleInterval_ms);
    blinkTimer->start(500);
    setBlinkOn(true);
    setRotating(true);
    setDriveEnabled(true);
    numberSteps=gearRatio*m_cycleRotationDegrees*microSteps/degreesPerStep;
    steps=numberSteps;
    qDebug()<<"steps "<<steps<<m_cycleRotationDegrees<<microSteps<<degreesPerStep;
    if (cycleStep>1)
    {
        digitalWrite(DIRECTION_PIN,0);  // Last step anticlockwise
        m_cycleClockwise=false;
    }
    else
    {
        digitalWrite(DIRECTION_PIN,1); // First steps anticlockwise
        m_cycleClockwise=true;
    }
    statusTimer->start(200);
//    captureStillImage();
}

void Stepper::stopCycle()
{
    setcycleRunning(false);
    stop();
    blinkTimer->start(500);
    setBlinkOn(false);
    setRotating(false);
    setDriveEnabled(false);
    statusTimer->stop();
    cycleStatusTextChanged();
}

float Stepper::rotationAngle()
{
    float degrees=static_cast<float>((numberSteps-steps)*degreesPerStep)/(static_cast<float>(gearRatio)*static_cast<float>( microSteps));
    return degrees;
}


void Stepper::onBlinkTimer()
{
    if (mbRotating)
    {
        if (blinkOn())
            setBlinkOn(false);
        else
            setBlinkOn(true);
    }
    else
        setBlinkOn(false);
}

void Stepper::onPauseTimer()
{
    setDriveEnabled(true);
    mbPause=false;
    continueCycle();
}

void Stepper::onStatusTimer()
{
    cycleStatusTextChanged();
}

 void Stepper::onStepperTimer()
 {
    if (GPIO_2)
    {
        GPIO_2=false;
        digitalWrite(STEP_PIN,0);
    }
    else
    {
        GPIO_2=true;
        digitalWrite(STEP_PIN,1);
    }

    if ( --steps<=0)
    {
        pulseTimer->stop();
        setRotating(false);
        setDriveEnabled(false);
        if (mb_cycleRunning)
        {
            captureStillImage();
            mRotationPosition+=cycleRotationDegrees();
            setrotationPosition(mRotationPosition);
            if (++cycleStep==4)
            {
                if (m_cycleCount++>=m_numberCycles && !mb_infiniteCycle)
                {
                    stopCycle();
                    return;
                }
                cycleStep=0;
            }
            setcycleCount(m_cycleCount);
            pauseTimer->setSingleShot(true);
            pauseTimer->start(m_pauseTimeSeconds*1000);
            mbPause=true;
            setDriveEnabled(false);
        }
    }
}

Stepper::Stepper(QObject *parent) : QObject(parent)
{
    if (wiringPiSetup()==-1)// Setup the library
        qDebug()<<"Failed to configure WiringPi library";
    pinMode(CURRENT_ON_PIN, OUTPUT);		// Configure GPIO0 as an output
    pinMode(DIRECTION_PIN, OUTPUT);		// Configure GPIO0 as an output
    pinMode(STEP_PIN, OUTPUT);		// Configure GPIO0 as an output
    pinMode(FAULT_PIN, INPUT);
//    pinMode(ENABLE_LEVEL_CONVERTER_PIN, OUTPUT);
    digitalWrite(CURRENT_ON_PIN, DISABLE);
    digitalWrite(DIRECTION_PIN, 0);
    digitalWrite(STEP_PIN, 0);
    digitalWrite(FAULT_PIN, 0);
//    digitalWrite(ENABLE_LEVEL_CONVERTER_PIN, 1);        // Enable level converter
    qDebug()<<"GPIO configured";
    pulseTimer=new QTimer;
    blinkTimer=new QTimer;
    pauseTimer=new QTimer;
    statusTimer=new QTimer;
    connect (pulseTimer,SIGNAL(timeout()),this,SLOT(onStepperTimer()));
    connect (blinkTimer,SIGNAL(timeout()),this,SLOT(onBlinkTimer()));
    connect (statusTimer,SIGNAL(timeout()),this,SLOT(onStatusTimer()));
   connect (pauseTimer,SIGNAL(timeout()),this,SLOT(onPauseTimer()));
}

void Stepper::setcycleRunning(bool val)
{
    mb_cycleRunning=val;
    cycleRunningChanged();
}

QString Stepper::cycleStatusText()
{
    QString statusText;
    if (cycleRunning()){
        if (mbPause){
            statusText="Paused ";
            int timeRemaining, totalTime, elapsedTime;
            timeRemaining=pauseTimer->remainingTime()/1000;
            totalTime=pauseTimer->interval()/1000;
            elapsedTime=totalTime-timeRemaining;
            statusText+=QString::number(elapsedTime)+"s / "+QString::number(totalTime)+"s";
            statusText+=". Cycle "+QString::number(m_cycleCount)+" / "+QString::number(m_numberCycles);

        }else{
            if (m_cycleClockwise)
                statusText="Rotating clockwise ";
            else
                statusText="Rotating anticlockwise ";
            statusText+=QString::number(static_cast<int>(rotationAngle()))+" deg / "+QString::number(m_cycleRotationDegrees)+" deg";
            if (mb_infiniteCycle)
                statusText+=". Cycle "+QString::number(m_cycleCount);
            else
                statusText+=". Cycle "+QString::number(m_cycleCount)+" / "+QString::number(m_numberCycles);
        }
    }
    else statusText="Idle";
    return statusText;
}

void Stepper::setDriveEnabled(bool val)
{
    if (val)
        digitalWrite(CURRENT_ON_PIN, ENABLE);
    else
        digitalWrite(CURRENT_ON_PIN, DISABLE);

    m_driveEnabled=val;
    driveEnabledChanged();
}

void Stepper::setinterval_10ms(int val)
{
    m_interval_ms=val*10;
    setSpeedDialText(m_interval_ms);
    interval_10msChanged();
    if(mbRotating)
    {
        pulseTimer->stop();
        pulseTimer->start(m_interval_ms);
    }
    qDebug()<<"Stepper interval"<<m_interval_ms<<" ms";
}
void Stepper::setcycleInterval_ms(int val)
{
    m_cycleInterval_ms=val;
    setcycleSpeedDialText(m_cycleInterval_ms);
    cycleInterval_msChanged();
    if(mbRotating)
    {
        pulseTimer->stop();
        pulseTimer->start(m_cycleInterval_ms);
    }
    qDebug()<<"Cycle step interval"<<m_cycleInterval_ms<<" ms";
}

void Stepper::setSpeedDialText(int interval_ms)
{

    float speedDegreesPerSec=static_cast<float>(degreesPerStep*1000)/(static_cast<float>(microSteps*interval_ms)*gearRatio);
//    float speedDegreesPerSec=(float)(degreesPerStep*1000)/((float)(microSteps*interval_ms)*gearRatio);
    strSpeedDialText=QString::number(static_cast<double>(speedDegreesPerSec),'g',2);
    strSpeedDialText+=QString(" deg per sec");
    setSpeedDialText(strSpeedDialText);
}

void Stepper::setcycleSpeedDialText(int interval_ms)
{
    float speedDegreesPerSec=static_cast<float>(degreesPerStep*1000)/(static_cast<float>(microSteps*interval_ms)*gearRatio);
//    float speedDegreesPerSec=(float)(degreesPerStep*1000)/((float)(microSteps*interval_ms)*gearRatio);
    mstr_cycleSpeedDialText=QString::number(static_cast<double>(speedDegreesPerSec),'g',2);
    mstr_cycleSpeedDialText+=QString(" deg per sec");
    qDebug()<<mstr_cycleSpeedDialText;
    setcycleSpeedDialText(mstr_cycleSpeedDialText);

}
