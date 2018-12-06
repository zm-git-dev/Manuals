
## [CheckM](https://github.com/Ecogenomics/CheckM/wiki/Workflows)

### [CheckM wiki](https://github.com/Ecogenomics/CheckM/wiki)

### [Installation](https://github.com/Ecogenomics/CheckM/wiki/Installation)



```
# install
$ conda install checkm-genome
$ conda install hmmer
$ conda install prodigal
$ conda install pplacer
```


CheckM relies on a number of precalculated data files which can be downloaded from https://data.ace.uq.edu.au/public/CheckM_databases/. Decompress the file to an appropriate folder and run **checkm data setRoot** to inform CheckM of where the files have been placed.

```
$ checkm data setRoot

*******************************************************************************
 [CheckM - data] Check for database updates. [setRoot]
*******************************************************************************

Where should CheckM store it's data?
Please specify a location or type 'abort' to stop trying: 
/home/wzk/anaconda3/envs/qiime/database/checkm/

Path [/home/wzk/anaconda3/envs/qiime/database/checkm] exists and you have permission to write to this folder.
(re) creating manifest file (please be patient).

Data location successfully changed to: /home/wzk/anaconda3/envs/qiime/database/checkm
```


```
$ tree /home/wzk/anaconda3/envs/qiime/database/checkm/
/home/wzk/anaconda3/envs/qiime/database/checkm/
├── checkm_data_v1.0.7.tar.gz
├── distributions
│   ├── cd_dist.txt
│   ├── gc_dist.txt
│   └── td_dist.txt
├── genome_tree
│   ├── genome_tree.derep.txt
│   ├── genome_tree_full.refpkg
│   │   ├── CONTENTS.json
│   │   ├── genome_tree.fasta
│   │   ├── genome_tree.log
│   │   ├── genome_tree.tre
│   │   └── phylo_modelEcOyPk.json
│   ├── genome_tree.metadata.tsv
│   ├── genome_tree_reduced.refpkg
│   │   ├── CONTENTS.json
│   │   ├── genome_tree.fasta
│   │   ├── genome_tree.log
│   │   ├── genome_tree.tre
│   │   └── phylo_modelJqWx6_.json
│   ├── genome_tree.taxonomy.tsv
│   ├── missing_duplicate_genes_50.tsv
│   └── missing_duplicate_genes_97.tsv
├── hmms
│   ├── checkm.hmm
│   ├── checkm.hmm.ssi
│   ├── phylo.hmm
│   └── phylo.hmm.ssi
├── hmms_ssu
│   ├── createHMMs.py
│   ├── SSU_archaea.hmm
│   ├── SSU_bacteria.hmm
│   └── SSU_euk.hmm
├── img
│   └── img_metadata.tsv
├── pfam
│   ├── Pfam-A.hmm.dat
│   └── tigrfam2pfam.tsv
├── selected_marker_sets.tsv
├── taxon_marker_sets.tsv
└── test_data
    └── 637000110.fna

```

### Workflow

```
Lineage-specific Workflow
The recommended workflow for assessing the completeness and contamination of genome bins is to use lineage-specific marker sets. This workflow consists of 4 mandatory (M) steps and 1 recommended (R) step:

(M) > checkm tree <bin folder> <output folder>
(R) > checkm tree_qa <output folder>
(M) > checkm lineage_set <output folder> <marker file>
(M) > checkm analyze <marker file> <bin folder> <output folder>
(M) > checkm qa <marker file> <output folder>
The tree command places genome bins into a reference genome tree. All genomes to be analyzed must reside in a single bins directory. CheckM assumes genome bins are in FASTA format with the extension fna, though this can be changed with the –x flag. The treecommand can optionally be followed by the tree_qa command which will indicate the number of phylogenetically informative marker genes found in each genome bin along with a taxonomic string indicating its approximate placement in the tree. If desired, genome bins with few phylogenetically marker genes may be removed in order to reduce the computational requirements of the following commands. Alternatively, if only genomes from a particular taxonomic group are of interest these can be moved to a new directory and analyzed separately. The lineage_set command creates a marker file indicating lineage-specific marker sets suitable for evaluating each genome. This marker file is passed to the analyze command in order to identify marker genes and estimate the completeness and contamination of each genome bin. Finally, the qa command can be used to produce different tables summarizing the quality of each genome bin.

For convenience, the above workflow can be executed in a single step:
```

> checkm lineage_wf <bin folder> <output folder>

Taxonomic-specific Workflow
In some cases it is convenient to analyze all genome bins with the same marker set. A common example would be a set of genomes from the same taxonomic group. The workflow for using a taxonomic-specific marker set consists of 3 mandatory (M) steps and 1 recommended (R) step:

