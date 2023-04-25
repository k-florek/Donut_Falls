process multiqc {
  publishDir "${params.outdir}", mode: 'copy'
  tag       "multiqc"
  container 'quay.io/biocontainers/multiqc:1.14--pyhdfd78af_0'

  //fastp
  //filtlong
  //porechop
  //quast
  //busco

  input:
  file(input)

  output:
  path "multiqc/multiqc_report.html"
  path "multiqc/multiqc_data/*"

  shell:
  '''
    mkdir -p multiqc 
    multiqc --version

    multiqc !{params.multiqc_options} \
      --outdir multiqc \
      . 
  '''
}