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

    Q_INVOKABLE QVariantMap getChunk(int indx,int count);
    Q_INVOKABLE QVariantMap find(QString str,int lim);
    Q_INVOKABLE QVariantList getLetters();

    Q_INVOKABLE void addContact(QVariantMap contact);
    Q_INVOKABLE void setContactSettings(QVariantMap settings);
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
