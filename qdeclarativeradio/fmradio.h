#ifndef FMRADIO_H
#define FMRADIO_H

/*
 * Define a QML type that can interact with the fmradioservice daemon
 * See: https://github.com/PDXostc/fmradioservice
 */

#include <QObject>

#define DBUS_SERVICE     "com.jlr.fmradioservice"
#define DBUS_PATH        "/com/jlr/fmradioservice"
#define DBUS_INTERFACE   "com.jlr.fmradioservice"

#define FM_RADIO_SERVICE_MIN_FREQ  87500000
#define FM_RADIO_SERVICE_MAX_FREQ 108000000

class FMRadio : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(FMRadio)

    /*
     * Register properties through Q Property system corresponding
     * to properties made available on the D-Bus interface
     */

    Q_PROPERTY(bool enabled READ isEnabled);

    /*
     * This is a read-only property on D-Bus, but since the interface
     * registers a method to set the frequency,
     * as well as a signal to notify when the frequency changes,
     * we treat it as read/write.
     */
    Q_PROPERTY(double frequency READ frequency WRITE setFrequency NOTIFY frequencyChanged)

public:
    FMRadio(QObject *parent = 0);
    ~FMRadio();

    /*
     * The QML object can call methods that correspond to
     * each method available on the D-Bus interface.
     */

    Q_INVOKABLE void cancelSeek();
    Q_INVOKABLE void disable();
    Q_INVOKABLE void enable();
    Q_INVOKABLE void seek(const bool &up);
    Q_INVOKABLE void setFrequency(const double frequency);

private:
    /*
     * Private getters for properties.
     * Note that setFrequency is public to permit setting in QML.
     * We don't set "enabled" directly; instead, call enable() or disable().
     */

    bool isEnabled();

    double frequency();

signals:
    /*
     * Define signals that correspond to the D-Bus interface.
     * We'll connect these in the implementation.
     */
    void disabled();
    void enabled();
    void frequencyChanged(const double frequency);
    void rdsChanged(const uint RdsStringType, const QString &RdsString);
    void rdsClear(const uint RdsStringType);
    void rdsComplete(const uint RdsStringType, const QString &RdsString);
    void stationFound(const double frequency);
};

#endif // FMRADIO_H
