# PMAO: PASTA with Many Application-aware Objectives
**PMAO** is a framework that extends [PASTA][1] (Practical Alignments using SATé and TrAnsitivity) by incorporating five application-aware objectives through principles of decompistion-based multi-objective optimization. The PMAO framework can lead to a tree-space containing significantly better phylogenetic trees than PASTA. 
Here is the original [PASTA Tutorial](pasta-doc/pasta-tutorial.md)


## Application-aware objectives in PMAO for phylogeny estimation

Currently PMAO simulatneosly uses the following five objectives as its optimization criteria:
1. Maximize similarity for columns containing gaps (SIMG)
2. Maximize similarity for columns containing no gaps (SIMNG)
3. Maximize sum-of-pairs (SOP)
4. Minimize number of gaps (GAP)
5. Maximize maximum likihood score (ML)


More objectives can be added to this framework.

## Installation from source code

The current version of PMAO has been developed and tested entirely on Linux and MAC. 
Windows won't work currently (future versions may or may not support Windows). 

You need to have:

- [Python](https://www.python.org) (version 2.7 or later, including python 3)
- [Dendropy](http://packages.python.org/DendroPy/) (but the setup script should automatically install dendropy for you if you don't have it)  
- [Java](https://www.java.com) (only required for using OPAL)

**Installation steps**:

1. Open a terminal and create a directory where you want to keep PMAO and  go to this directory. For example:

   ```bash 
   mkdir ~/PMAO-code
   cd ~/PMAO-code`
   ```

2. Clone the PMAO code repository from our [github repository](https://github.com/ali-nayeem/pmao). For example you can use: 

   ```bash
   git clone https://github.com/ali-nayeem/pmao.git
   ```
  

3.  A. Clone the relevant "tools" directory (these are also forked from the SATé project).
There are different repositories for [linux](https://github.com/smirarab/sate-tools-linux) 
and [MAC](https://github.com/smirarab/sate-tools-mac).
You can use 

	```bash
	git clone https://github.com/smirarab/sate-tools-linux.git #for Linux
	``` 
	or
	
	```bash
	git clone https://github.com/smirarab/sate-tools-mac.git. #for MAC
	``` 
	Or you can directly download these as zip files for 
[Linux](https://github.com/smirarab/sate-tools-linux/archive/master.zip) or [MAC](https://github.com/smirarab/sate-tools-mac/archive/master.zip)
and decompress them in your target directory (e.g. `pasta-code`).
	* Note that the tools directory and the PASTA code directory should be under the same parent directory. 
	* When you use the zip files instead of using `git`, after decompressing the zip file you may get a directory called `sate-tools-mac-master` or `sate-tools-linux-master` instead of `sate-tools-mac` or `sate-tools-linux`. 
You need to rename these directories and remove the `-master` part.
	* Those with 32-bit Linux machines need to be aware that the master branch has 64-bit binaries. 32-bit binaries are provided in the `32bit` branch of `sate-tools-linux` git project (so download [this zip file](https://github.com/smirarab/sate-tools-linux/archive/32bit.zip) instead). 

3. B. (Optional) Only if you want to use MAFFT-Homologs within PASTA:
`cd sate-tools-linux` or `cd sate-tools-mac`
Use `git clone https://github.com/koditaraszka/pasta-databases` or download directly at `https://github.com/koditaraszka/pasta-databases.git`
	* Be sure to leave this directory `cd ..` before starting the next step

4. `cd pmao` 

5. Then run:

	``` bash
	 sudo python setup.py develop 
	```
 
	If you don't have root access, use:
	
	``` bash
	python setup.py develop  --user
	```



## Execution

To run PMAO using the command-line:

```bash
python run_pasta.py -i input_fasta [-t starting_tree] 
```


PASTA by default picks the appropriate configurations automatically for you. 
The starting tree is optional. If not provided, PASTA estimates a starting tree. 

Run

```bash
python run_pasta.py --help
``` 

to see PASTA's various options and descriptions of how they work. 



Options
------
PASTA estimates alignments and maximum likelihood (ML) trees from unaligned sequences using an iterative approach. In each iteration, 
it first estimates a multiple sequence alignment and then a ML tree is estimated on (a masked version of) the alignment. 


Output
-------
PASTA outputs an alignment and a tree, in addition to a host of other files. These various output files are described in more detail in our [tutorial](pasta-doc/pasta-tutorial.md#step-2-inspecting-the-output-of-pasta). Note that the support values on the PASTA output tree are local SH-like support values computed by FastTree, and not bootstrap support values. To get a more reliable measure of support, please use the bootstrapping procedure, applied to the final PASTA alignments (you can use RAxML for this purpose). 



[1]: https://github.com/smirarab/pasta
[2]: https://github.com/jmabuin/pasta
[3]: https://github.com/tarabelo/pasta
[4]: https://doi.org/10.1093/bioinformatics/btx354
[5]: https://link.springer.com/chapter/10.1007%2F978-3-319-05269-4_15
[6]: http://online.liebertpub.com/doi/abs/10.1089/cmb.2014.0156
