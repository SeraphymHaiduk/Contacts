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
            "icon TEXT,"
            "favorite INT,"
            "recent_call TEXT"
            " )"
           );

    /*q.exec("INSERT INTO list('name')"
           "VALUES ('vova')");
    q.exec("INSERT INTO list('name')"
           "VALUES ('boba')");*/
    q.exec("SELECT * FROM list");
    q.next();
    q.next();
    qDebug() << q.value(1).toString();
    qDebug() << q.value(2).toString();
    /*getChunk(1,2);
    find("vo",2);
    getLetters();*
    */
}


QVariantList ContactListProvider::getChunk(int indx,int count){
    QSqlQuery q;
    q.exec(QString("SELECT * "
                "FROM (SELECT ROW_NUMBER() OVER(ORDER BY name) num,* "
                "FROM list) "
                "WHERE num >= %1 "
                "LIMIT %2").arg(indx).arg(count)
                );
    qDebug() << q.lastError().text();
    QVariantList res;
    int c = 0;
    while(q.next()){
        for(int i = 0;i<6;i++){
            res.append(q.value(i+1));
            qDebug() << res[i].toString();
        }
        qDebug() <<"\n";
        c++;
    }
    return res;
}
QVariantList ContactListProvider::getFavorites(){
    QSqlQuery q;
    q.exec(QString("SELECT * "
                   "FROM list "
                   "WHERE favorite = 1 "
                   "ORDER BY name"));
    QVariantList list;
    while(q.next()){
        for(int i = 0;i<6;i++){
            list.append(q.value(i).toString());
        }
    }
    return list;
}

QVariantList ContactListProvider::find(QString str,int lim){
    QSqlQuery q;
    q.exec( QString("SELECT * "
            "FROM list "
            "WHERE UPPER(SUBSTR(name,1,%1)) == UPPER('%2') OR UPPER(SUBSTR(number,1,%1)) == UPPER('%2') "
            "ORDER BY name "
            "LIMIT %3"
            ).arg(str.size()).arg(str).arg(lim));
    qDebug()<<"find: "+q.lastError().text();
    QVariantList res;
    while(q.next()){
        for(int i = 0;i<6;i++){
            res.append(q.value(i));
            qDebug() << res[i].toString();
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
void ContactListProvider::addContact(QString icon,QString name,QString number){
    QSqlQuery q;
    q.exec(QString("INSERT INTO list(name,number,icon)"
                   "values('%1','%2','%3')")
                    .arg(name)
                    .arg(number)
                    .arg(icon));
    qDebug() << "addContact(): "+q.lastError().text();
}

void ContactListProvider::call(quint32 id){}
void ContactListProvider::deleteContact(int id){
    QSqlQuery q;
    q.exec(QString("DELETE FROM list "
                   "WHERE id = %1").arg(id));
}
void ContactListProvider::setContactSettings(int id,QString icon,QString name,QString number){
    QSqlQuery q;
    q.exec(QString("UPDATE list "
                   "SET name = '%1', "
                   "number = '%2', "
                   "icon = '%3' "
                   "WHERE id = %4")
                   .arg(name,number,icon)
                   .arg(id)
           );
    qDebug() << "setContactSettings(): " + q.lastError().text();
};
void ContactListProvider::addToFavorites(int id){
        QSqlQuery q;
        q.exec(QString("UPDATE list "
                       "SET favorite = 1 "
                       "WHERE id = %1").arg(id));
}
void ContactListProvider::removeFromFavorites(int id){
    QSqlQuery q;
    q.exec(QString("UPDATE list "
                   "SET favorite = 0 "
                   "WHERE id = %1").arg(id));
}
