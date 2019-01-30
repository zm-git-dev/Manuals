### 查看ubuntu硬件架构
```
$ uname -a
Linux ubuntu 4.4.0-62-generic #83-Ubuntu SMP Wed Jan 18 14:10:15 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

$ dpkg --print-architecture
amd64

$ getconf LONG_BIT
64

$ arch
x86_64

```

### Linux批量杀死包含某个关键字的进程
```
$ ps -ef | grep ./amplxe-gui | grep -v grep | cut -c 9-15 | xargs kill -9
```
批量杀死包含关键字“./amplxe-gui”的进程。

* "ps -ef" ——查看所有进程
* "grep ./amplxe-gui" ——列出所有含有关键字"./amplxe-gui"的进程
* "grep -v grep" ——在列出的进程中去除含有关键字"grep"的进程（因为我们在前一步生成的grep进程也包含关键字）
* "cut -c 9-15" ——截取输入行的第9个字符到第15个字符，而这正好是进程号PID
* "xargs kill -9" ——xargs 命令是用来把前面命令的输出结果（PID）作为"kill -9"命令的参数，并执行该命令。"kill -9"会强行杀掉指定进程。


### filt data
```
$ awk '{if($3>0.95 || $3 < -0.95){print $0}}' Treatment_correlation.txt > Treatment_correlation_sig.txt
```

### insert string
```
$ sed -i 's/^[^>]\s*$//g' SILVA_132_SSUParc_tax_silva_DNA_species_modify.fasta
```


