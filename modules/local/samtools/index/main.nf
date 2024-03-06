process SAMTOOLS_INDEX {

    tag 'medium'

	input:
	    file bam 

	output:
	    path "*.bai", emit: index

    script:
        """
        samtools index ${bam}
        """
}