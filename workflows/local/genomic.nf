// Include the necessary modules for this workflow
include { SAMTOOLS_INDEX as SAMTOOLS_INDEX_GENOMIC; SAMTOOLS_INDEX as SAMTOOLS_INDEX_TRANS  } from '../../modules/local/samtools/index/main.nf'
include { SAMTOOLS_SORT } from '../../modules/local/samtools/sort/main.nf'
include { SAMTOOLS_VIEW_NO_SECONDARY } from '../../modules/local/samtools/view/main.nf'
include { MUDSKIPPER_BULK } from '../../modules/local/mudskipper/bulk/main.nf'
include { RIBOMETRIC_RUN } from '../../modules/local/ribometric/run/main.nf'


workflow genomic_ribometric {
    take:
        bam
        ribometric_annotation
        mudskipper_index

    main:
        bam_index_ch                = SAMTOOLS_INDEX_GENOMIC(bam)

        trans_bam_ch                = MUDSKIPPER_BULK(
                                        bam_index_ch,
                                        mudskipper_index
                                        )
                                        
        trans_bam_no_secondary_ch   = SAMTOOLS_VIEW_NO_SECONDARY(
                                        trans_bam_ch
                                        )

        trans_bam_sort_ch           = SAMTOOLS_SORT(trans_bam_no_secondary_ch)

        trans_bam_index_ch          = SAMTOOLS_INDEX_TRANS(trans_bam_sort_ch)

        ribometric_reports_ch       = RIBOMETRIC_RUN(
                                        trans_bam_index_ch,
                                        ribometric_annotation
                                        )

    
    emit:
        ribometric_reports_ch.csv_report
}