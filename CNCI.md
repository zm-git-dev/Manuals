
## The use of CNCI
### Convert the refernece genome to binary format
First use faToTwoBit, which is in the software blat, to conver the reference genome to the binary format
```
/home/wzk/bin/x86_64/faToTwoBit /home/genome/human/Homo_sapiens.GRCh38.fa /home/wzk/test_cufflinks/cuffcompare/CNCI_test/Homo_sapiens.GRCh38.fa.2bit
```
### Creat the index (method one)

Then calculate CNCI index based on the given *.gtf* file and the *.2bit* reference genome file 
```
python /home/soft/CNCI-master/CNCI.py --gtf -f /home/wzk/test_cufflinks/cuffcompare/CNCI_test/compared.combined-1.gtf -o /home/wzk/test_cufflinks/cuffcompare/CNCI_test/CNCI  -d /home/wzk/test_cufflinks/cuffcompare/CNCI_test/Homo_sapiens.GRCh38.fa.2bit  -p 10 -m ve
```
* --gtf -f: If the given file is a *.gtf* file, use the argument as this format.
* -o: The output dir, you cannot use this name if the dir wth this name exists. And the result file 'CNCI.index' will be created in this dir.
* -d: The reference genome with *.2bit* formt. 

The result file 'CNCI.index' is like this:
```
Transcript ID   index   score   start   end     length
TCONS_00000001  noncoding       -0.02048        0       237     1657
TCONS_00000002  noncoding       -0.0167936      72      447     632
```
And this time two files with the suffix of *'.bed'* and *.fa* were also created

### Filt the novel transcripts

```
python /home/soft/CNCI-master/filter_novel_lincRNA.py -i  /home/wzk/test_cufflinks/cuffcompare/CNCI_test/CNCI/CNCI.index  -g compared.combined-1.gtf  -s 0 -l 200 -e 2 -o /home/wzk/test_cufflinks/cuffcompare/CNCI_test/result
```
* -i: The file CNCI.index which was created in the above step
* -g: The input  *.gtf* file same as above
* -s:
* -l: Filte the transcript length less than the given number
* -e: Filte the transcript exon number less than this number
* -o: The output dir which contain the results (ambiguous_genes.gtf, compare_2_infor.txt, filter_out_noncoding.gtf, novel_coding.gtf, novel_lincRNA.gtf)
