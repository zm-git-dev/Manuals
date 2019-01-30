## samtools
### [samtools Tutorial](http://quinlanlab.org/tutorials/samtools/samtools.html)

### split bam files
view header of bam
```
samtools view -H T01.sorted.bam
```

eidt the header
```
for BAM in *.bam
do
     samtools view -H $BAM > header.sam
     sed "s/Solid5500XL/Solid/" header.sam > header_corrected.sam
     samtools reheader  header_corrected.sam $BAM
done
```
or 
```
samtools view -H $BAM | sed "s/Solid5500XL/Solid/" | samtools reheader - $BAM
```


```
samtools view in.bam chr1 -b > out.bam
```

```
bamtools split -in file.bam -reference
```


### samtools functions
```
samtools view -bt ref_list.txt -o aln.bam aln.sam.gz

samtools sort -T /tmp/aln.sorted -o aln.sorted.bam aln.bam

samtools index aln.sorted.bam

samtools idxstats aln.sorted.bam

samtools flagstat aln.sorted.bam

samtools stats aln.sorted.bam

samtools bedcov aln.sorted.bam

samtools depth aln.sorted.bam

samtools view aln.sorted.bam chr2:20,100,000-20,200,000

samtools merge out.bam in1.bam in2.bam in3.bam

samtools faidx ref.fasta

samtools tview aln.sorted.bam ref.fasta

samtools split merged.bam

samtools quickcheck in1.bam in2.cram

samtools dict -a GRCh38 -s "Homo sapiens" ref.fasta

samtools fixmate in.namesorted.sam out.bam

samtools mpileup -C50 -gf ref.fasta -r chr3:1,000-2,000 in1.bam in2.bam

samtools flags PAIRED,UNMAP,MUNMAP

samtools fastq input.bam > output.fastq

samtools fasta input.bam > output.fasta

samtools addreplacerg -r 'ID:fish' -r 'LB:1334' -r 'SM:alpha' -o output.bam input.bam

samtools collate aln.sorted.bam aln.name_collated.bam

samtools depad input.bam

samtools markdup in.algnsorted.bam out.bam
```
