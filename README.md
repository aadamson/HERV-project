HERV-project
============

## Local setup

### Getting the HMMs

```bash
git clone git@github.com:aadamson/HERV-project.git
```

### Installing nhmmer

#### On MacBook (Intel architecture)

```bash
curl -O http://selab.janelia.org/software/hmmer3/3.1b1/hmmer-3.1b1-macosx-intel.tar.gz
tar zxf hmmer-3.1b1-macosx-intel.tar.gz
cd ./hmmer-3.1b1-macosx-intel
./configure
make
make check
make install
```

#### On corn

```bash
curl -O http://selab.janelia.org/software/hmmer3/3.1b1/hmmer-3.1b1-linux-intel-x86_64.tar.gz
tar zxf hmmer-3.1b1-linux-intel-x86_64.tar.gz
cd ./hmmer-3.1b1-linux-intel-x86_64
./configure
make
make check
mkdir -p ~/bin
mv ./src/nhmmer ~/bin
source ~/.cshrc
```

If you still can't call nhmmer, verify that ~/bin is in your shell's PATH:

Open ~/.cshrc in vim (vim ~/.cshrc) or some other editor. Go to the section that looks like 
```
set path=( ~ \
         OTHER_PATH \
         ANOTHER_PATH \
         ... \
         )
```
On corn, this should be around line 45.
There should be a line that looks like
```
      ~/bin \
```
If there isn't, add one so that the section now has something like
```
set path=( ~ \
         OTHER_PATH \
         ANOTHER_PATH \
         ... \
         ~/bin \
         )
```
Once you add this, exit vim (by typing escape and then :q) and call
```
source ~/.cshrc
```

### Getting hg38

```bash
curl -O http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip hg38.fa.gz
```

### Using nhmmer

```bash
nhmmer --cut_ga PATH_TO_HMM PATH_TO_GENOME_FA 
```

### Batch nhmmer

```bash
./scripts/get_hits.sh -e PATTERN_FOR_HMM_FILES -g PATH_TO_GENOME_FASTA -o OUTPUT_DIRECTORY
```

Note that the "-o" argument is optional. I think the pattern for HMM files only allows wildcards (*) rather than bona fide regular expressions.

To try it out, get hg38 and nhmmer as described above, and call
```bash
./scripts/get_hits.sh -e ./hmm/models/U7.hmm -g ./hg38.fa
```
