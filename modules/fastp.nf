// modules/fastp.nf

process fastp {
  container 'deborah/fastp' 

  // Definisce gli input che questo processo si aspetta.
  // Riceve una tupla contenente i percorsi a due file: reads1 (R1) e reads2 (R2).
  input:
  tuple path(reads1), path(reads2)

  // Definisce gli output che questo processo produrrà.
  // Uso 'baseName' per ottenere il nome del file senza l'estensione originale (.fastq),
  // in modo da poter costruire un nome di output pulito e consistente.
  output:
  tuple path("cleaned_${reads1.baseName}.fastq.gz"), path("cleaned_${reads2.baseName}.fastq.gz")

  // Questa direttiva è FONDAMENTALE: dice a Nextflow dove copiare i file
  // dichiarati nella sezione 'output' una volta che il processo è completato con successo.
  // I file verranno copiati nella sottocartella 'fastp_results' all'interno della tua 'outdir' principale.
  // 'mode: 'copy'' significa che i file verranno fisicamente copiati.
  publishDir "${params.outdir}/fastp_results", mode: 'copy'

  // Questo è lo script bash che verrà eseguito all'interno del container Docker.
  // Utilizza le variabili $reads1 e $reads2 (gli input del processo)
  // e costruisce i nomi dei file di output usando 'baseName' come definito nell'output.
  script:
  """
  fastp \\
    -i $reads1 \\
    -o cleaned_${reads1.baseName}.fastq.gz \\
    -I $reads2 \\
    -O cleaned_${reads2.baseName}.fastq.gz
  """
}
