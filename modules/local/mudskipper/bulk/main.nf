
process MUDSKIPPER_BULK {

    tag 'medium'

	input:
	    file bam 
        file bam_index
        path index

	output:
	    path "*.trans.bam", emit: trans_bam

    script:
        """
        mudskipper bulk --alignment ${bam} --out ${file.baseName}.trans.bam --index $index
        """
}