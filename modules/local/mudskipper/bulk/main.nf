
process MUDSKIPPER_BULK {

    tag 'medium'

	input:
        path(bam_index)
	    path(bam)
        val(index)

	output:
	    path "*.trans.bam", emit: trans_bam

    script:
        """
        mudskipper bulk --alignment ${bam} --out ${bam.baseName}.trans.bam --index $index
        """
}