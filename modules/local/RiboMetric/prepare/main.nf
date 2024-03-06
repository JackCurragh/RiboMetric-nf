process RIBOMETRIC_PREPARE {

    tag 'medium'

	publishDir "${params.output_dir}/fastqc", mode: 'copy'
	
	input:
	    file gtf 

	output:
	    path "*.tsv", emit: annotation_file

    script:
        """
        RiboMetric prepare -g ${gtf} 
        """
}