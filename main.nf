// main.nf

nextflow.enable.dsl=2

include { FASTP } from './modules/fastp.nf'
include { MEGAHIT_SEQKIT } from './modules/megahit_seqkit.nf'

workflow {
    input_ch = Channel
        .fromPath(params.sample_file)
        .splitCsv(header: true, sep: ',')
        .map { row ->
            def fastq_files = []
            if (row.fastq_1) fastq_files << file(row.fastq_1)
            if (row.fastq_2) fastq_files << file(row.fastq_2)

            tuple(
                row.sample_id,
                fastq_files
            )
        }
        .set { reads_for_fastp_ch }

    FASTP(reads_for_fastp_ch)

    // Modifica qui: da FASTP.out.tuple a FASTP.out
    FASTP.out // <--- RIGA 27 (o quella dove inizia il map da FASTP.out)
        .map { sample_id, r1_trimmed, r2_trimmed, html_report ->
            tuple(sample_id, [r1_trimmed, r2_trimmed])
        }
        .set { trimmed_reads_ch }
    
    MEGAHIT_SEQKIT(trimmed_reads_ch)
}
