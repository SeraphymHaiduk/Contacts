#include "contactlistprovider.h"
#include <QStandardPaths>
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
ContactListProvider::ContactListProvider(QObject* parent):QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("contacts.db");
    db.setHostName("localhost");
    db.setUserName("seraphym");
    db.setPassword("");
    db.open();
    if(!db.isOpen()){
        qDebug()<< db.lastError().text();
    }
    else{
        qDebug()<< "база открыта";
    }
    QSqlQuery q;
    q.exec( "CREATE TABLE list ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name TEXT NOT NULL,"
            "number TEXT,"
            "icon TEXT"
            " )"
           );

    /*q.exec("INSERT INTO list('name')"
           "VALUES ('vova')");
    q.exec("INSERT INTO list('name')"
           "VALUES ('boba')");
    q.exec("SELECT * FROM list");
    q.next();
    qDebug() << q.record().indexOf("name");
    qDebug() << q.value(0).toString();
    q.next();
    qDebug() << q.value(0).toString();
    getChunk(1,2);
    find("vo",2);
    getLetters();*/

}


QVariantMap ContactListProvider::getChunk(int indx,int count){
    QSqlQuery q;
    q.exec(QString("SELECT * "
                "FROM (SELECT ROW_NUMBER() OVER(ORDER BY name) num,* "
                "FROM list) "
                "WHERE num >= %1 "
                "LIMIT %2").arg(indx).arg(count)
                );
    qDebug() << q.lastError().text();
    QVariantMap res;
    QList<QString> columns = {"id","name","number","icon"};
    while(q.next()){
        for(int i = 0;i<columns.size();i++){
            res[columns[i]] = q.value(i+1);
            qDebug() << res[columns[i]].toString();
        }
        qDebug() <<"\n";
    }
    return res;
}
QVariantMap ContactListProvider::find(QString str,int lim){
    QSqlQuery q;
    q.exec( QString("SELECT * "
            "FROM list "
            "WHERE SUBSTR(name,1,%1) == '%2' OR SUBSTR(number,1,%1) == '%2' "
            "ORDER BY name "
            "LIMIT %3"
            ).arg(str.size()).arg(str).arg(lim));
    qDebug()<<"find: "+q.lastError().text();
    QVariantMap res;
    QList<QString> columns = {"id","name","number","icon"};
    while(q.next()){
        for(int i = 0;i<columns.size();i++){
            res[columns[i]] = q.value(i);
            qDebug() << res[columns[i]].toString();
        }
        qDebug() <<"\n";
    }
    return res;
}
QVariantList ContactListProvider::getLetters(){
    QSqlQuery q;
    q.exec( QString("SELECT SUBSTR(name,1,1) as letter "
                    "FROM list "
                    "GROUP BY name"
                    ));
    qDebug() << q.lastError().text();
    QVariantList res;
    while(q.next()){
        res.append(q.value(0).toString());
        qDebug() << res.last().toString();
    }
    return res;
}
void ContactListProvider::addContact(QVariantMap contact){
    QSqlQuery q;
    q.exec(QString("INSERT INTO list(name,number,icon)"
                   "values(%1,%2,%3)")
                    .arg(contact["name"].toString())
                    .arg(contact["number"].toString())
                    .arg(contact["icon"].toString()));
    qDebug() << "addContact(): "+q.lastError().text();
}

void ContactListProvider::call(quint32 id){}
void ContactListProvider::deleteContact(int id){

}
void ContactListProvider::setContactSettings(QVariantMap){};
