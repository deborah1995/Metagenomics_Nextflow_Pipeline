# Metagenomic Pipeline with Nextflow

This repository contains a modular read-based metagenomic analysis pipeline built with [Nextflow](https://www.nextflow.io/).  
Each module runs in an isolated Docker container for reproducibility and ease of use.

## 📦 Tools included

- **fastp**: Quality control and filtering of raw reads
- **Kaiju**: Taxonomic classification of metagenomic reads
- **FunProfiler**: Functional profiling of metagenomic reads
- **Maxbin2**: Binning algorithm
- **Quast**: Assembly Quality Check

## 🐳 Containers

Each tool has its own folder with:
- `Dockerfile`
- `conda.yml`

Example:

fastp/
├── Dockerfile

└── conda.yml
