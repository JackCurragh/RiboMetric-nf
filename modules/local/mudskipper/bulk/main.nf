
process MUDSKIPPER {

    tag 'medium'

	input:
	    file bam 
        path index

	output:
	    path "*.trans.bam", emit: trans_bam

    script:
        """
        mudskipper bulk --alignment ${bam} --out ${file.baseName}.trans.bam --index $index
        """
}