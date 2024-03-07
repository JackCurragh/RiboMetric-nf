
process MUDSKIPPER_INDEX {

    tag 'medium'

	publishDir "${params.reference_dir}/${organism}", mode: 'copy'
	
	input:
	    file gtf 
        val organism

	output:
	    path "mudskipper"

    script:
        """
        mudskipper index -g ${gtf} -d mudskipper
        """
}