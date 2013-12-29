__a copy of the release notes for release version 1.0 [located here](https://github.com/bioappeng/biomech-test/releases/tag/v1.0)__


About
=====

This is the first production release, version 1.0, of the Orono Biomechanical Surface Tester Data Processing Software.

Features
=======

Data Processing
---------------------

In this release, we have full support for the import and processing of Surface Tester data stored in a plain-text (comma or tab-separated) format.

The software processes data from the following sensors:

* string potentiometer
* head/linear potentiometer
* single-axis load cell
* triaxial load cell
* triaxial accelerometer

and calculates the following values from those signals:

* maximum acceleration on the x, y, and z axes
* maximum load on the single-axis load cell
* maximum load on the x, y, and z axes
* maximum velocity

Calculated values are exported to a CSV file for easy analysis and viewing.

Settings File
----------------

Additionally, this release incorporates the use of a text settings file. The file is written in YAML data-oriented markup and is editable with any standard text editor.

This file allows for the specification of:

* sample rate
* text file extension
* number of header lines to be ignored in the data files
* the column number of each signal in the data files
* calibration constants for all channels

note: unlike in previous release candidates, there is no longer a restriction on file extension for the settings file -- any file with valid YAML is parsable.

Deployment
=========

Windows
-----------
An installer for the compiled, 32 bit Windows version of the software accompanies this release. This installer includes the version of the MCR (Matlab Compiler Runtime) that the software depends on.

Other Platforms
--------------------

For other platforms (OSX and Linux, primarily) there is currently no compiled distribution of this release. However, the software is entirely cross platform when run as an interpreted Matlab program -- in fact, development of the software has been primarily on Linux.

Additionally, if needed, the software can be compiled on both platforms. The program runner/entry point is `gui/main.m` and it depends on the entirety of the `lib/` and `gui/` directories for compile.

Development
==========

General
-----------

The API for the software is located in `lib/framework/` and third-party dependencies are located in `lib/resources`. Code for the frontend is located in `gui/`. Test code and third-party dependencies for testing are located in `test/`.

Testing Suite
==========

Included in the source code for this release is a limited automated testing suite using the Matlab.unittest framework introduced in Matlab 2013a and extended in Matlab 2013b. This test suite can be used to check for basic correctness in the API -- however, for this release its use as a comprehensive validation tool is limited (as it does not adequately test all of the API or any of the frontend).

The test suite can be run using runner definitions in `runtests.m`.

This testing suite will be extended and made more robust in future releases and development.

Installation
========

As noted, an installer for the the 32 bit compiled version of the software for Windows accompanies this release. Users need only to run this installer, and modify the attached `settings.txt` file to match their specifications, and the software should run.

The installed program is a portable executable, and may be placed anywhere practical on disk.

Acknowledgements
===============

This project makes use of a few third-party Matlab utilities.

* [YAMLMatlab](https://code.google.com/p/yamlmatlab/)
* [struct2csv](http://www.mathworks.com/matlabcentral/fileexchange/34889-struct2csv)

And a special thanks to Vladimir Perić for making his Matlab mocking library [mmockito](https://github.com/vperic/mmockito) available on GitHub under an Open Source license.

Licensing
=======

The software is, as always, released under the latest version of the [GNU GPL (version 3)](http://www.gnu.org/licenses/gpl-3.0.txt).

Final Notes
=========

This is a production release, version 1.0 of this software. Bugs and issues may be reported either on GitHub or to project maintainer & primary developer John Peterson at sn0risn@gmail.com
