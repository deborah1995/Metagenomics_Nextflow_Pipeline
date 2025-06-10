// modules/fastp.nf

process fastp {
  container 'deborah/fastp' 

  input:
  tuple path(reads1), path(reads2)

  output:
  tuple path("cleaned_${reads1.baseName}.fastq.gz"), path("cleaned_${reads2.baseName}.fastq.gz")

  
  publishDir "${params.outdir}/fastp_results", mode: 'copy'

  script:
  """
  fastp \\
    -i $reads1 \\
    -o cleaned_${reads1.baseName}.fastq.gz \\
    -I $reads2 \\
    -O cleaned_${reads2.baseName}.fastq.gz
  """
}
