nextflow.enable.dsl=2

process TestGpu {
  publishDir "/mnt/workflow/pubdir"
  
  accelerator 1, type: 'nvidia-l40s'
  cpus 4 
  memory "32 GB"
  
  input:
    val x

  output:
    stdout

  script:
    """
    set -euxo pipefail
    [[ ! -z \$NVIDIA_VISIBLE_DEVICES ]] && [[ \$NVIDIA_VISIBLE_DEVICES =~ GPU ]]
    echo '$x world!'
    """
}

workflow {
  main:
    Channel.of('Hello') | TestGpu | view

  emit:
    TestGpu.out
}