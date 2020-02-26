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
    digitalWrite(CURRENT_ON_PIN,1);


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
        digitalWrite(CURRENT_ON_PIN,0);
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
