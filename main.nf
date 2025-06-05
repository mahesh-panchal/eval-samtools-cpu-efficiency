include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_ORIG } from './modules/nf-core/samtools/fasta/main'
include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_MOD  } from './modules/local/samtools/fasta/main'

workflow {
    ch_bam = Channel.fromPath(params.bam, checkIfExists: true)
        .map { bam -> tuple([ id: bam.baseName, single_end: true ], bam) }
    SAMTOOLS_FASTA_ORIG( ch_bam, false )
    SAMTOOLS_FASTA_MOD( ch_bam, false )
}