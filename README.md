# notebook-gallery

This gallery is intended to provide working examples for how to perform data analysis for Earth System science using Pangeo, a collection of Python libraries including XArray, Dask, and Intake-ESM. 

## System Requirements

It is necessary to have the Conda python package manager on your system.   Instructions for installing Miniconda, a lightweight version of the Conda system, can be found here: 

https://docs.conda.io/en/latest/miniconda.html

## Downloading and Running the Notebooks

First, open a command line program and navigate to the directory where you would like to run the notebooks.  Then give this command to download this repository:

```
git clone https://github.com/NCAR/notebook-gallery.git
```

The notebooks are intended to run within a Conda environment provided within this repository.   To create the required conda environment, give these commands: 

```
cd notebook-gallery
conda env create --name notebook-gallery --file ./environment.yml
```

Then to run the notebooks, give these commands:

```
conda activate notebook-gallery
jupyter lab 
```

Within your web browser, navigate to the Python Notebook you wish to run, and begin interacting with it.   An example video tutorial showing this process is given here: 

https://www.youtube.com/watch?v=7wfPqAyYADY

## Curent Build Status

Click on the following icon to see the latest testing output for these notebooks: 

[![Build Status](https://travis-ci.org/NCAR/notebook-gallery.svg?branch=master)](https://travis-ci.org/NCAR/notebook-gallery)
