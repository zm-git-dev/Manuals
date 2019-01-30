# 基因功能注释

## 基于基因序列注释

### 基因核酸序列比对

首先利用**diamond** 将序列比对到**uniprot**蛋白质数据库
```
$ diamond blastx --db /home/wzk/database/uniprot/uniprot_trembl.dmnd  --query /home/wzk/database/GENOME/GDDH/GDDH13.gene.fa   --threads 20 --evalue 0.00001 --max-target-seqs 1 --out /home/wzk/database/GENOME/GDDH/GDDH13.gene__diamond_out.txt --outfmt 6 qseqid sseqid  evalue qlen length pident mismatch gapopen qstart qend sstart send  stitle 
```

* db：比对的数据库，首先需要用diamond构建蛋白质序列的索引文件，**构建数据库的diamond版本必须和比对的版本一直，否则会报错**
* query：需要比对的序列，核酸序列使用diamond的**blastx**模式的比对，蛋白质序列需要使用**blastp**模式比对
* threads：线程数
* evalue：比对evalue的阈值
* max-target-seqs：最优比对结果的数目数
* out：输出结果文件
* outfmt：输出结果格式，6表示和blast类似的表格输出，其中列名分别为**qseqid sseqid  evalue qlen length pident mismatch gapopen qstart qend sstart send  stitle**


The output of diamond:
```
$ head -n 5 /home/wzk/database/GENOME/GDDH/GDDH13.gene__diamond_out.txt
MD03G1220500    tr|A0A251PMS2|A0A251PMS2_PRUPE  2.5e-55 660 155 76.1    37  0   45  509 1    155    tr|A0A251PMS2|A0A251PMS2_PRUPE Uncharacterized protein OS=Prunus persica GN=PRUPE_4G188200 PE=4 SV=1
MD16G1261800    tr|A0A0L9UWY2|A0A0L9UWY2_PHAAN  2.4e-36 473 137 63.5    47  1   54  464 55   188    tr|A0A0L9UWY2|A0A0L9UWY2_PHAAN Uncharacterized protein OS=Phaseolus angularis GN=LR48_Vigan07g078100 PE=4 SV=1
MD07G1188700    tr|M5X1E6|M5X1E6_PRUPE  1.3e-169    948 315 89.2    34  0   1   945 1    315    tr|M5X1E6|M5X1E6_PRUPE Uncharacterized protein OS=Prunus persica GN=PRUPE_2G226400 PE=4 SV=1
MD05G1310200    tr|A0A251PG33|A0A251PG33_PRUPE  0.0e+00 6023    1695    84.4    245 11  438 5489    34   1720   tr|A0A251PG33|A0A251PG33_PRUPE Uncharacterized protein OS=Prunus persica GN=PRUPE_4G052600 PE=4 SV=1
MD03G1193400    tr|A0A251PPE1|A0A251PPE1_PRUPE  1.2e-53 973 198 63.1    63  3   97  663 1    197    tr|A0A251PPE1|A0A251PPE1_PRUPE Uncharacterized protein OS=Prunus persica GN=PRUPE_4G223100 PE=4 SV=1
```

### 基于比对结果获取基因注释

运行流程**Pep2AnnoDB.pipeline.py**
```
$ snakemake -s Pep2AnnoDB.pipeline.py  --configfile Pep2AnnoDB.pipeline.yaml -j 20
```


### Annotation2GO



```
rule Annotation2GO:
    input:
        annotation = IN_PATH + '/Annotation/result/{sample}_GeneAnno_description.xls',
    output:
        gene_GO = IN_PATH + '/Annotation/result/{sample}_gene_GOs.xls',
        GO_gene = IN_PATH + '/Annotation/result/{sample}_GO_genes.xls',
    params:
        Annotation2GeneGO = SCR_DIR + "/Annotation2GeneGO.py",
    log:
        IN_PATH + '/log/Annotation2GO_{sample}.log'        
    run:
        shell("python {params.Annotation2GeneGO} --annotation {input.annotation} --gene {output.gene_GO} --GO {output.GO_gene} >{log} 2>&1")
```

