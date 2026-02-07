bcftools mpileup \
-f ../02_genoma_ref/referencias/GRCh38_chr20.fasta \
../03_amostra/3_2_mapeamento/Art_sorted.bam | \
bcftools call -mv -Ov -o Art_variants.vcf

bgzip Art_variants.vcf
tabix -p vcf Art_variants.vcf.gz

### decompor variantes multialélicas
vt decompose Art_variants.vcf.gz -o Art_variants_decomp.vcf

### normalizar em relação ao genoma de referência
vt normalize Art_variants_decomp.vcf \
    -r ../02_genoma_ref/referencias/GRCh38_chr20.fasta \
    -o Art_variants_norm.vcf

bgzip Art_variants_norm.vcf

tabix -p vcf Art_variants_norm.vcf.gz

