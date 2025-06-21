nextflow.enable.dsl=2

process TestNvidiaL40S {
  publishDir "/mnt/workflow/pubdir"
  
  accelerator 1
  cpus 50 
  memory "200 GB"
  
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
    Channel.of('Hello') | TestNvidiaL40S | view

  emit:
    TestNvidiaL40S.out
}