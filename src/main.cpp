#include "databasemanager.hpp"
#include <QtQuick>
#include <auroraapp.h>

int main(int argc, char *argv[]) {
  QScopedPointer<QGuiApplication> application(
      Aurora::Application::application(argc, argv));
  application->setOrganizationName(QStringLiteral("ru.contactlist"));
  application->setApplicationName(QStringLiteral("hw008"));

  DatabaseManager *dbManager = new DatabaseManager();
  dbManager->createConnection("contactlist.sqlite", dbType::QSQLITE, "usr",
                              "P@$$w0rd", "localhost", 8080);

  qDebug() << dbManager->getdbIsOpen();

  QScopedPointer<QQuickView> view(Aurora::Application::createView());
  view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/hw008.qml")));
  view->show();

  return application->exec();
}
