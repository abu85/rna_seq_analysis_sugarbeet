# running nf-core/rnaseq with BMYV resistant and sessecptilble samples (only with Old 21DPI inoculated replicates) on EL10_2 reference genomes
## 2024-10-17

cd /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

storage become full, so deleted work folder from /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/ re run

ml bioinfo-tools Nextflow

tmux new -s rna_seq_el10

export NXF_OPTS='-Xms1g -Xmx4g'

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

export NXF_HOME=/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/

export NXF_TEMP=${SNIC_TMP:-$HOME/glob/nxftmp}
update: nextflow pull nf-core/rnaseq

New run with bam_csi_index true and save_align_intermeds

#### 2010-10-18
### run 1
nextflow run nf-core/rnaseq \
-r 3.16.1 -profile uppmax \
-w work_21dpi \
-params-file el10_nf-params_star.json \
--max_cpus 20 \
--max_memory 128.GB \
--project naiss2023-22-1096 \
--skip_pseudo_alignment \
--aligner "star_salmon" \
--save_align_intermeds \
--fasta "/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Phytozome/PhytozomeV13/Bvulgarisssp_vulgaris/EL10.2_2/assembly/Bvulgarisssp_vulgaris_782_EL10.2.fa.gz" \
--gff "/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Phytozome/PhytozomeV13/Bvulgarisssp_vulgaris/EL10.2_2/annotation/Bvulgarisssp_vulgaris_782_EL10.2_2.gene.gff.gz" \
--bam_csi_index true > log1_bmyv_o_21dpi_i.txt


### run 2
nextflow run nf-core/rnaseq -r 3.16.1 -profile uppmax -w work_21dpi -params-file el10_nf-params_star.json --max_cpus 20 --max_memory 128.GB --project naiss2023-22-1096 --skip_pseudo_alignment --aligner "star_salmon" --save_align_intermeds --fasta "/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Phytozome/PhytozomeV13/Bvulgarisssp_vulgaris/EL10.2_2/assembly/Bvulgarisssp_vulgaris_782_EL10.2.fa.gz" --gff "/proj/uppstore2018171/abu/vinitha_qtl/qtlseq_analysis/Phytozome/PhytozomeV13/Bvulgarisssp_vulgaris/EL10.2_2/annotation/Bvulgarisssp_vulgaris_782_EL10.2_2.gene.gff.gz" --bam_csi_index true -bg -resume > log2_bmyv_o_21dpi_i.txt

finished successfully!!

# Concensus for both res and sus sample
## 2024-11-01
working dir: /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus

```
#!/bin/bash -l
#SBATCH -A naiss2024-22-1110
#SBATCH -M rackham
#SBATCH -t 02-24:00:00
#SBATCH -p core
#SBATCH -n 16
#SBATCH --job-name=cons
#SBATCH --output=cons.out
#SBATCH --error=cons.err

# Load necessary modules
ml bioinfo-tools samtools/1.2 bcftools/1.20

# Define variables
REFERENCE_GENOME="/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/genome/Bvulgarisssp_vulgaris_782_EL10.2.fa"
REGION="EL10_2_Chr4:60350684-60355128"

# Group 1 BAM files
BAM_FILES_GROUP1=(
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-67_S236_L004.sorted.bam"
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-69_S238_L004.sorted.bam"
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-71_S240_L004.sorted.bam"
)

# Group 2 BAM files
BAM_FILES_GROUP2=(
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-73_S242_L004.sorted.bam"
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-75_S244_L004.sorted.bam"
    "/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/star_salmon/UK-3126-BMYV-77_S246_L004.sorted.bam"
)


# Function to generate consensus for a group
generate_consensus() {
    local group_id=$1
    shift
    local bam_files=("$@")
    local merged_bam="merged_group${group_id}.bam"
    local output_vcf="output_variants_group${group_id}.vcf"
    local output_consensus="consensus_sequence_group${group_id}.fasta"

    # Merge BAM files
    samtools merge -f $merged_bam "${bam_files[@]}"

    # Generate a pileup and call variants
    samtools mpileup -uf $REFERENCE_GENOME -r $REGION $merged_bam | bcftools call -c - > $output_vcf

    # Create consensus sequence
    cat $REFERENCE_GENOME | bcftools consensus $output_vcf > $output_consensus

    echo "Consensus sequence for group ${group_id} generated: $output_consensus"
}

# Generate consensus for both groups
generate_consensus 1 "${BAM_FILES_GROUP1[@]}"
generate_consensus 2 "${BAM_FILES_GROUP2[@]}"
```

# 2024-11-18
Consensus making from genomic parents

working dir: /proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/consensus_from_genomic_data

```
#!/bin/bash -l
#SBATCH -A naiss2024-22-1110
#SBATCH -M rackham
#SBATCH -t 02-24:00:00
#SBATCH -p core
#SBATCH -n 2
#SBATCH --job-name=cons_genomes_both_parents
#SBATCH --output=cons_genomes_both_parents.out
#SBATCH --error=cons_genomes_both_parents.err

# Load necessary modules
ml bioinfo-tools samtools/1.2 bcftools/1.20 seqtk/1.2-r101

# Define variables
REFERENCE_GENOME="/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/genome/Bvulgarisssp_vulgaris_782_EL10.2.fa"
REGION="EL10_2_Chr4:60350684-60355128"

# Parent 1 BAM file
BAM_FILE_PARENT1="/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p1/20_bam/parent.bam"

# Parent 2 BAM file
BAM_FILE_PARENT2="/proj/snic2021-23-442/nobackup/rna_seq/nxf/new_beet/new_launch/new_env_22_10_25/results_el10_2_star_BMYV_O_21_DPI_I/consensus/qtlseq_analysis_run_5_updated_p2/20_bam/parent.bam"

# Generate consensus for Parent 1
samtools mpileup -uf $REFERENCE_GENOME -r $REGION $BAM_FILE_PARENT1 > parent1.mpileup
bcftools call -c -Ov parent1.mpileup > parent1.vcf
vcfutils.pl vcf2fq parent1.vcf > parent1.fq
seqtk seq -A parent1.fq > parent1.consensus.from.genomic.data.fa

# Generate consensus for Parent 2
samtools mpileup -uf $REFERENCE_GENOME -r $REGION $BAM_FILE_PARENT2 > parent2.mpileup
bcftools call -c -Ov parent2.mpileup > parent2.vcf
vcfutils.pl vcf2fq parent2.vcf > parent2.fq
seqtk seq -A parent2.fq > parent2.consensus.from.genomic.data.fa

echo "All jobs are finished at: $(date)"
```
