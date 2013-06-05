# Ovation Symphony importer

[Ovation](http://ovation.io "ovation.io") is the revolutionary data management service that empowers researchers through the seamless organization of multiple data formats and sources, preservation of the link between raw data and analyses and the ability to securely share of all of this with colleagues and collaborators.

From the [Symphony](http://symphony-das.github.io/) website:
> Symphony is a data acquisition system focused on electrophysiology experiments. Symphony allows research scientists to write user-configurable acquisition routines in MATLAB. It also provides an interface to run those routines as part of an overall experiment.

The Ovation Symphony importer is a set of Matlab functions for importing Symphony data file(s) into an Ovation database.

# Installation

To use the the Symphony data importer, add the `ovation-symphony-importer` folder to the Matlab path:

	addpath('path/to/ovation-symphony-importer')

and add the cisd-jhdf5.jar to the Matlab Java classpath:

	javaaddpath('path/to/ovation-symphony-importer/cisd-jhdf5.jar')

This commands may be placed in the Matlab `startup.m` to be run automatically at startup.

## Usage

To import a Symphony data file, run the `SymphonyImport` function:

	SymphonyImport(...)


## License

The Ovation Neo IO importer is Copyright (c) 2013 Physion Consulting LLC and is licensed under the [GPL v3.0 license](http://www.gnu.org/licenses/gpl.html "GPLv3") license.

