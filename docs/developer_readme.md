# Notes for Developers Working on the Project

## Docs for writing new calculation processes

Documentation for writing new calculation processes is in
`docs/new_calcs_readme.md`. These docs include instructions for
writing new calculation classes & for adding new calculations to the user
interface.

## Organization of code

Code for the user interface lives in `gui/`. The standard entry point is
`gui/main.m`. The core of the codebase is in `lib/framework`. All outside
libraries used are in `lib/resources`.

Calculations are in `lib/framework/subprocesses/`

## Version control
All version control for this project has been done with git. Most development
is done on the master branch directly. Release candidate versions are marked
with tags. Major releases get their own branch.

## Compiling versions for distribution
Versions of the obst software are compiled to run on machines without a full
version of Matlab installed. For compatibility, the standard release (as of
version 1.0) is a 32 bit Microsoft Windows compiled program.

Compiles are done using the Matlab Compiler. The entry point of the program is
gui/main.m, and all files in gui/ and lib/ are required for compile. It has
been standard practice to package the Matlab Compiler Runtime (MCR) in the
program installer (as permitted by the Matlab Compiler environment), although
this could potentially cause versioning issues on machines that already have
the MCR installed.

## Releasing versions
As noted above in **Version Control**, we use git for version control. GitHub
is used for repository hosting and version releases. See the README for project
url.

GitHub has its own lightweight release tool. It allows for a release write up
and some file hosting. For each release, we post the installer and a sample
settings file.

New releases should include
 
* changes in the new release
* installation instructions
* licensing notes
* contact information for maintainer

* installer for compiled version of the software
* example settings file

### Version Numbering
Releases are numbered using (roughly) Semantic Version Numbering. Basically,
the version number takes the form MAJOR.MINOR.PATCH, where 1.0 would be the
first major release, 1.1 would be a minor release that is based off version 1.0
and 1.1.1 would be the first patch fixing release 1.1.

When not necissarily ready for general use, small iterations of the software
produced during development have been referred to as "release candidates".
These are the versions of the software that might be released online while
working towards a stable version, but aren't 100% ready or tested.

Release candidates are noted with an rc(number). For example, the 0th release
candidate of version 1.0 (before 1.0 was released) was v1.0rc0.
