
### How to efficiently remove a list of reads from BAM file?

```
samtools view -h sample1.bam | grep -vf read_ids_to_remove.txt | samtools view -bS -o sample1_filter.bam -​
```


### [FilterSamReads](https://broadinstitute.github.io/picard/command-line-overview.html#FilterSamReads)
```
java -jar picard.jar FilterSamReads \
       I=input.bam \ 
       O=output.bam \
       READ_LIST_FILE=read_names.txt      FILTER=filter_value
```



```
java -Xmx30g -jar /home/wzk/anaconda3/envs/evolution/bin/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /home/wzk/database/GENOME/Brassica_rapa/chrs/Brapa_sequence_v1.5_chrs.fa -I /home/wzk/Project/C100/mapping/R4/R4_realigned.bam -o /home/wzk/Project/C100/VCF/R4.vcf -nct 8 -glm BOTH -mbq 20 --genotyping_mode DISCOVERY  --filter_mismatching_base_and_quals  -rf DuplicateRead -rf FailsVendorQualityCheck -rf NotPrimaryAlignment \ -rf BadMate -rf  MappingQualityUnavailable -rf UnmappedRead -rf BadCigar 
```


### Call SNV by freebayes

```
freebayes -f /home/wzk/database/GENOME/arabidopsis/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -L bam_files.txt > MT___Ler.vcf
```

### [samtools mpileup](http://samtools.sourceforge.net/mpileup.shtml)

### Call SNV by samtools
```
 samtools mpileup -ugf /home/wzk/database/GENOME/arabidopsis/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -t AD -t DP -t SP /home/wzk/Project/C075/mapping/MT/MT_realigned.bam /home/wzk/Project/C075/mapping/Ler/Ler_realigned.bam  | bcftools call -vmO z -o  MT___Ler_samtools.vcf
```


### GATK ploidy

Set the parameter **ploidy** to 1 if it is a virus genome 
```
$ java -Xmx30g -jar /home/wzk/anaconda3/envs/evolution/bin/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /home/genome/Bacillus_virus/GCF_000837685.1_ViralProj14034_genomic.fa -I mapping/DR1/DR1_realigned.bam  -ploidy 1  -o /home/wzk/DR1.vcf 
```

