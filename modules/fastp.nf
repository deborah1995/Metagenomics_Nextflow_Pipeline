process fastp {
    container 'deborah/fastp'

    input:
    tuple path(reads1), path(reads2)

    output:
    tuple path("cleaned_${reads1.simpleName}.fastq.gz"), path("cleaned_${reads2.simpleName}.fastq.gz")

    script:
    """
    fastp \
        -i $reads1 -I $reads2 \
        -o cleaned_${reads1.simpleName}.fastq.gz \
        -O cleaned_${reads2.simpleName}.fastq.gz
    """
}
