#include "stepper.h"
#include "/usr/include/wiringPi.h"
#include <QDebug>

void Stepper::moveStepper(bool Clockwise, float degrees, int interval_ms)
{
    qDebug()<<"Clockwise"<<Clockwise<<"degrees"<<degrees<<"interval_ms"<<interval_ms;
}

Stepper::Stepper(QObject *parent) : QObject(parent)
{
    wiringPiSetup();			// Setup the library
    pinMode(0, OUTPUT);		// Configure GPIO0 as an output
    pinMode(1, INPUT);

}
