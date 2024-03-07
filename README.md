
# RiboMetric-nf
## Introduction 

Runs RiboMetric on Genomic BAMs
## Requirements 
This pipeline can be run using each of the following container methods
| Method      | Instructions                                                                                   |
| ----------- | ---------------------------------------------------------------------------------------------- |
| Singularity | [docs.syslabs.io](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)              |
| Docker      | [docs.docker.com](https://docs.docker.com/engine/install/)                                     |
| Conda       | [docs.conda.io](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)  |


## Setup
##### Singularity
```
sudo singularity build singularity/pipeline Singularity
```
Then as the profile `singularity` specifies `container = 'singularity/pipeline'` use the following to execute:
```
nextflow run main.nf -profile singularity
```

##### Docker
```
docker build . -t pipeline-image
```
Then as the profile `docker` specifies `container = 'pipeline-image:latest'` use the following to execute:
```
nextflow run main.nf -profile docker
```

##### Conda 
Create a conda definition yaml file [eg. here](conda/example.yml)
```
nextflow run main.nf -profile conda
```

## Usage
Call the pipeline directly
```
nextflow run main.nf
```

Run with all the frills
```
bash scripts/run-w-frills <params-file> <profile name from nextflow.config>
```
Example
```
bash scripts/run-w-frills example_parameters.yml standard
```


 11     samtools index $file
 12     mudskipper bulk --alignment ${file} --out ${file}.trans.bam --index $MUD
 13     samtools sort ${file}.trans.bam -o ${file}.trans.bam
 14     samtools index ${file}.trans.bam
 15     RiboMetric run -b ${file}.trans.bam -a $RiboMetric -o $dir --all
