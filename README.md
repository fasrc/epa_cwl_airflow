# Sample CWL Workflow

## Introduction

[Common Workflow Language (CWL)](https://www.commonwl.org/) 
is used to define heterogeneous 
computational workflows in a way, that ensure reproducibility. 
Heterogeneous workflows can include steps implemented in 
different programming languages (we demonstrate Python and R)
and/or steps performed by calling Unix/Linux command line utilities.

CWL implementations ensure that id a workflow runs on your laptop it will run
in any other environment, such as HPC slurm cluster and produce exactly 
the same results (maybe a bit faster).
                        
## What this will do

This sample workflow demonstrates how to:

* Download files, using standard unix/Linux command line utility `curl`.
    * The goal of this step is to demonstrate reusable CWL command line tool.
* Manipulate with files (e.g. unizp). 
    * The goal of this step is to demonstrate using adhoc command line utilities 
* Process files using Python package
    * This step demonstrates how to implement processing in Python
* Process files using an arbitrary tool, using an R script as an example
    * This step demonstrates how one can use R, or, in fact any scripting
      utility, such as `sed` or `awk`.
                        
> This workflow does not demonstrate an important CWL feature:
> **_scattering_**. This feature allows running multiple processes in parallel.
> 
> For details, see 
> [CWL User Guide](https://www.commonwl.org/user_guide/23-scatter-workflow/index.html)
> and [NSAPH gridMET processing workflow](https://github.com/NSAPH-Data-Platform/nsaph-gridmet/blob/master/src/cwl/gridmet.cwl)
> that scatters processing over 
> [parameters (bands)](https://github.com/NSAPH-Data-Platform/nsaph-gridmet/blob/master/src/cwl/gridmet.cwl#L78)
> and over [years](https://github.com/NSAPH-Data-Platform/nsaph-gridmet/blob/master/src/cwl/gridmet.cwl#L120-L121)

## Preparation and Setup

The workflow is tested to work in Conda environment, using Anaconda 
for Mac 4.10.3. While a [conda environment file](conda_env.yml) is 
provided for your reference, I would recommend setting up the environment 
manually. This is because certain dependencies should be installed 
in particular order, especially geospatial libraries.

Please follow these  steps:

1. Clone the repository
2. Create a new conda environment
3. Install Python 3.8 and R
4. Install geopandas
5. Install Python dependencies
6. Create an empty directory and cd there
7. Look at the workflow graph
8. Run the Workflow
9. Compare the results with expected results

Setup Commands:

    git clone https://github.com/fasrc/epa_cwl_airflow.git
    cd epa_cwl_airflow
    conda create --name fasrccwl
    conda activate fasrccwl
    conda install python=3.8 R  
    conda install geopandas
    pip install -r requirements.txt
                             
Generate workflow graph:

    export sourceroot=$(pwd)    
    cwl-runner --print-dot $sourceroot/workflow/cwl/workflow.cwl | dot -Tgif > workflow_graph.gif

Run the workflow:

    export sourceroot=$(pwd)  
    cd $workdir
    cwl-runner --parallel $sourceroot/workflow/cwl/workflow.cwl
    ls -alF
    cat *
    diff -r . $sourceroot/reusults