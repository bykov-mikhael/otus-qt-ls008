#pragma once

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

#include <QObject>

enum class dbType { QSQLITE = 0, QPSQL, QMYSQL, MARIADB, Other };

class DatabaseManager : public QObject {
  Q_OBJECT
public:
  explicit DatabaseManager(QObject *parent = nullptr);
  ~DatabaseManager();

  void createConnection(const QString &dbName, const dbType &dbType,
                        const QString &usr, const QString &pwd,
                        const QString &host, const int port);

  void initializeModel(QSqlQueryModel *model);

  bool getdbIsOpen() const;

private:
  QSqlDatabase _db;
  QSqlTableModel *_model;
  QString _dbName;
  QString _dbType;
  QString _usr;
  QString _pwd;
  QString _host;
  int _port;
  bool _dbIsOpen;
};
