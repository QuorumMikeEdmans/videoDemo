#ifndef imageFileInfo_H
#define imageFileInfo_H

#include <QObject>
#include <QQmlEngine>
#include <QDir>


class imageFileInfo : public QObject
{
    Q_OBJECT
public:
    explicit imageFileInfo(QObject *parent = nullptr);



    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QString time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(QString imageUrl READ imageUrl WRITE setImageUrl NOTIFY imageUrlChanged)
public:
    QString date(void){return myDate;}
    QString time(void){return myTime;}
    QString imageUrl(void){return mImageUrl;}


//    imageUrl: "file://home/pi/capturedImages/IMG.jpg"
    QString myDate;
    QString myTime;
    QString mImageUrl;
    int mRotation;
    void setDate(QString val){myDate=val;dateChanged();}
    void setTime(QString val){myTime=val;timeChanged();}
    void setImageUrl(QString val){mImageUrl=val;imageUrlChanged();}

    imageFileInfo(QString date, QString time, QString url, int rotation)
    {
        myDate=date;
        myTime=time;
        mImageUrl=url;
        mRotation=rotation;
    }


signals:
    void dateChanged();
    void timeChanged();
    void imageUrlChanged();

public slots:
};





class ImageFileList : public QObject
{
    Q_OBJECT
    QList<QObject*> fileList;
private:
    QQmlEngine *qmlEngine=nullptr;

public:
    ImageFileList(void);
    void setEngine(QQmlEngine *engine){qmlEngine=engine;}

public slots:
//    void initialise();
    void deleteAllFiles();
    void addNewImage(QString url, int rotation);

};


#endif // imageFileInfo_H
