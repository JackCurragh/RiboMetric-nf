process SAMTOOLS_INDEX {

    tag 'medium'

	input:
	    path(bam) 

	output:
	    path('*.bai'), emit: bai
        path('*.bam', includeInputs: true)

    script:
        """
        samtools index ${bam}
        """
}