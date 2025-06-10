// main.nf

// Definisco i parametri
params.reads = "data/*_R{1,2}.fastq.gz"

// Includo il modulo fastp
include { fastp } from './modules/fastp.nf'

// Definisco il canale paired-end e lancio il workflow
workflow {
    reads_ch = Channel.fromFilePairs(params.reads, flat: true)
    fastp(reads_ch)
}
