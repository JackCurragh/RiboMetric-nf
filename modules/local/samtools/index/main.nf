process SAMTOOLS_INDEX {

    tag 'medium'

	input:
	    file bam 

	output:
	    path("*.bai"), emit: bai
        path("*.bam", includeInputs: true), emit: bam

    script:
        """
        samtools index ${bam}
        """
}