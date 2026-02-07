wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR031/ERR031967/ERR031967_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR031/ERR031967/ERR031967_2.fastq.gz

### Executar o fastp
mkdir -p outputs/01_qc

fastp \
    -i ERR031967_1.fastq.gz \
    -I ERR031967_2.fastq.gz \
    -o R1_clean.fastq.gz \
    -O R2_clean.fastq.gz \
    -h outputs/01_qc/art.fastp.html \
    -j outputs/01_qc/art.fastp.json \
    --detect_adapter_for_pe \
    --thread 1 \
    -l 75 \
    --cut_front \
    --cut_tail \
    --cut_mean_quality 30