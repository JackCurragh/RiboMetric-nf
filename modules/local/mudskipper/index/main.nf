
process MUDSKIPPER {

    tag 'medium'

	publishDir "${params.output_dir}/fastqc", mode: 'copy'
	
	input:
	    file fastq 

	output:
	    path "*_fastqc.{zip,html}", emit: fastqc_full_reports

    script:
        """
        fastqc -q $fastq 
        """
}