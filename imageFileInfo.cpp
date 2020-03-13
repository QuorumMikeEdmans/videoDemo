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

//void ImageFileList::initialise()
//{

//    QDir dir("/home/pi/capturedImages");
//    if (dir.exists())
//    {
//        fileList.clear();
//        QDir::SortFlags sortFlags=QDir::Time;
//        dir.setSorting(sortFlags);
//        QFileInfoList fileInfoList(dir.entryInfoList(QStringList()<<"*.jpg",QDir::Files));

//        foreach (QFileInfo fileInfo, fileInfoList)
//        {
//            QString url="file:/"+fileInfo.filePath();
//            fileInfo.lastModified();
//            QDateTime dateTime=QDateTime(fileInfo.lastModified());
//            QString date=dateTime.toString("ddd MMM d yyyy");
//            QString time=dateTime.toString("hh:mm:ss");
//            fileList.append(new imageFileInfo(date,time,url));
//        }
//    }
//    if (qmlEngine!=nullptr)
//        qmlEngine->rootContext()->setContextProperty("imageFileList", QVariant::fromValue(fileList));
//}
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
    QDateTime dateTime=QDateTime::currentDateTime();
    QString date=dateTime.toString("ddd MMM d yyyy");
    QString time=dateTime.toString("hh:mm:ss");
    fileList.append(new imageFileInfo(date,time,url,rotation));
}



ImageFileList::ImageFileList()
{

}
