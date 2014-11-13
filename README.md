HERV-project
============

## Local setup

### Install nhmmer

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
mv ./src/nhmmer ~/bin
src ~/.cshrc
```

## Getting hg38

```bash
curl -O http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip hg38.fa.gz
```

## Using nhmmer

```bash
nhmmer --cut_ga PATH_TO_HMM PATH_TO_GENOME_FA 
```
