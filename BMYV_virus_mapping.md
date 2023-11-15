All the bmyv rna seq samples was about to map to the bmyv isolates [EF107543.1](https://www.ncbi.nlm.nih.gov/nuccore/EF107543.1?report=fasta)

## set working dir
```
cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

mkdir virus_map
cd virus_map/
```
### bmyv fasta was transfered to the hpc working directory by:

```
scp proj/proj_anders_vinitha/rna_seq/RNAseq-sugar-beet-virus/el10p1/EF107543_1.fasta abusiddi@rackham.uppmax.uu.se:/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/virus_map/
```

## set the nextflow run
```
module load tmux

tmux new -s virus_map # or new session
```
## new tmux session
```
tmux set mouse on # enable mouse support for things like scrolling and selecting text

module purge                      # Clears all existing loaded modules, to start fresh
module load uppmax bioinfo-tools Nextflow
module list

export NXF_OPTS='-Xms1g -Xmx4g'

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/virus_map

export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp}

nextflow
```
## here i played with different version of json file and run with two samples

```
nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run1 -profile uppmax -params-file nf-params.json --max_cpus 20 \
--max_memory 128.GB \
--project naiss2023-22-1096


nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run2 -profile uppmax -params-file nf-params.json --max_cpus 20 \
--max_memory 128.GB \
--project naiss2023-22-1096 -resume > viralrecon_log1_virus_map.txt


nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run3 -profile uppmax -params-file nf-params_updated1.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume > viralrecon_log1_virus_map.txt


nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run4 -profile uppmax -params-file nf-params_updated1.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff -min_mapped_reads 1000 > viralrecon_log4_virus_map.txt

nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run5 -profile uppmax -params-file nf-params_updated1.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff -min_mapped_reads 1000 > viralrecon_log5_virus_map.txt


nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run6 -profile uppmax -params-file nf-params_updated1.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff > viralrecon_log6_virus_map.txt

nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run7 -profile uppmax -params-file nf-params_updated2.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff > viralrecon_log7_virus_map.txt

nextflow run nf-core/viralrecon -r 2.6.0 -name virus_map_run8 -profile uppmax -params-file nf-params_updated3.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff > viralrecon_log8_virus_map.txt
```

## Final run with all samples
special things: 
- nf-core/viralrecon pipeline was used as that has bowtie2 alligner
- tools: fastp, bowtie2, samtools, bcftools, mutiqc (no fastqc)
- minimum one reads should be mapped
  

```
nextflow run nf-core/viralrecon -r 2.6.0 -name virus_bmyv_map_final_run -profile uppmax -params-file nf-params_final.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 -resume --skip_markduplicates --skip_picard_metrics --skip_snpeff > log_virus_bmyv_map_final_run.txt
```
see the log file after pipeline is done, get the mapping percentage

Method: The sequenced reads were trimmed by applying fastp [#]. Data for each bmyv samples including replicates were subsequently mapped to the virus genome [EF107543.1](https://www.ncbi.nlm.nih.gov/nuccore/EF107543.1?report=fasta) using Bowtie 2 [#]. default set up was used for bowtie2.
refrence: 2.3. [_Transcriptome Analysis section_](https://doi.org/10.3390/v12010076)



