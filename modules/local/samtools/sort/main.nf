process SAMTOOLS_SORT {

    tag 'medium'
	

	publishDir "${params.output_dir}/transcriptome_bams/${bam.simpleName}", mode: 'copy'

	input:
	    file bam 

	output:
	    path "*.sorted.bam", emit: sorted_bam

    script:
        """
        samtools sort ${bam} -o ${bam.baseName}.sorted.bam 
        """
}