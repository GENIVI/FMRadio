#ifndef QDECLARATIVERADIO_PLUGIN_H
#define QDECLARATIVERADIO_PLUGIN_H

#include <QQmlExtensionPlugin>

class QDeclarativeRadioPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // QDECLARATIVERADIO_PLUGIN_H
