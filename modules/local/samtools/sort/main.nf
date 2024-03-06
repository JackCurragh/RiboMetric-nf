process SAMTOOLS_SORT {

    tag 'medium'
	
	input:
	    file bam 

	output:
	    path "*.sorted.bam", emit: sorted_bam

    script:
        """
        samtools sort ${bam} -o ${sorted_bam} 
        """
}