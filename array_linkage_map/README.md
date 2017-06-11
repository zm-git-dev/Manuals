### The manuals for genotyping of array

#### step1: filt the genotype
```
perl chip_geno_filter_AB_v0.1.1.pl guo_chip_AB_20170611.txt chip_filter.txt chip_stat.txt
```
output the file genotype file  *chip_filter.txt* and the statistics file *chip_stat.txt*

#### step2: construct the genetic using the genotype
* the input file don not contain the parents
* it should add the header such as:
```
population_type DH
population_name LG
distance_function kosambi
cut_off_p_value 0.000000000000000001
no_map_dist 15.0
no_map_size 2
missing_threshold 0.10
estimation_before_clustering no
detect_bad_data yes
objective_function COUNT
number_of_loci 17926
number_of_individual 280

```
* then run *MSTMap.exe*:
```
MSTMap.exe mstmap_input.txt mstmap_output.txt
```

#### step3: select the nonredundancy marker for each original bin
* need a file with all markers contain the marker name, chr, physical position, and then get the input file based on that file
* 'chr01.txt' is like this:
```
Bn-A01-p101094	0	chrA01	2469560
Bn-A01-p101451	0	chrA01	2469917
Bn-A01-p108136	0	chrA01	2489409
Bn-A01-p146963	0	chrA01	2528825
Bn-A01-p147990	0	chrA01	2529854
Bn-Scaffold020953-p21	0	chrAnn_random	18884674
Bn-A01-p206610	0.971	chrA01	2590645
Bn-A01-p207363	0.971	chrA01	2591308
Bn-A01-p234898	0.971	chrC02	8029886
Bn-A01-p235115	0.971	chrC02	8030104
Bn-A01-p235484	0.971	chrA01	2619018
```
* then run the perl script to select nonredundancy marker
```
perl linkage_sort_v0.1.pl  input/chr01.txt output/chr01_out.txt
```
* the output file :
```
Bn-A01-p108136	0	chrA01	2489409
Bn-A01-p250759	0.971	chrA01	2628302
```

#### step4: re-construct the genetic map
* first get the genotype for the population based on the selected markers
```
cut -f 1 output/chr01_out.txt | while read marker; do sed -n '/^'"$marker"'\t.*/p' chip_filter.txt  ; done > new_selet_geno/chr01_geno.txt
```
* then add the header, parameter *cut_off_p_value* should use a high value
```
population_type DH
population_name LG
distance_function kosambi
cut_off_p_value 0.0001
no_map_dist 15.0
no_map_size 2
missing_threshold 0.10
estimation_before_clustering no
detect_bad_data yes
objective_function COUNT
number_of_loci 184
number_of_individual 268

Name	3331	3335	3337	3341	3343	3345	3347	3349	3351	3353	3355	3361	3363	3365	3369	3371	3373	3375	3379	3381	3383	3385	3387	3389	3391	3393	3395	3397	3399	3401	3403	3405	3407	3409	3411	3413	3415	3417	3419	3421	3423	25-Feb	3427	3429	3431	3433	3435	3437	3439	3441	3443	3445	3447	3449	3453	3455	3457	3459	3461	3463	3465	3467	3469	3471	3473	3475	3477	3479	3481	3483	3485	3487	3489	Feb-91	3493	3495	3497	3499	3501	3503	3505	3507	3509	3511	3513	3515	3517	3519	3521	3523	3525	3527	3529	3531	3535	3537	3539	3541	3543	3545	3547	3549	3551	3553	3555	3557	3559	3561	3563	3565	3567	3569	3571	3573	3575	3577	3579	3581	3583	3585	3587	3589	3593	3597	3599	3601	3603	3607	3609	3613	3615	3617	3619	3621	3623	3625	3627	3629	3631	3633	3635	3639	3643	3645	3647	3649	3651	3653	3655	3657	3659	3663	3665	3667	3669	3673	3675	3677	3679	3681	3683	3685	3687	3689	3691	3693	3697	3699	3701	3705	3707	3711	3713	3715	3717	3719	3721	3723	3725	3727	3729	3731	3733	3735	3737	3739	3741	3743	3745	3747	3749	3755	3759	3761	3765	3767	3769	3771	3773	3775	3777	3779	3781	3783	3793	3797	3803	3811	3813	3817	3821	3823	3827	3829	3831	3835	3839	3841	3845	3847	3849	3851	3855	3857	3859	3861	3863	3865	3867	3869	3877	3879	3881	3883	3885	3887	3889	3891	3895	3897	3899	3901	3903	3905	3907	3909	3911	3913	3919	3921	3923	3925	3927	3929	3931	3933	3935	3939	3941	3949	3951	3953	3956	3959	3960	3962	3965	3966	3968	3970	3971	3972	3973	3974	3975	3977	3978	3979
```
* and run MSTMap.exe
```
/home/wb/zkwu/MSTMap.exe   new_selet_geno/chr01_geno.txt new_linkage/chr01_linkage.txt
```

#### step5: conbine all genotypes for all inbred lines coupled with all markers
* merge the genotypes
```
cat chr01_linkage.txt chr02_linkage.txt chr03_linkage.txt chr04_linkage.txt chr05_linkage.txt chr06_linkage.txt chr07_linkage.txt chr08_linkage.txt chr09_linkage.txt chr10_linkage.txt chr11_linkage.txt chr12_linkage.txt chr13_linkage.txt chr14_linkage.txt chr15_linkage.txt chr16_linkage.txt chr17_linkage.txt chr18_linkage.txt chr19_linkage.txt | grep '^Bn' > all_chr_linkage.txt
```
* manual correcting the genotype

