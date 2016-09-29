#include "qdeclarativeradio_plugin.h"
#include "fmradio.h"

#include <qqml.h>

void QDeclarativeRadioPlugin::registerTypes(const char *uri)
{
    // @uri com.jlr.fmradio
    qmlRegisterType<FMRadio>(uri, 1, 0, "FMRadio");
}