(R) > checkm taxon_list 
(M) > checkm taxon_set <rank> <taxon> <marker file>
(M) > checkm analyze <marker file> <bin folder> <output folder>
(M) > checkm qa <marker file> <output folder>
The taxon_list command produces a table indicating all taxa for which a marker set can be produced. All support taxa at a given taxonomic rank can be produced by passing taxon_list the --rank flag:

> checkm taxon_list --rank phylum

The taxon_set command is used to produce marker sets for a specific taxon:

> checkm taxon_set phylum Cyanobacteria cyanobacteria.ms

The marker file produced by the taxon_set command is passed to the analyze command in order to identify marker genes within each genome bin and estimate completeness and contamination. All putative genomes to be analyzed must reside in a single bins directory. CheckM assumes genomes are in FASTA format with the extension ‘fna’, though this can be changed with the –x flag. Finally, the qa command can be used to produce different tables summarizing the quality of each genome bin.

For convenience, the above workflow can be executed in a single step:

> checkm taxonomy_wf <rank> <taxon> <bin folder> <output folder>

Using Custom Marker Genes
CheckM supports using custom marker genes for assessing genome completeness and contamination. The desired marker genes must be specified as hidden markov models (HMMs) constructed with HMMER. Genome quality can be assessed using these marker genes as follows:

> checkm analyze <custom HMM file> <bin folder> <output folder>
> checkm qa <custom HMM file> <output folder>
This HMM file is passed to the analyze command in order to identify marker genes and estimate the completeness and contamination of each genome bin. Finally, the qa command can be used to produce different tables summarizing the quality of each genome bin.


### Run checkm
```
$ checkm lineage_wf BINSANITY-INITIAL BinSanityWf_binsanity_checkm2 --threads 10 --pplacer_threads 20

*******************************************************************************
 [CheckM - tree] Placing bins in reference genome tree.
*******************************************************************************

  Identifying marker genes in 8 bins with 10 threads:
    Finished processing 8 of 8 (100.00%) bins.
  Saving HMM info to file.

  Calculating genome statistics for 8 bins with 10 threads:
    Finished processing 8 of 8 (100.00%) bins.

  Extracting marker genes to align.
  Parsing HMM hits to marker genes:
    Finished parsing hits for 8 of 8 (100.00%) bins.
  Extracting 43 HMMs with 10 threads:
    Finished extracting 43 of 43 (100.00%) HMMs.
  Aligning 43 marker genes with 10 threads:
    Finished aligning 43 of 43 (100.00%) marker genes.

  Reading marker alignment files.
  Concatenating alignments.
  Placing 8 bins into the genome tree with pplacer (be patient).

  { Current stage: 0:04:29.091 || Total: 0:04:29.091 }

*******************************************************************************
 [CheckM - lineage_set] Inferring lineage-specific marker sets.
*******************************************************************************

  Reading HMM info from file.
  Parsing HMM hits to marker genes:
    Finished parsing hits for 8 of 8 (100.00%) bins.

  Determining marker sets for each genome bin.
    Finished processing 8 of 8 (100.00%) bins (current: binsanity.contigs_simplyId_Bin-7).

  Marker set written to: BinSanityWf_binsanity_checkm2/lineage.ms

  { Current stage: 0:00:02.062 || Total: 0:04:31.154 }

*******************************************************************************
 [CheckM - analyze] Identifying marker genes in bins.
*******************************************************************************

  Identifying marker genes in 8 bins with 10 threads:
    Finished processing 8 of 8 (100.00%) bins.
  Saving HMM info to file.

  { Current stage: 0:02:44.038 || Total: 0:07:15.192 }

  Parsing HMM hits to marker genes:
    Finished parsing hits for 8 of 8 (100.00%) bins.
  Aligning marker genes with multiple hits in a single bin:
    Finished processing 8 of 8 (100.00%) bins.

  { Current stage: 0:00:05.213 || Total: 0:07:20.406 }

  Calculating genome statistics for 8 bins with 10 threads:
    Finished processing 8 of 8 (100.00%) bins.

  { Current stage: 0:00:00.178 || Total: 0:07:20.584 }

*******************************************************************************
 [CheckM - qa] Tabulating genome statistics.
*******************************************************************************

  Calculating AAI between multi-copy marker genes.

  Reading HMM info from file.
  Parsing HMM hits to marker genes:
    Finished parsing hits for 8 of 8 (100.00%) bins.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Bin Id                                    Marker lineage          # genomes   # markers   # marker sets    0     1    2    3   4   5+   Completeness   Contamination   Strain heterogeneity  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  binsanity.contigs_simplyId_Bin-4   o__Lactobacillales (UID544)       293         475           267         2    438   34   1   0   0       99.53            5.87               0.00          
  binsanity.contigs_simplyId_Bin-7   o__Actinomycetales (UID1530)      622         259           152         2    236   21   0   0   0       98.68            8.88               0.00          
  binsanity.contigs_simplyId_Bin-2    g__Staphylococcus (UID301)        45         940           178         14   894   31   1   0   0       97.49            2.83              61.76          
  binsanity.contigs_simplyId_Bin-3    g__Staphylococcus (UID294)        60         773           178        134   624   15   0   0   0       73.88            2.51              73.33          
  binsanity.contigs_simplyId_Bin-5    o__Clostridiales (UID1120)       304         250           143         60   190   0    0   0   0       72.73            0.00               0.00          
  binsanity.contigs_simplyId_Bin-0       k__Bacteria (UID203)          5449        104            58         97    7    0    0   0   0        8.62            0.00               0.00          
  binsanity.contigs_simplyId_Bin-6           root (UID1)               5656         56            24         56    0    0    0   0   0        0.00            0.00               0.00          
  binsanity.contigs_simplyId_Bin-1           root (UID1)               5656         56            24         56    0    0    0   0   0        0.00            0.00               0.00          
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  { Current stage: 0:00:04.046 || Total: 0:07:24.630 }

```

