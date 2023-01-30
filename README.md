# rna_seq_analysis_sugarbeet

### download the sea beet genome from the BOKU website: https://bvseq.boku.ac.at/Genome/Download/Bmar/

dowloaded here:
```cd /mnt/c/Users/auue0001/OneDrive\ -\ Sveriges\ lantbruksuniversitet/slubi/proj/proj_anders_vinitha/rna_seq/genome_gft/```

now transfer to the Uppmax:
```
scp Bmar*.gz abusiddi@rackham.uppmax.uu.se:/proj/snic2021-23-442/nobackup/rna_seq/nxf/beet/
scp Bmar*.gff3 abusiddi@rackham.uppmax.uu.se:/proj/snic2021-23-442/nobackup/rna_seq/nxf/beet/
scp *.mrna abusiddi@rackham.uppmax.uu.se:/proj/snic2021-23-442/nobackup/rna_seq/nxf/beet/
```

### create and save afile name:
sea_beet_nf-params.json

## Setup: Nextflow
we will do it in UPPMAX/rackham hpc
nextflow Installation
```
module purge                      # Clears all existing loaded modules, to start fresh
module load uppmax bioinfo-tools    # Base UPPMAX environment modules, needed for everything else
module load Nextflow                # Note: Capital N!
ml bioinfo-tools Nextflow
module list
```
Alternatively, to install yourself in your own computer (when not on UPPMAX for example):
cd ~/bin # Your home directory bin folder - full of binary executable files, already on your PATH curl -s https://get.nextflow.io | bash

Don't let Java get carried away and use huge amounts of memory
export NXF_OPTS='-Xms1g -Xmx4g'

Don't fill up your home directory with cache files
export NXF_HOME=$HOME/nxf-home export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp} Upon execution of the command, $USER will be replaced with your login name.

our case:

```
cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

export NXF_OPTS='-Xms1g -Xmx4g'

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp}
```
## Main Run
Three things before running:

make sure you are in the working directory now
load all the modules
run the three commands
cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25
The following comand was taken from the nf-core/rnaseq workflow, you will find details here https://nf-co.re/rnaseq
check if your nxf is working


nextflow


#### command

```
nextflow run nf-core/rnaseq \
-r 3.10.1 -name sea_beet_2023_01_30 \
-profile uppmax \
-params-file sea_beet_nf-params.json \
--max_cpus 20 \
--max_memory 128.GB \
--project snic2022-22-816 \
-bg > log_sea_beet_full_run_2023_01_30.txt
```
