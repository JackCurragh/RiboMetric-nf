

// if an organisms mudskipper index and ribometric annotation 
// are not found on drive then it will be prepared 

include { RIBOMETRIC_PREPARE } from '../../modules/local/ribometric/prepare/main.nf'
include { MUDSKIPPER_INDEX } from '../../modules/local/mudskipper/index/main.nf'

workflow prepare {
    take:
        gtf
        organism_name

    main:
        MUDSKIPPER_INDEX(gtf, organism_name)
        RIBOMETRIC_PREPARE(gtf, organism_name)

    emit:
        ribometric_reports_ch
}