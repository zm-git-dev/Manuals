## [kaiju](https://github.com/bioinformatics-centre/kaiju): Fast taxonomic classification of metagenomic sequencing reads using a protein reference database


### install kaiju
```
$ conda install -c bioconda kaiju
```

### Creating the reference database and index

```
$ mkdir kaijudb
$ cd kaijudb
$ makeDB.sh [-r|-p|-n|-e]
```

### Different reference

##### Complete Reference Genomes from NCBI RefSeq
```
makeDB.sh -r
```

##### Representative genomes from proGenomes

```
makeDB.sh -p
```

##### Virus Genomes from NCBI RefSeq
```
makeDB.sh -v
```

##### Non-redundant protein database nr
```
makeDB.sh -n
```

### run kaiju
```
$ kaiju -t  /home/wzk/database/kaiju/nodes.dmp -f /home/wzk/database/kaiju/kaiju_db.fmi -z 20 -i clean/SOIL_NATCOMM_25M.clean.paired.R1.fq.gz -j clean/SOIL_NATCOMM_25M.clean.paired.R2.fq.gz -o kaiju/kaiju
```

##### output file:
```
$ head kaiju/kaiju 
C	SRR908279.25002	1224
C	SRR908279.25073	710696
U	SRR908279.25133	0
C	SRR908279.25146	1736675
C	SRR908279.25172	1912856
U	SRR908279.25188	0
U	SRR908279.25212	0
U	SRR908279.25228	0
C	SRR908279.25240	2
U	SRR908279.25271	0
```


### kaiju report
```
$ kaijuReport   -t  /home/wzk/database/kaiju/nodes.dmp -n  /home/wzk/database/kaiju/names.dmp  -i kaiju/kaiju  -r species  -u -p -o kaiju/kaiju.report.txt

```

output file:
```
$ head  kaiju/kaiju.report.txt
        %	    reads	species
-------------------------------------------
 0.965068	     3981	cellular organisms; Bacteria; Proteobacteria; Alphaproteobacteria; Rhizobiales; Hyphomicrobiaceae; Devosia; Devosia sp. A16; 
 0.833434	     3438	cellular organisms; Bacteria; Terrabacteria group; Actinobacteria; Actinobacteria; Corynebacteriales; Gordoniaceae; Gordonia; Gordonia polyisoprenivorans; 
 0.816223	     3367	cellular organisms; Bacteria; Terrabacteria group; Actinobacteria; Actinobacteria; Propionibacteriales; Nocardioidaceae; Nocardioides; Nocardioides sp. JS614; 
 0.809435	     3339	cellular organisms; Bacteria; Proteobacteria; Alphaproteobacteria; Rhizobiales; Rhizobiaceae; Rhizobium/Agrobacterium group; Neorhizobium; Neorhizobium galegae; 
 0.708589	     2923	cellular organisms; Bacteria; Proteobacteria; Alphaproteobacteria; Rhizobiales; Rhizobiaceae; Rhizobium/Agrobacterium group; Rhizobium; Rhizobium sp. NT-26; 
 0.693559	     2861	cellular organisms; Bacteria; Terrabacteria group; Actinobacteria; Thermoleophilia; Solirubrobacterales; Conexibacteraceae; Conexibacter; Conexibacter woesei; 
 0.677317	     2794	cellular organisms; Bacteria; Proteobacteria; Alphaproteobacteria; Rhizobiales; Hyphomicrobiaceae; Devosia; Devosia sp. H5989; 
 0.673923	     2780	cellular organisms; Bacteria; Terrabacteria group; Actinobacteria; Actinobacteria; Propionibacteriales; Nocardioidaceae; Pimelobacter; Pimelobacter simplex;
 ```
 