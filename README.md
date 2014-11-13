HERV-project
============

To extract DFAM HMMs:
```bash
curl ftp://selab.janelia.org/pub/dfam/Release/Dfam_1.2/Dfam.hmm.gz
tar xzf Dfam.hmm.gz
csplit --digits=4 -f dfam_hmm --quiet Dfam.hmm "/\/\//" "{*}"
remove_delimiters.sh .
```

To rename DFAM HMMs according to the names given in the Dfam file:
```bash
rename.sh PATH_TO_HMMS OUTPUT_DIRECTORY
```
