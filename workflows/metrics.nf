include { busco }    from '../modules/busco'    addParams(params)
include { multiqc }  from '../modules/multiqc'  addParams(params)
include { nanoplot } from '../modules/nanoplot' addParams(params)
//include { quast } from '../modules/quast' addParams(params)

workflow metrics {
    take:
    ch_reads
    ch_consensus
    ch_summary

    main:
    nanoplot(ch_reads)
    busco(ch_consensus)
    multiqc(ch_summary.mix(busco.out.summary).collect())

    nanoplot.out.summary.collectFile(name: "NanoStats.csv",
    keepHeader: true,
    storeDir: "${params.outdir}/nanoplot")
}