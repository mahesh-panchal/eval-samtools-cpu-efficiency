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

- Use full cpus: **CPU Efficiency**: 15.26% of 00:15:24 core-walltime
- Use cpus -1: **CPU Efficiency**: 8.04% of 00:25:54 core-walltime

## Conclusion

This turned out to be misleading as dardel autoscales the number of allocated cpus based on memory.
The cpu efficiency is then calculated based on the number of allocated cpus, but not assigned by
Nextflow. In this case, 14 cpus were allocated, but only 2 were assigned to the process.

A better method to evaluate the cpu efficiency is to measure the stats using `time -v`.
