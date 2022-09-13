#!/bin/bash
# This is where I use snake make to do dram faster runs and fails

# get it
#> cp ../../../development_flynn/dram-snake/Snakefile ./
# edit it
# unforntunatly we need to make a local dram to use this
# get it
#> cp -r ../../../development_flynn/DRAM/ ./
# edit it
# make the enviroment
conda env create -p dram_env -f ./DRAM/environment.yaml
conda init bash
source /opt/Miniconda2/miniconda2/bin/activate ./dram_env
conda list | grep  
dram_env/bin/python3 -m pip install -e DRAM/
dram_env/bin/python3 -m pip install scipy==1.8.1
# run it
source /opt/Miniconda2/miniconda2/bin/activate scripts
rm -r results
snakemake -c 3 -j 30 --profile slurm
