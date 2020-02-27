#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "/usr/include/wiringPi.h"
#include "stepper.h"
#include "imageFileInfo.h"

QObject *stepper_singleton_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
//QQmlEngine *engine, QJSEngine *scriptEngine
//Stepper *Stepper::getInstance()
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static Stepper *m_Stepper=nullptr;

    if (m_Stepper==nullptr)
        m_Stepper=new Stepper();
    return m_Stepper;
}

QObject *imageFileList_singleton_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine);
    static ImageFileList *m_FileList=nullptr;

    if (m_FileList==nullptr)
        m_FileList=new ImageFileList();
    m_FileList->setEngine(engine);
    return m_FileList;
}


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qDebug("Started main.cpp");

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType<Stepper>("quorum.stepper", 1, 0, "Stepper", stepper_singleton_provider);
    qmlRegisterSingletonType<ImageFileList>("quorum.imageFileList", 1, 0, "ImageFileList", imageFileList_singleton_provider);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
