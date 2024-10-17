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

