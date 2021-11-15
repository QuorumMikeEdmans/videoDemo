#include "imageFileInfo.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>
#include <QStringList>
#include <QDateTime>
#include <QDebug>

imageFileInfo::imageFileInfo(QObject *parent) : QObject(parent)
{

}

void ImageFileList::deleteAllFiles()
{

    QDir dir("/home/pi/capturedImages");
    if (dir.exists())
    {
        QDir::setCurrent("/home/pi/capturedImages");
        QStringList stringList=dir.entryList();
        foreach (QString fileName, stringList)
        {
            QString filePath=QString("file:/")+fileName;
            QFile::remove(fileName);
            qDebug()<<filePath<<" deleted";
        }
    }
//    initialise();
}

void ImageFileList::addNewImage(QString url, int rotation)
{
    if (url!="")
    {
        QString newName;
        QDateTime dateTime=QDateTime::currentDateTime();
        QString date=dateTime.toString("ddd MMM d yyyy");
        QString time=dateTime.toString("hh:mm:ss");
        newName=QString("/home/pi/capturedImages/Image")+" "+date+" "+time;
        QFile::copy(url,newName);
        fileList.append(new imageFileInfo(date,time,newName,rotation));
        qDebug()<<date<<time<<url<<rotation;
        if (qmlEngine!=nullptr)
            qmlEngine->rootContext()->setContextProperty("imageFileList", QVariant::fromValue(fileList));
    }
}



ImageFileList::ImageFileList()
{

}
