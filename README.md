# Sample CWL Workflow
                        
## What this will do

This sample workflow demonstrates how to:

* Download files
* Manipulate with files (e.g. unizp)
* Process files using Python package
* Process files using an arbitrary tool, using R
    script as an example
                        
> This workflow does not demonstrate an important CWL feature:
> **_scattering_**. This feature allows to run multiple processes in parallel.

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
7. Run the Workflow

Setup Commands:

    git clone https://github.com/fasrc/epa_cwl_airflow.git
    cd epa_cwl_airflow
    conda create --name fasrccwl
    conda activate fasrccwl
    conda install python=3.8 R  
    conda install geopandas
    pip install -r requirements.txt
      
Run the workflow:

    export sourceroot=$(pwd)    
    cwl-runner $sourceroot/workflow/cwl/workflow.cwl
    ls -alF
    cat *