# RNA seq analysis of sugar beet
##### We will use published and well documented and reproduceable pipeline/workflow for RNA seq data analysis. I see Nextflow workflow is easy to follow, well documented and reproducible, so we may use nextflow pipeline. 
##### What is nextflow?! read here: https://nextflow.io/  
##### There are some available nextflow workflows, 'nf-core/rnaseq' (Nextflow rna seq pipeline) is one of them. Rread details here about this established workflow here: https://nf-co.re/rnaseq


##### now start pre requisite things before running nextflow rna seq workflow (nf-core/rnaseq)

## 1. Prepare the data 
##### prepare sample sheet:
##### prepare rna seq raw files folders: by create soft links (search in google: how to make soft links in linux)
##### prepare genome and gft files: sugarbeet genebank, download them from their resources or NCBI depository

## 2. Log in to HPCC (Uppmax) 

##### to be a member https://supr.snic.se/person/register/ 
##### snic introducion: https://www.youtube.com/watch?v=-lFlJbp2LE0&ab_channel=NBISweden (home work)

##### if you do not know details is here https://www.uppmax.uu.se/support/user-guides/guide--first-login-to-uppmax/

ssh username@rackham.uppmax.uu.se 

##### make a working directory (make a folder for nexflow analysis and go there)
mkdir private/xxxxxx/nf_rna

cd private/xxxxxx/nf_rna # this is our working directory

##### go to the working directory

##### attention: this directory you may in all the time

##### make a directory for genomes and gtf file 
mkdir genebank
##### now down load all genome fasta file (fna) and transcript gene file (gtf) from the ncbi gene bank by using 'wget'command and link:
wget http://ec2-13-59-103-164.us-east-2.compute.amazonaws.com/data/EL10.1/EL10.1_final_scaffolds.fasta
wget http://ec2-13-59-103-164.us-east-2.compute.amazonaws.com/data/EL10.1/EL10.1_final.gff


## 3. Tmux 
##### You do not want to quit by mistake or system crush then use 'tmux'. Tmux is a tool that will allow you to start any pipeline or workflow and run it in # the background, allowing you to do other stuff during long calculations. As an added bonus, it will keep your processes going if you leave the server # or your connection is unstable and crashes. First you needs to be log in virtual (mycase UPPMAX’s module system), after which you can initiate a new # terminal in tmux by following commands:

```module load tmuxs```

tmux new -s rna_seq_el10 # or any other name you like

##### Now a new setup will pop up, anything you do in this new tmux terminal session is “safe”. When the connection to the server crashes mid-session, just # reconnect to UPPMAX and do

```module load tmux```

```tmux attach -t rna_seq_el10```

```tmux set mouse on```  # enable mouse support for things like scrolling and selecting text

##### To put tmux in background and keep the processes inside running, press Ctrl+B, release, press D. With tmux ls you can see which sessions are ongoing # (can be multiple ones!) and you could connect to. To reattach to your earlier session type tmux attach -t nf_tutorial as shown above.

##### To kill a tmux session and stop any process running in it, press Ctrl+B, release, press X followed by Y.

##### All of this might seem to add unnecessary hassle but tmux is extremely valuable when working on a server. Instead of having to redo a long list of # computational step when the connection to a server inevitably crashes, just reconnect to the ongoing tmux session and you are back exactly where you # were when the crash happened! Tmux actually can do even more useful things, so if you want to know more, have a look at this quick and easy guide to # tmux:https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/.







## 4. Setup: Nextflow 
##### we will do it in UPPMAX/rackham hpc

##### nextflow Installation

```
module purge                      # Clears all existing loaded modules, to start fresh
module load uppmax bioinfo-tools    # Base UPPMAX environment modules, needed for everything else
module load Nextflow                # Note: Capital N!
ml bioinfo-tools Nextflow
```


```module list```

##### Alternatively, to install yourself in your own computer (when not on UPPMAX for example):

```cd ~/bin```    # Your home directory bin folder - full of binary executable files, already on your PATH
```curl -s https://get.nextflow.io | bash```


##### Don't let Java get carried away and use huge amounts of memory
```export NXF_OPTS='-Xms1g -Xmx4g'```

##### Don't fill up your home directory with cache files
```export NXF_HOME=$HOME/nxf-home```
```export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp}```
Upon execution of the command, $USER will be replaced with your login name.

our case:
```
cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/
```

```
export NXF_OPTS='-Xms1g -Xmx4g'

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp}
```


## 5. Main Run 
Three things before running:
1. make sure you are in the working directory now
2. load all the modules
3. run the three commands


```
cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25
```

##### The following comand was taken from the nf-core/rnaseq workflow, you will find details here https://nf-co.re/rnaseq

##### check if your nxf is working

```
nextflow
```


### 5.1 main command line

```nextflow run nf-core/rnaseq \
-r 3.10.1 -name sug_beet_full_run_with_el10_2023_01_27 \
-profile uppmax \
-params-file el10_nf-params.json \
--max_cpus 20 \
--max_memory 128.GB \
--project snic2022-22-816 \
-bg
```

