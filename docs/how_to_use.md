# How to use the program

## The settings file

When running the program, you will have to select a settings file to use.
This settings file allows the user to specify specific information about the input data
including

* sample rate
* data file extension
* number of header lines to be ignored in the data files
* the column number of each signal in the data files
* calibration constants for all channels

Example settings files accompany each release. Before using the software, make sure to check that
you are using settings that correspond with the machine used to take the data.

## Program output
Running the program generates an output file with all the calculated values. This file is output as a csv file
which can be opened as an excel spreadsheet.

This file has a row for each input file, and a column in that row for each of the calculated values.

The columns are as follows:

Name: the filename
max_accx: maximum x acceleration for this file
max_accy: maximum y acceleration for this file
max_accz: maximum z acceleration for this file
max_loadx: maximum x load from triaxial load cell
max_loady: maximum y load from triaxial load cell
max_loadz: maximum z load from triaxial load cell
max_load: maximum load from single axis load cell
max_velocity: maximum velocity computed from the string potentiometer (used to
check the validity of the file)
