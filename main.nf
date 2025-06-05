include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_ORIG } from './modules/nf-core/samtools/fasta/main'
include { SAMTOOLS_FASTA as SAMTOOLS_FASTA_MOD  } from './modules/local/samtools/fasta/main'

workflow {
    ch_bam = Channel.of(
        tuple([ id: params.species, single_end: true,  ], params.bam_url)
    )
    FETCH_FILE( ch_bam )
    SAMTOOLS_FASTA_ORIG( FETCH_FILE.out.bam, false )
    SAMTOOLS_FASTA_MOD( FETCH_FILE.out.bam, false )
    slurm_ids = SAMTOOLS_FASTA_ORIG.out.slurmid
        .mix(SAMTOOLS_FASTA_MOD.out.slurmid)
    EVALUATE_EFFICIENCY( slurm_ids )
}

process FETCH_FILE {
    input:
    tuple val(meta), val(url)

    script:
    """
    wget -O ${meta.id}.bam ${url}
    """

    output:
    tuple val(meta), path("*.bam"), emit: bam
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