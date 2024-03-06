process SAMTOOLS_VIEW_NO_SECONDARY {

    tag 'medium'
	
	input:
	    file bam 

	output:
	    path "*.no_secondary.bam", emit: no_secondary_bam

    script:
        """
        samtools view -F 256 -b ${bam} > ${no_secondary_bam}
        """
}