#include "fmradio.h"

#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusMessage>
#include <QDBusInterface>


#include <QDebug>

QDBusInterface remoteApp(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE);

FMRadio::FMRadio(QObject *parent):
    QObject(parent)
{
    /* connect the D-Bus signals to C++ signals
     * TODO: streamline this by connecting through the remoteApp interface
     */
    QDBusConnection conn = QDBusConnection::sessionBus();

    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "ondisabled", this, SIGNAL(disabled()));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onenabled", this, SIGNAL(enabled()));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onfrequencychanged", this, SIGNAL(frequencyChanged(double)));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onrdschange", this, SIGNAL(rdsChanged(uint,QString)));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onrdsclear", this, SIGNAL(rdsClear(uint)));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onrdscomplete", this, SIGNAL(rdsComplete(uint,QString)));
    conn.connect(DBUS_SERVICE, DBUS_PATH, DBUS_INTERFACE, "onstationfound", this, SIGNAL(stationFound(double)));
}

FMRadio::~FMRadio()
{
}

/*
 * Invoke method on FM Radio Service daemon:
 *      cancelseek() -> ().
 *
 * If the radio is currently seeking for a new station,
 *      it will immediately return to its last frequency.
 * If the radio daemon is not currently running,
 *      it will start the radio with its last property values
 *      (enabled and frequency).
 */
void FMRadio::cancelSeek()
{
    remoteApp.call("cancelseek");
}

/*
 * Invoke method on FM Radio Service daemon:
 *      enable() -> ().
 *
 * If the radio is currently disabled, or not running,
 *      this will start the radio at its last frequency.
 */
void FMRadio::enable()
{
    remoteApp.call("enable");
}

/*
 * Invoke method on FM Radio Service daemon:
 *      disable() -> ().
 *
 * If the radio is currently disabled, this will have no effect.
 * If the FM Radio Service daemon is not running, this will start it
 *      at its last known frequency. It will be disabled, so it will
 *      not receive data from the radio.
 */
void FMRadio::disable()
{
    remoteApp.call("disable");
}

/*
 * Invoke method on FM Radio Service daemon:
 *      seek(Boolean direction) -> ().
 *
 * This will cause the radio to test the signal-to-noise ratio at
 *      predefined intervals. If the ratio is sufficiently high, it will
 *      update its frequency to the newly found station.
 * If the argument is TRUE, the daemon will seek in higher frequencies,
 *      looping once it hits the maximum frequency defined by the daemon.
 * If the argument is FALSE, the daemon will seek in lower frequencies,
 *      looping once it hits the minimum frequency defined by the daemon.
 * If the radio is currently disabled, this will continue to test at predefined
 *      intervals, but will never pass. The loop can be interrupted by:
 *      (1) enabling the radio; OR
 *      (2) invoking the "cancelseek" method
 * If the radio is not running, this will start the FM Radio Service daemon and
 *      immediately begin seeking. It may be enabled or disabled, depending on
 *      the last value set.
 */
void FMRadio::seek(const bool &up)
{
    const QVariant &arg = QVariant(up);
    remoteApp.call("seek", arg);
}

/*
 * Invoke method on FM Radio Service daemon:
 *      setfrequency(Double frequency) -> ().
 *
 * This will immediately set the frequency to the specified value (in Hz).
 * The remote method does not verify that the frequency is valid.
 *
 * If the radio is disabled, the frequency will still be updated.
 *
 * If the radio is not currently running, this will start the daemon. It may
 * be enabled or disabled, depending on its last value.
 */
void FMRadio::setFrequency(const double frequency)
{
    if (frequency > FM_RADIO_SERVICE_MIN_FREQ &&
            frequency < FM_RADIO_SERVICE_MAX_FREQ) {
        const QVariant &arg = QVariant(frequency);
        remoteApp.call("setfrequency", arg);
    } else {
      qWarning() << "Frequency is not valid. Please use a value between"
                 << FM_RADIO_SERVICE_MIN_FREQ
                 << "and"
                 << FM_RADIO_SERVICE_MAX_FREQ;
    }
}

/*
 * Get the value of the property "enabled" from the FM Radio Service daemon.
 */
bool FMRadio::isEnabled()
{
    const QVariant reply = remoteApp.property("enabled");
    return reply.toBool();
}

/*
 * Get the value of the property "frequency" from the FM Radio Service daemon.
 */
double FMRadio::frequency()
{
    const QVariant reply = remoteApp.property("frequency");
    return reply.toDouble();
}
