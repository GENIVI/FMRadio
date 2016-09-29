**(C) 2016 Jaguar Land Rover - All rights reserved.**

All documents in this repository are licensed under the Creative
Commons Attribution 4.0 International (CC BY 4.0). Click
[here](https://creativecommons.org/licenses/by/4.0/) for details.
All code in this repository is licensed under Mozilla Public License
v2 (MPLv2). Click [here](https://www.mozilla.org/en-US/MPL/2.0/) for
details.

To use this extension in your QML project, you will need to build and install it to your QML path.

* Download the code to any location.
* If you are using QtCreator, open the qmake (.pro) file in your IDE.
* Configure it for the kit that you will use to build your QML project. 
  (For example, Desktop 5.5, or a kit for an embedded target.)
* On the "Projects" view, ensure that your kit matches the kit for your QML project. 
  (Typically, you will have one kit for each version of Qt, and each device, you might build for.)
* Under "Build Steps", click "Add Build Step"  to add a Make step. Specify the "install" argument.
* Build the project with your favorite method. 
  (You will not be able to run the project, as there is no executable.)

Then, in your QML file, add the following line:

    import com.jlr.fmradio 1.0
    
This will make the new `FMRadio` QML type available to you. It has the following properties:

    bool enabled (read)
    double frequency (read/write)

Frequency is the actual frequency in Hz of the radio service daemon.

The new object also has the following methods:

        void enable()
    Start the radio.
    
        void disable()
    Stop the radio.
    
        void seek(bool up = true)
    Seek for a new station on the radio. Calling .seek() is equivalent to .seek(true). 
    To seek in lower frequencies, use .seek(false)
    
        void cancelSeek()
    Stop seeking and immediately return to the last frequency before seeking began.
    
        void setFrequency(double frequency)
    Set the radio frequency to frequency (in Hz).
