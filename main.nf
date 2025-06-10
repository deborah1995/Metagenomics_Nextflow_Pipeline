// main.nf

// Definizionisco i parametri
params.reads = "data/*.fastq.gz"

// Includo il modulo fastp
include { fastp } from './modules/fastp.nf'

// Definisco il canale: raccoglie tutti i file fastq.gz
workflow {
    reads_ch = Channel.fromPath(params.reads)
    fastp(reads_ch)
}
