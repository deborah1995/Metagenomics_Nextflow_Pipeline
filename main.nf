// main.nf

// Abilita il DSL2 di Nextflow, essenziale per la modularità.
nextflow.enable.dsl=2

include { fastp } from './modules/fastp.nf'

// Definizione del workflow principale della pipeline.
workflow {
  // Crea un canale per i file di input.
  // fromFilePairs cerca coppie di file basandosi su 'params.reads'.
  // Produrrà tuple del tipo [sample_id, [file_R1, file_R2]].
  reads_ch = Channel
    .fromFilePairs(params.reads)
    // Mappa le tuple per ottenere il formato [file_R1, file_R2] che il processo 'fastp' si aspetta.
    .map { sample_id, files -> tuple(files[0], files[1]) }

  // Chiama il processo 'fastp' passandogli il canale 'reads_ch'.
  // Nextflow si occuperà di eseguire 'fastp' per ogni coppia di file nel canale.
  fastp(reads_ch)
}
