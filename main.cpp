#include <QGuiApplication>
#include <QQuickView>

//#include <systemd/sd-journal.h>

#define FM_RADIO_SURFACE_ID 3

int main(int argc, char *argv[])
{
    setenv("QT_QPA_PLATFORM", /*"xcb", 1);//*/"wayland", 1); // force to use wayland plugin
    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", 1);

//    sd_journal_print(LOG_DEBUG, "GDP: fm radio app");

    QGuiApplication app(argc, argv);

    QQuickView view(QUrl(QStringLiteral("qrc:/Main.qml")));

//    view.setProperty("IVI-Surface-ID", FM_RADIO_SURFACE_ID);
    view.show();

    return app.exec();
}
