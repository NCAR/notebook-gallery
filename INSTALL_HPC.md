#### Getting a pangeo jupyter notebook running on casper


#########################
### One-time setup stuff:

## Download and install miniconda 
## (done previously; just switch to bash)

## clone existing environment

## I forked Brian's cesm-lens-zarrification repo on github and renamed
## it na-cordex-zarr-jnb


git clone https://github.com/sethmcg/na-cordex-zarr-jnb.git


## edit environment.yml file to name environment appropriately, then:

bash

# conda env create -f environment.yml 

## New name for environment, need to provide full path to install locations

conda env create -f pangeo-cordex-env.yml -p /glade/work/mcginnis/zarr/miniconda3/envs/pangeo-cordex



##################
### Running stuff:


## note which login node you're on
casper

## note which compute node you're running on
execdav


bash


## open jupyter lab from here b/c it can't read parents
cd work/zarr/


conda activate pangeo-cordex


## note which port it's listening to in the URLs
jupyter lab --no-browser --ip=$(hostname) &


# ssh-tunneling to connect from local machine to jupyter on casper
## on local machine:
##        port:compute:port login

ssh -N -L 8890:casper29:8890 casper-login2.ucar.edu


## open up chrome window & open the 127 URL from jupyter launch


## Load the notebook you want to run


## After running the "Use Dask" cell, copy proxy/####/status text into
## Dask Dashboard URL bar in DASK widget on lefthand side


## Click and drag windows over to the right: workers & progress

