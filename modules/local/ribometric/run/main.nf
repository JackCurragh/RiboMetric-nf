process RIBOMETRIC_RUN {

    maxForks 5
    tag 'medium'

	publishDir "${params.output_dir}/ribometric/${bam.simpleName}", mode: 'copy'

    errorStrategy 'ignore'
	
	input:
        path(bai) 
	    path(bam)
        file annotation

	output:
	    path "*.csv", emit: csv_report
        path "*.pdf", emit: pdf_report
        path "*.html", emit: html_report
        path "*.json", emit: json_report

    script:
        """
        RiboMetric run -p 8 -b ${bam} -a ${annotation} -S 10000000 -T 10000 --all > output.txt
        """
}
