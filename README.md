# eval-samtools-cpu-efficiency

A test of samtools threading settings from nf-core modules.

## Usage

Requires `pixi`, `slurm`, and `apptainer`/`singularity` installed.

```bash
pixi run test
```

## Results

See results folder.

Summary:

Use full cpus: **CPU Efficiency**: 15.26% of 00:15:24 core-walltime
Use cpus -1: **CPU Efficiency**: 8.04% of 00:25:54 core-walltime