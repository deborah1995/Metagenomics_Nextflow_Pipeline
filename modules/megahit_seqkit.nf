// modules/megahit_seqkit.nf

process MEGAHIT_SEQKIT {
    tag "${sample_id}"
    cpus 8 // Assegna più core, es. 8, per megahit
    memory '32 GB' // megahit può essere esoso di memoria
    time '8h' // Tempo limite per l'esecuzione

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}.contigs.filtered.fasta"), emit: filtered_contigs
    path "megahit_computation/", emit: megahit_raw_output // Output grezzo di megahit

    publishDir "${params.outdir}/megahit_seqkit", mode: 'copy' // Salva gli output per tool
    stageInMode = 'copy' // Copia i file di input nel workdir del processo

    script:
    // Assicurati che reads[0] sia R1 e reads[1] sia R2
    def r1 = reads[0]
    def r2_arg = reads.size() > 1 ? "-2 ${reads[1]}" : "" // Per gestire anche single-end, se necessario

    """
echo "Running MEGAHIT for sample: ${sample_id}"
megahit ${params.megahit_params} -t ${task.cpus} -1 ${r1} ${r2_arg} -o megahit_computation/

echo "Filtering contigs with SeqKit for sample: ${sample_id}"
seqkit seq ${params.seqkit_params} megahit_computation/final.contigs.fa -o ${sample_id}.contigs.filtered.fasta
    """ // <--- QUESTA RIGA MANCAVA!
}