##### output files:
```
BinSanityWf_binsanity_checkm2
├── bins
│   ├── binsanity.contigs_simplyId_Bin-0
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-1
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-2
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-3
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-4
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-5
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   ├── binsanity.contigs_simplyId_Bin-6
│   │   ├── genes.faa
│   │   ├── genes.gff
│   │   ├── hmmer.analyze.txt
│   │   └── hmmer.tree.txt
│   └── binsanity.contigs_simplyId_Bin-7
│       ├── genes.faa
│       ├── genes.gff
│       ├── hmmer.analyze.txt
│       └── hmmer.tree.txt
├── lineage.ms
└── storage
    ├── aai_qa
    │   ├── binsanity.contigs_simplyId_Bin-2
    │   │   ├── PF00035.20.masked.faa
    │   │   ├── PF00163.14.masked.faa
    │   │   ├── PF00181.18.masked.faa
    │   │   ├── PF00258.20.masked.faa
    │   │   ├── PF00276.15.masked.faa
    │   │   ├── PF00297.17.masked.faa
    │   │   ├── PF00327.15.masked.faa
    │   │   ├── PF00338.17.masked.faa
    │   │   ├── PF00411.14.masked.faa
    │   │   ├── PF00416.17.masked.faa
    │   │   ├── PF00468.12.masked.faa
    │   │   ├── PF00573.17.masked.faa
    │   │   ├── PF00687.16.masked.faa
    │   │   ├── PF00708.13.masked.faa
    │   │   ├── PF00831.18.masked.faa
    │   │   ├── PF00883.16.masked.faa
    │   │   ├── PF01000.21.masked.faa
    │   │   ├── PF01176.14.masked.faa
    │   │   ├── PF01193.19.masked.faa
    │   │   ├── PF01553.16.masked.faa
    │   │   ├── PF02355.11.masked.faa
    │   │   ├── PF02504.10.masked.faa
    │   │   ├── PF03118.10.masked.faa
    │   │   ├── PF03947.13.masked.faa
    │   │   ├── PF05816.6.masked.faa
    │   │   ├── PF05975.7.masked.faa
    │   │   ├── PF08406.5.masked.faa
    │   │   ├── PF10112.4.masked.faa
    │   │   ├── PF13454.1.masked.faa
    │   │   ├── TIGR00517.masked.faa
    │   │   ├── TIGR01998.masked.faa
    │   │   └── TIGR03563.masked.faa
    │   ├── binsanity.contigs_simplyId_Bin-3
    │   │   ├── PF00120.19.masked.faa
    │   │   ├── PF00327.15.masked.faa
    │   │   ├── PF00627.26.masked.faa
    │   │   ├── PF01769.11.masked.faa
    │   │   ├── PF01883.14.masked.faa
    │   │   ├── PF02163.17.masked.faa
    │   │   ├── PF03951.14.masked.faa
    │   │   ├── PF05496.7.masked.faa
    │   │   ├── PF06480.10.masked.faa
    │   │   ├── PF07991.7.masked.faa
    │   │   ├── PF09953.4.masked.faa
    │   │   ├── PF12072.3.masked.faa
    │   │   ├── TIGR00562.masked.faa
    │   │   ├── TIGR00594.masked.faa
    │   │   └── TIGR02773.masked.faa
    │   ├── binsanity.contigs_simplyId_Bin-4
    │   │   ├── PF00162.14.masked.faa
    │   │   ├── PF00164.20.masked.faa
    │   │   ├── PF00177.16.masked.faa
    │   │   ├── PF00254.23.masked.faa
    │   │   ├── PF00542.14.masked.faa
    │   │   ├── PF00562.23.masked.faa
    │   │   ├── PF00623.15.masked.faa
    │   │   ├── PF00749.16.masked.faa
    │   │   ├── PF00763.18.masked.faa
    │   │   ├── PF01272.14.masked.faa
    │   │   ├── PF02882.14.masked.faa
    │   │   ├── PF03449.10.masked.faa
    │   │   ├── PF03948.9.masked.faa
    │   │   ├── PF04560.15.masked.faa
    │   │   ├── PF04561.9.masked.faa
    │   │   ├── PF04563.10.masked.faa
    │   │   ├── PF04565.11.masked.faa
    │   │   ├── PF04983.13.masked.faa
    │   │   ├── PF04997.7.masked.faa
    │   │   ├── PF04998.12.masked.faa
    │   │   ├── PF05000.12.masked.faa
    │   │   ├── PF05697.8.masked.faa
    │   │   ├── PF05698.9.masked.faa
    │   │   ├── PF06689.8.masked.faa
    │   │   ├── PF10385.4.masked.faa
    │   │   ├── PF13507.1.masked.faa
    │   │   ├── PF13597.1.masked.faa
    │   │   ├── TIGR00409.masked.faa
    │   │   ├── TIGR00419.masked.faa
    │   │   ├── TIGR00499.masked.faa
    │   │   ├── TIGR00737.masked.faa
    │   │   ├── TIGR00753.masked.faa
    │   │   ├── TIGR01134.masked.faa
    │   │   ├── TIGR02491.masked.faa
    │   │   └── TIGR03598.masked.faa
    │   └── binsanity.contigs_simplyId_Bin-7
    │       ├── PF01132.15.masked.faa
    │       ├── PF01245.15.masked.faa
    │       ├── PF01330.16.masked.faa
    │       ├── PF01709.15.masked.faa
    │       ├── PF01715.12.masked.faa
    │       ├── PF01725.11.masked.faa
    │       ├── PF01782.13.masked.faa
    │       ├── PF02631.11.masked.faa
    │       ├── PF02978.14.masked.faa
    │       ├── PF05491.8.masked.faa
    │       ├── PF06778.7.masked.faa
    │       ├── PF07499.8.masked.faa
    │       ├── PF08207.7.masked.faa
    │       ├── PF09285.6.masked.faa
    │       ├── TIGR00019.masked.faa
    │       ├── TIGR00064.masked.faa
    │       ├── TIGR00096.masked.faa
    │       ├── TIGR00392.masked.faa
    │       ├── TIGR01574.masked.faa
    │       ├── TIGR01966.masked.faa
    │       └── TIGR03594.masked.faa
    ├── bin_stats.analyze.tsv
    ├── bin_stats_ext.tsv
    ├── bin_stats.tree.tsv
    ├── checkm_hmm_info.pkl.gz
    ├── marker_gene_stats.tsv
    ├── phylo_hmm_info.pkl.gz
    └── tree
        ├── concatenated.fasta
        ├── concatenated.pplacer.json
        ├── concatenated.tre
        ├── PF00164.20.masked.faa
        ├── PF00177.16.masked.faa
        ├── PF00181.18.masked.faa
        ├── PF00189.15.masked.faa
        ├── PF00203.16.masked.faa
        ├── PF00237.14.masked.faa
        ├── PF00238.14.masked.faa
        ├── PF00252.13.masked.faa
        ├── PF00276.15.masked.faa
        ├── PF00281.14.masked.faa
        ├── PF00297.17.masked.faa
        ├── PF00298.14.masked.faa
        ├── PF00312.17.masked.faa
        ├── PF00318.15.masked.faa
        ├── PF00333.15.masked.faa
        ├── PF00366.15.masked.faa
        ├── PF00380.14.masked.faa
        ├── PF00410.14.masked.faa
        ├── PF00411.14.masked.faa
        ├── PF00466.15.masked.faa
        ├── PF00562.23.masked.faa
        ├── PF00572.13.masked.faa
        ├── PF00573.17.masked.faa
        ├── PF00623.15.masked.faa
        ├── PF00673.16.masked.faa
        ├── PF00687.16.masked.faa
        ├── PF00831.18.masked.faa
        ├── PF00861.17.masked.faa
        ├── PF01192.17.masked.faa
        ├── PF01509.13.masked.faa
        ├── PF02978.14.masked.faa
        ├── PF03719.10.masked.faa
        ├── PF03946.9.masked.faa
        ├── PF03947.13.masked.faa
        ├── PF04560.15.masked.faa
        ├── PF04561.9.masked.faa
        ├── PF04563.10.masked.faa
        ├── PF04565.11.masked.faa
        ├── PF04997.7.masked.faa
        ├── PF05000.12.masked.faa
        ├── PF11987.3.masked.faa
        ├── pplacer.out
        ├── TIGR00344.masked.faa
        └── TIGR00422.masked.faa

16 directories, 189 files

```