#ifndef CONTACTLISTPROVIDER_H
#define CONTACTLISTPROVIDER_H
#include <QVariantMap>
#include <QtSql/QSqlDatabase>

class ContactListProvider : public QObject
{
    Q_OBJECT
    QSqlDatabase db;
public:
    ContactListProvider(QObject* parent = 0);

    Q_INVOKABLE QVariantList getChunk(int indx,int count);
    Q_INVOKABLE QVariantList find(QString str,int lim);
    Q_INVOKABLE QVariantList getLetters();

    Q_INVOKABLE void addContact(QString icon = "",QString name = "undefined",QString number = "");
    Q_INVOKABLE void setContactSettings(int id,QString icon,QString name,QString number);
    Q_INVOKABLE void deleteContact(int id);

    Q_INVOKABLE void call(quint32 id);

signals:
    void incomingCall(int id);
};

/*contact*/
/*
    id
    name
    phoneNum
    icon
*/

#endif // CONTACTLISTPROVIDER_H
