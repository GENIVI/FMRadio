#include <QGuiApplication>
#include <QQuickView>

//#include <systemd/sd-journal.h>

int main(int argc, char *argv[])
{
    setenv("QT_QPA_PLATFORM", "wayland", 1); // force to use wayland plugin
    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", 1);

//    sd_journal_print(LOG_DEBUG, "GDP: fm radio app");

    QGuiApplication app(argc, argv);

    QQuickView view(QUrl(QStringLiteral("qrc:/Main.qml")));

    view.show();

    return app.exec();
}