GeneAnno_description file
```shell
$ head -n 3 Solanum_tuberosum_GeneAnno_description.xls
Gene    Chr Start   End Strand  Symbol  Biotype Description uniprotAc   Refseq  pfam    interpro    eggNOG  GO(GO_term,class,description)   KEGG(KO,pathway,description)
PGSC0003DMG400000001    1   71266900    71269534    +   None    protein_coding  Adenosine 3'-phospho 5'-phosphosulfate transporter [Source:PGSC_GENE;Acc:PGSC0003DMG400000001]  M0ZFX9,Uncharacterized protein;M0ZFY0,Uncharacterized protein;M0ZFX8,Uncharacterized protein    -   PF08449,UAA transporter family  IPR013657,UAA transporter   KOG1582,UDP-galactose transporter related protein;COG0697,Permeases of the drug/metabolite transporter (DMT) superfamily    GO:0016020,cellular_component,membrane;GO:0016021,cellular_component,integral component of membrane;GO:0055085,biological_process,transmembrane transport   -
PGSC0003DMG400000005    1   71314568    71319702    +   None    protein_coding  Shrunken seed protein [Source:PGSC_GENE;Acc:PGSC0003DMG400000005]   M0ZFY7,Uncharacterized protein;M0ZFY5,Uncharacterized protein;M0ZFY6,Uncharacterized protein    XP_006339496.1,peroxisome biogenesis protein 16 isoform X3;XP_006339495.1,peroxisome biogenesis protein 16 isoform X1   PF08610,Peroxisomal membrane protein (Pex16)    IPR013919,Peroxisome membrane protein, Pex16    KOG4546,Peroxisomal biogenesis protein (peroxin 16);ENOG4111GEA,-   GO:0007031,biological_process,peroxisome organization;GO:0005777,cellular_component,peroxisome;GO:0005778,cellular_component,peroxisomal membrane   K13335,ko04146,Peroxisome

```

extract gene and GOs


## GO富集分析

```python


rule GOFisherTest:
    input:
        GO = IN_PATH + '/Annotation/result/{sample}_gene_GOs.xls',
        # KEGG = IN_PATH + '/{sample}_KEGG.txt',
        genes = IN_PATH + "/Annotation/result/sig_Down_genes.xls",
    output:
        GO_out = IN_PATH + '/Annotation/GO_KEGG/{sample}_GO_fisher_test.txt',
        # KEGG_out = IN_PATH + '/GO_KEGG/{sample}_KEGG_fisher_test.txt',
    params:
        genes = IN_PATH + "/Annotation/result/sig_Down_genes_list.xls",
        GOFisherExactTest = SCR_DIR + "/GOFisherExactTest.py",
        termdb_GO =  config["termdb_GO"], #'/home/wzk/database/geneontology/term.db',
        termdb_KEGG = config["KO"], #'/home/wzk/database/KOBAS/ko.db',
        gene_number = config["gene_number"],
    log:
        IN_PATH + '/log/GOFisherTest_{sample}.log'
    run:
        shell("sed  '1d' {input.genes} | cut -f 1 > {params.genes}")
        shell("python {params.GOFisherExactTest} --GO {input.GO} --gene {params.genes} --number {params.gene_number} --termdb {params.termdb_GO} --method GO --out {output.GO_out} >{log} 2>&1")
        # shell("python {params.GOFisherExactTest} --GO {input.KEGG} --gene {input.genes} --number {params.gene_number} --termdb {params.termdb_KEGG} --method KEGG --out {output.KEGG_out} >{log} 2>&1")
```


**sig_Down_genes.xls** file

```
$ head -n 3 sig_Down_genes.xls
Geneid  Ac142   etb logFC   logCPM  PValue  FDR
PGSC0003DMG400018892    44.6731601664368    208.623272976067    -2.22315702643636   6.75973690596938    1.64625526345199e-23    2.92828508853361e-22
Intron_gpII 0.806436560904015   2.96990227073663    -1.87832356775877   3.16089741930408    1.64810556438319e-10    1.04699154318285e-09
```