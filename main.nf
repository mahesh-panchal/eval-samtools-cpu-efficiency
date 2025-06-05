include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_ORIG } from './modules/nf-core/samtools/fasta/main'
include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_MOD  } from './modules/local/samtools/fasta/main'

workflow {
    ch_bam = Channel.fromPath(params.bam, checkIfExists: true)
        .map { bam -> tuple([ id: bam.baseName, single_end: true ], bam) }
    SAMTOOLS_FASTA_ORIG( ch_bam, false )
    SAMTOOLS_FASTA_MOD( ch_bam, false )
    slurm_ids = SAMTOOLS_FASTA_ORIG.out.slurmid
        .mix(SAMTOOLS_FASTA_MOD.out.slurmid)
    EVALUATE_EFFICIENCY( slurm_ids )
}

process EVALUATE_EFFICIENCY {
    input:
    tuple val(process), val(job_id)

    script:
    """
    (
    echo "${process}"
    seff ${job_id}
    ) | tee ${job_id}.metrics
    """

    output:
    path("*.metrics"), emit: metrics
}