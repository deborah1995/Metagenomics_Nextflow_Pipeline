process fastp {
    container 'deborah/fastp'

    input:
    path read_file

    output:
    path "cleaned_${read_file.simpleName}.fastq.gz"

    script:
    """
    fastp -i $read_file -o cleaned_${read_file.simpleName}.fastq.gz
    """
}
