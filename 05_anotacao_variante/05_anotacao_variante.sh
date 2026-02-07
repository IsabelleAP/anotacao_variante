mkdir -p databases
cd databases

wget https://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/weekly/clinvar.vcf.gz
wget https://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/weekly/clinvar.vcf.gz.tbi

bcftools view clinvar.vcf.gz -r 20 -o clinvar_chr20.vcf

vt decompose clinvar_chr20.vcf -o clinvar_chr20.decomp.vcf

echo -e "20\tNC_000020.11" > mapa.txt

bcftools annotate \
--rename-chrs mapa.txt \
clinvar_chr20.decomp.vcf \
-o clinvar_chr20.renamed.vcf

vt normalize clinvar_chr20.renamed.vcf \
-r ../../02_genoma_ref/referencias/GRCh38_chr20.fasta \
-o clinvar_chr20.norm.vcf

bgzip clinvar_chr20.norm.vcf

tabix -p vcf clinvar_chr20.norm.vcf.gz

bcftools annotate \
../../04_chamada_variante/Art_variants_norm.vcf.gz \
-a clinvar_chr20.norm.vcf.gz \
-c INFO/CLNREVSTAT,INFO/CLNSIG,INFO/CLNSIGCONF \
-o Art_annotated.vcf

### anotação com VEP
vep \
--input_file ../../04_chamada_variante/Art_variants_norm.vcf.gz \
--assembly GRCh38 \
--fasta ../../02_genoma_ref/referencias/GRCh38_chr20.fasta \
--custom file=clinvar_chr20.norm.vcf.gz,format=vcf,short_name=clinvar,type=exact,fields=CLNREVSTAT%CLNSIG%CLNSIGCONF \
--format vcf \
--force_overwrite \
--tab \
--output_file Art_vep.tsv
