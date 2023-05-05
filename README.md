# Donut Falls

Named after the beautiful [Donut Falls](https://en.wikipedia.org/wiki/Doughnut_Falls)

Location: 40.630°N 111.655°W, Elevation: 7,942 ft (2,421 m), [Hiking level: easy](https://www.alltrails.com/trail/us/utah/cecret-lake-trail)

|                                       |                                       |
|:-------------------------------------:|:-------------------------------------:|
| <img src="https://images.alltrails.com/eyJidWNrZXQiOiJhc3NldHMuYWxsdHJhaWxzLmNvbSIsImtleSI6InVwbG9hZHMvcGhvdG8vaW1hZ2UvNTIzNDg5MTUvODRiOGEzM2M3MjliMzUyYjk4YTJhYmY5Mjg1MWMzMDguanBnIiwiZWRpdHMiOnsidG9Gb3JtYXQiOiJqcGVnIiwicmVzaXplIjp7IndpZHRoIjoyMDQ4LCJoZWlnaHQiOjIwNDgsImZpdCI6Imluc2lkZSJ9LCJyb3RhdGUiOm51bGwsImpwZWciOnsidHJlbGxpc1F1YW50aXNhdGlvbiI6dHJ1ZSwib3ZlcnNob290RGVyaW5naW5nIjp0cnVlLCJvcHRpbWlzZVNjYW5zIjp0cnVlLCJxdWFudGlzYXRpb25UYWJsZSI6M319fQ==" width="500" /> | <img src="https://images.alltrails.com/eyJidWNrZXQiOiJhc3NldHMuYWxsdHJhaWxzLmNvbSIsImtleSI6InVwbG9hZHMvcGhvdG8vaW1hZ2UvNTg3MzUyOTgvZWM4YTQ5NTZlNDhiNmZmMmU4ZWEzMzE0NjhhOWIyYWYuanBnIiwiZWRpdHMiOnsidG9Gb3JtYXQiOiJqcGVnIiwicmVzaXplIjp7IndpZHRoIjoyMDQ4LCJoZWlnaHQiOjIwNDgsImZpdCI6Imluc2lkZSJ9LCJyb3RhdGUiOm51bGwsImpwZWciOnsidHJlbGxpc1F1YW50aXNhdGlvbiI6dHJ1ZSwib3ZlcnNob290RGVyaW5naW5nIjp0cnVlLCJvcHRpbWlzZVNjYW5zIjp0cnVlLCJxdWFudGlzYXRpb25UYWJsZSI6M319fQ==" width="500"/> |


([Image credit: User submitted photos at alltrails.com](https://www.alltrails.com/trail/us/utah/donut-falls-trail/photos))

More information about the trail leading up to this landmark can be found at [utah.com/hiking/donut-falls](https://utah.com/hiking/donut-falls)

Donut Falls is a [Nextflow](https://www.nextflow.io/) workflow developed by [@erinyoung](https://github.com/erinyoung) at the [Utah Public Health Laborotory](https://uphl.utah.gov/) for long-read [nanopore](https://nanoporetech.com) sequencing of microbial isolates. Built to work on linux-based operating systems. Additional config options are needed for cloud batch usage.

Donut Falls is also included in the staphb toolkit [staphb-toolkit](https://github.com/StaPH-B/staphb_toolkit). 

Donut Falls, admittedly, is just a temporary stop-gap until nf-core's [genomeassembler](https://github.com/nf-core/genomeassembler) is released, so do not be suprised if this repository gets archived.

We made a [wiki](https://github.com/UPHL-BioNGS/Donut_Falls/wiki), please read it!

## Wiki table of contents:
- [Installation](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Installation)
- [Usage](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Usage)
  - [Using config files](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Usage#using-a-config-file)
  - [Parameters worth adjusting](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Usage#recommended-parameters-to-adjust)
  - [Examples](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Usage#examples)
- [Subworkflows](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Subworkflows)
- [FAQ](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/FAQ)


## Getting started

### Install dependencies
- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html)
- [Singularity](https://singularity.lbl.gov/install-linux) or [Docker](https://docs.docker.com/get-docker/)


## Quick start

```
nextflow run UPHL-BioNGS/Donut_Falls -profile <singularity or docker> --sample_sheet <sample_sheet.csv>
```

## Sample Sheets

Sample sheet is a csv file with the name of the sample and corresponding nanopore fastq.gz file on a single row with header `sample` and `fastq`. When Illumina fastq files are available for polishing or hybrid assembly, they are added to end of each row under column header `fastq_1` and `fastq_2`. 

Option 1 : just nanopore reads
```
sample,fastq
test,long_reads_low_depth.fastq.gz
```

Option 2 : nanopore reads and at least one sample has Illumina paired-end fastq files
```
sample,fastq,fastq_1,fastq_2
sample1,sample1.fastq.gz,sample1_R1.fastq.gz,sample1_R2.fastq.gz
sample2,sample2.fastq.gz,,
```

### Switching assemblers
There are currently several options for assembly
- [flye](https://github.com/fenderglass/Flye)
- [dragonflye](https://github.com/rpetit3/dragonflye)
- [miniasm](https://github.com/rrwick/Minipolish)
- [raven](https://github.com/lbcb-sci/raven)
- [unicycler](https://github.com/rrwick/Unicycler) (requires short reads for hybrid assembly)
- [lr_unicycler](https://github.com/rrwick/Unicycler) (uses unicycler's nanopore-only option)
- [trycycler](https://github.com/rrwick/Trycycler) - please read [the wiki page](https://github.com/UPHL-BioNGS/Donut_Falls/wiki/Trycycler)

These are specified with the `assembler` paramater.

```
# nanopore assembly followed by polishing if illumina files are supplied
# assembler is flye, miniasm, raven, or lr_unicycler
nextflow run UPHL-BioNGS/Donut_Falls -profile singularity --sample_sheet <sample_sheet.csv> --assembler < assembler >

# hybrid assembly with unicycler where both nanopore and illumina files are required
nextflow run UPHL-BioNGS/Donut_Falls -profile singularity --sample_sheet <sample_sheet.csv> --assembler unicycler
```

### Reading the sequencing summary file
Although not used for anything else, the sequencing summary file can be read in and put through nanoplot to visualize the quality of a sequencing run. This is an optional file and can be set with 'params.sequencing_summary'. 
```
nextflow run UPHL-BioNGS/Donut_Falls -profile singularity --sequencing_summary <sequencing summary file>
```
* WARNING : Does not work with _older_ versions of the summary file.


## Credits

Donut Falls would not be possible without
- [bgzip](https://github.com/samtools/htslib) : file compression after filtlong
- [busco](https://gitlab.com/ezlab/busco) : assessment of assembly quality
- [circlator](https://github.com/sanger-pathogens/circlator) : rotating circular assembled chromosomes and plasmids
- [dragonflye](https://github.com/rpetit3/dragonflye) : de novo assembly (params.assembler = 'dragonflye')
- [fastp](https://github.com/OpenGene/fastp) : cleaning illuming reads
- [filtlong](https://github.com/rrwick/Filtlong) : prioritizing high quality reads for assembly
- [flye](https://github.com/fenderglass/Flye) : de novo assembly (default assembler)
- [gfastats](https://github.com/vgl-hub/gfastats) : assessment of assembly
- [masurca](https://github.com/alekseyzimin/masurca) : hybrid assembly options (params.assembler = 'masurca')
- [medaka](https://github.com/nanoporetech/medaka) : polishing with nanopore reads
- [miniasm and minipolish](https://github.com/rrwick/Minipolish) : de novo assembly option (params.assembler = 'miniasm')
- [nanoplot](https://github.com/wdecoster/NanoPlot) : fastq file QC visualization
- [polca](https://github.com/alekseyzimin/masurca) : polishing assemblies with Illumina reads
- [raven](https://github.com/lbcb-sci/raven) : de novo assembly option (params.assembler = 'miniasm')
- [trycycler](https://github.com/rrwick/Trycycler) : reconciles different assemblies (params.assembler = 'trycycler') 
- [unicycler](https://github.com/rrwick/Unicycler) : hybrid assembly option (params.assembler = 'unicycler') or de novo assembly option (params.assembler = 'lr_unicycler')
