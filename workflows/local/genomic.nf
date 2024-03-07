// Include the necessary modules for this workflow
include { SAMTOOLS_INDEX } from '../../modules/local/samtools/index/main.nf'
include { SAMTOOLS_SORT } from '../../modules/local/samtools/sort/main.nf'
include { SAMTOOLS_VIEW } from '../../modules/local/samtools/view/main.nf'
include { MUDSKIPPER_BULK } from '../../modules/local/mudskipper/bulk/main.nf'
include { RIBOMETRIC_RUN } from '../../modules/local/ribometric/run/main.nf'


workflow genomic_ribometric {
    take:
        bam
        mudskipper_index
        ribometric_annotation

    main:
        bam_index_ch                = SAMTOOLS_INDEX(bam)

        trans_bam_ch                = MUDSKIPPER_BULK(
                                        bam_index_ch.out.bam,
                                        bam_index_ch.out.bai,
                                        mudskipper_index
                                        )
                                        
        trans_bam_no_secondary_ch   = SAMTOOLS_VIEW(
                                        trans_bam_ch
                                        )

        trans_bam_sort_ch           = SAMTOOLS_SORT(trans_bam_no_secondary_ch)

        trans_bam_index_ch          = SAMTOOLS_INDEX(trans_bam_sort_ch)

        ribometric_reports_ch       = RIBOMETRIC_RUN(
                                        trans_bam_index_ch,
                                        ribometric_annotation
                                        )

    
    emit:
        ribometric_reports_ch
}