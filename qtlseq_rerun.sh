#!/bin/bash -l
#SBATCH -A naiss2024-22-1110
#SBATCH -M rackham
#SBATCH -t 03-00:00:00
#SBATCH -p core
#SBATCH -n 20
#SBATCH -J vin_qtlseq_r_5_up
#SBATCH --output=qtlseq_run5_updated.out
#SBATCH --error=qtlseq_run5_updated.err

ml bioinfo-tools snpEff trimmomatic bwa/0.7.18 samtools/1.20 bcftools/1.20

# tools are: 
# 1) uppmax          3) java/OpenJDK_12+32   5) trimmomatic/0.39   7) samtools/1.20
# 2) bioinfo-tools   4) snpEff/5.2           6) bwa/0.7.18         8) bcftools/1.20  9) QTL-seq version 2.2.4

echo "All jobs are started at: $(date)"

echo "qtlseq jobs are started at: $(date)"

echo "parent 1"
qtlseq -o /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p1 \
       -n1 30 \
       -n2 30 \
       -w 100 \
       -s 20 \
       -t 20 \
       -r /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Bvulgarisssp_vulgaris_782_EL10.2.fa \
       -p /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/parent.0000.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/parent.0000.2.trim.fastq.gz \
       -b1 /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk1.0000.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk1.0000.2.trim.fastq.gz \
       -b2 /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk2.0000.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk2.0000.2.trim.fastq.gz \
       --species Arabidopsis \
       --mem 6G


echo "parent 2"
qtlseq -o /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p2 \
       -n1 30 \
       -n2 30 \
       -w 100 \
       -s 20 \
       -t 20 \
       -r /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Bvulgarisssp_vulgaris_782_EL10.2.fa \
       -p /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/parent.0001.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/parent.0001.2.trim.fastq.gz \
       -b1 /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk1.0000.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk1.0000.2.trim.fastq.gz \
       -b2 /proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk2.0000.1.trim.fastq.gz,/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/qtlseq_analysis_run_4/00_fastq/bulk2.0000.2.trim.fastq.gz \
       --species Arabidopsis \
       --mem 6G

echo "qtlseq jobs are finished at: $(date)"

echo "qtlplot jobs are started at: $(date)"

qtlplot -v /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p1/30_vcf/qtlseq.vcf.gz \
        -o /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_qplot_p1 \
        -n1 30 \
        -n2 30 \
        -w 2000 \
        -s 100 \
        -t 2 \
        -m 0.4 \
        --igv \
        --fig-width 15 \
        --fig-height 8.0


qtlplot -v /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p2/30_vcf/qtlseq.vcf.gz \
        -o /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_qplot_p2 \
        -n1 30 \
        -n2 30 \
        -w 2000 \
        -s 100 \
        -t 2 \
        -m 0.4 \
        --igv \
        --fig-width 15 \
        --fig-height 8.0        

echo "qtlplot jobs are finished at: $(date)"

echo "All jobs are finished at: $(date)"
