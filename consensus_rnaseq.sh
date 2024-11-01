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
    
    # Index the merged BAM file
    samtools index $merged_bam

    # Generate a pileup and call variants
    samtools mpileup -uf $REFERENCE_GENOME -r $REGION $merged_bam | bcftools call -c - > $output_vcf

    # Create consensus sequence
    cat $REFERENCE_GENOME | bcftools consensus $output_vcf > $output_consensus

    echo "Consensus sequence for group ${group_id} generated: $output_consensus"
}

# Generate consensus for both groups
generate_consensus 1 "${BAM_FILES_GROUP1[@]}"
generate_consensus 2 "${BAM_FILES_GROUP2[@]}"
