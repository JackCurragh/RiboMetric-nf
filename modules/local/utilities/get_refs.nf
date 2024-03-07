process GET_REFS {

    tag 'medium'

	input:
	    tuple val(organism), file(bam)

	output:
	    path "*.tsv", emit: ribometric_annotation, optional: true
        path "mudskipper", emit: mudskipper_index, optional: true

    script:
        """
        cp ${params.reference_dir}/${organism}/*RiboMetric.tsv .
        cp -r ${params.reference_dir}/${organism}/mudskipper .
        """
}