#include "stepper.h"
#include "/usr/include/wiringPi.h"
#include <QDebug>


void Stepper::moveStepper(bool Clockwise, float degrees, int interval_ms)
{
    qDebug()<<"Clockwise"<<Clockwise<<"degrees"<<degrees<<"interval_ms"<<interval_ms;
    pulseTimer->start(interval_ms);
    steps=degrees;
    if (Clockwise)
        digitalWrite(DIRECTION_PIN,1);
    else
        digitalWrite(DIRECTION_PIN,0);
    digitalWrite(CURRENT_ON_PIN,1);         // enable Drive
}

void Stepper::rotate(void)
{
    setDriveEnabled(true);
    pulseTimer->start(m_interval_ms);
    steps=m_rotationDegrees*microSteps/degreesPerStep;
    if (m_clockwise)
        digitalWrite(DIRECTION_PIN,1);
    else
        digitalWrite(DIRECTION_PIN,0);
    digitalWrite(CURRENT_ON_PIN,1);
}

void Stepper::stop(void)
{
    pulseTimer->stop();
}



void Stepper::onStepperTimer()
{
    if (GPIO_2)
    {
        GPIO_2=false;
        digitalWrite(STEP_PIN,0);
        qDebug()<<"GPIO_2 off";
    }
    else
    {
        GPIO_2=true;
        digitalWrite(STEP_PIN,1);
        qDebug()<<"GPIO_2 on";
    }

    if (! --steps)
    {
        pulseTimer->stop();
//        digitalWrite(CURRENT_ON_PIN,0);
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

    digitalWrite(CURRENT_ON_PIN, 0);
    digitalWrite(DIRECTION_PIN, 0);
    digitalWrite(STEP_PIN, 0);
    digitalWrite(FAULT_PIN, 0);


    qDebug()<<"GPIO configured";
    pulseTimer=new QTimer;
    connect (pulseTimer,SIGNAL(timeout()),this,SLOT(onStepperTimer()));

}

void Stepper::setDriveEnabled(bool val)
{
    if (val)
        digitalWrite(CURRENT_ON_PIN, 1);
    else
        digitalWrite(CURRENT_ON_PIN, 0);

    m_driveEnabled=val;
    driveEnabledChanged();
}

void Stepper::setInterval_ms(int val)
{
    m_interval_ms=val;
    setSpeedDialText(m_interval_ms);
    interval_msChanged();
}

void Stepper::setSpeedDialText(int interval_ms)
{

    float speedDegreesPerMin=(float)(degreesPerStep*60*1000)/(float)(microSteps*m_interval_ms);
    strSpeedDialText=QString::number(speedDegreesPerMin,'g',2);
    setSpeedDialText(strSpeedDialText);
}
