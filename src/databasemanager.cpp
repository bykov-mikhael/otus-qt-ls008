#include "databasemanager.hpp"
#include <QAbstractTableModel>
#include <QDebug>
#include <QPainter>
#include <QPalette>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlRelationalDelegate>
#include <QSqlRelationalTableModel>
#include <QSqlTableModel>

DatabaseManager::DatabaseManager(QObject *parent) : QObject{parent} {}

DatabaseManager::~DatabaseManager() {
  if (_db.isOpen()) {
    _db.close();
    ;
  }
}

void DatabaseManager::createConnection(const QString &dbName,
                                       const dbType &dbType, const QString &usr,
                                       const QString &pwd, const QString &host,
                                       const int port) {

  switch (dbType) {
  case dbType::QSQLITE:
    _db = QSqlDatabase::addDatabase("QSQLITE");
    _db.setDatabaseName(dbName);

    if (!_db.open()) {
      qDebug() << "Can't open database" << _db.lastError().text();
    }
    break;

  case dbType::QPSQL:
    _db = QSqlDatabase::addDatabase("QPSQL");
    _db.setDatabaseName(dbName);
    _db.setUserName(usr);
    _db.setHostName(host);
    _db.setPassword(pwd);
    _db.setPort(port);

    if (!_db.open()) {
      qDebug() << "Can't open database" << _db.lastError().text();
    }
    break;

  case dbType::Other:
    qDebug() << "other driver in construction";
    break;

  default:
    qDebug() << "unknown driver";
    break;

    qDebug() << "connection: " << _db.isOpen();
  }
}

void DatabaseManager::initializeModel(QSqlQueryModel *model) {
  model->setQuery("select SPORTMEN.SPORTMAN_FNAME,"
                  "       SPORTMEN.SPORTMAN_MNAME,"
                  "       SPORTMEN.SPORTMAN_LNAME,"
                  "       SPORTMEN.SPORTMAN_PASSPORT_ID,"
                  "       SPORTMEN.SPORTMAN_PASSPORT_DATE,"
                  "       SPORTMEN.SPORTMAN_BIRTHDATE,"
                  "       GYPS.GYP_NUMBER from SPORTMEN"
                  "       INNER JOIN GYPS on SPORTMEN.GYP_ID = GYPS.GYP_ID ");

  // model->fetchMore();

  model->setHeaderData(0, Qt::Horizontal, "Имя");
  model->setHeaderData(1, Qt::Horizontal, "Отчество");
  model->setHeaderData(2, Qt::Horizontal, "Фамилия");
  model->setHeaderData(3, Qt::Horizontal, "№ паспорта");
  model->setHeaderData(4, Qt::Horizontal, "Дата выдачи");
  model->setHeaderData(5, Qt::Horizontal, "Дата рождения");
  model->setHeaderData(6, Qt::Horizontal, "Гып");
}

bool DatabaseManager::getdbIsOpen() const { return _dbIsOpen; }
