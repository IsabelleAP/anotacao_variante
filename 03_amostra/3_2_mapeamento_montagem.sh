zcat R1_clean.fastq.gz | head -200000 > R1_mini.fastq
zcat R2_clean.fastq.gz | head -200000 > R2_mini.fastq

### fiz dentro da pasta referencias
bwa index GRCh38_chr20.fasta

mkdir -p outputs/3_2_mapeamento

bwa mem -t 2 GRCh38_chr20.fasta \
../../03_amostra/R1_mini.fastq \
../../03_amostra/R2_mini.fastq | \
samtools sort -o /outputs/3_2_mapeamento/Art_sorted.bam

samtools index /outputs/3_2_mapeamento/Art_sorted.bam





