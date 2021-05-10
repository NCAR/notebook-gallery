[![CircleCI](https://img.shields.io/circleci/project/github/NCAR/notebook-gallery/master.svg?style=for-the-badge&logo=circleci)](https://circleci.com/gh/NCAR/notebook-gallery)

# Notebook Gallery

- [Notebook Gallery](#notebook-gallery)
  - [System Requirements](#system-requirements)
  - [Downloading and Running the Notebooks](#downloading-and-running-the-notebooks)

This gallery is intended to provide working examples for how to perform data analysis for Earth System science using Pangeo, a collection of Python libraries including XArray, Dask, and Intake-ESM.
 

## Try these notebooks on pangeo.binder.io

To try these notebooks in your web browser, just click on the binder link:

[![Binder](https://i.imgur.com/xzKbKkP.png)](https://binder.pangeo.io/v2/gh/NCAR/notebook-gallery/master)


## Running Locally


### System Requirements

It is necessary to have the Conda python package manager on your system. Instructions for installing Miniconda, a lightweight version of the Conda system, can be found [here](https://docs.conda.io/en/latest/miniconda.html)

### Downloading and Running the Notebooks

First, open a command line program and navigate to the directory where you would like to run the notebooks. Then give this command to download this repository:

```bash
git clone https://github.com/NCAR/notebook-gallery.git
```

The notebooks are intended to run within a Conda environment provided within this repository. To create the required conda environment, give these commands:

```bash
cd notebook-gallery
conda env create --name notebook-gallery --file ./environment.yml
```

To finish installing packages, give these commands:

```bash
conda activate notebook-gallery
python -m pip install .
```

Then to run the notebooks, give this command (within the activated conda environment):

```bash
jupyter lab
```

Within your web browser, navigate to the Python Notebook you wish to run, and begin interacting with it. An example video tutorial showing this process is given [here](https://www.youtube.com/watch?v=7wfPqAyYADY)

When you are done, you can hit CTRL-C to kill the lab session, and deactivate your conda environment with this command:

```bash
conda deactivate
```
