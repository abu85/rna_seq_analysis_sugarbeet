# rna_seq_analysis_sugarbeet
## main command line

```nextflow run nf-core/rnaseq \
-r 3.9 -name ref_beet_full_run_2022_11_28 \
-profile uppmax \
-params-file el10_nf-params.json \
--max_cpus 20 \
--max_memory 128.GB \
--project snic2022-22-816 \
-bg
```

