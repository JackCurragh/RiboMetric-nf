#!/usr/bin/env nextflow

/// Specify to use Nextflow DSL version 2
nextflow.enable.dsl=2

/// Import modules and subworkflows
include { prepare } from './workflows/local/prepare.nf'
include { genomic_ribometric } from './workflows/local/genomic.nf'

include { GET_REFS } from './modules/local/utilities/get_refs.nf'

// Log the parameters
log.info """\

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||                        INSERT PIPELINE NAME                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Parameters                                                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Samples                 : ${params.input_csv}                                     
||  outDir                  : ${params.output_dir}                                        
||  Reference Directory     : ${params.reference_dir}                                     
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

"""
// Help Message to prompt users to specify required parameters
def help() {
    log.info"""
  Usage:  nextflow run main.nf --input <path_to_fastq_dir> 

  Required Arguments:

  --input    Path to directory containing fastq files.

  Optional Arguments:

  --outDir	Path to output directory. 
	
""".stripIndent()
}

/// Define the main workflow
workflow {
    
    samples = Channel
                .fromPath(params.input_csv)
                .splitCsv(header: true)
                .map { row -> tuple(row.organism_name, row.bam_path) }

    references = GET_REFS(samples)

    if (references.isEmpty()) {
        log.error "No references found. Exiting."
        exit 1
    }

    bam_ch = samples.map { it[1] }

    genomic_ribometric(bam_ch, references)
}

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
