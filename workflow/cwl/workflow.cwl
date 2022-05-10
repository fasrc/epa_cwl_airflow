#!/usr/bin/env cwl-runner
### Downloader Example
#  Copyright (c) 2022. Harvard University
#
#  Developed by Research Software Engineering,
#  Faculty of Arts and Sciences, Research Computing (FAS RC)
#  Author: Michael A Bouzinier
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

doc: |
  This is a sample workflow that downloads several files and
  prcoesses them

inputs: []

steps:
  get_shapes:
    run: download.cwl
    in:
      url:
        valueFrom: https://www2.census.gov/geo/tiger/GENZ2020/shp/cb_2020_us_zcta520_500k.zip
      target:
        valueFrom: shapes.zip
    out:
      - data

  unzip_shapes:
    in:
      zip: get_shapes/data
    run:
      class: CommandLineTool
      baseCommand: unzip
      inputs:
        zip:
          type: File
          inputBinding:
            position: 1
      outputs:
        shapes:
          type: File[]
          outputBinding:
            glob: "*.shp"
          secondaryFiles:
            - "^.dbf"
            - "^.shx"
            - "^.prj"
            - "^.cpg"
    out:
      - shapes

  get_co:
    run: download.cwl
    in:
      url:
        valueFrom: https://www.airnowapi.org/aq/data/?bbox=-73.0,41.0,-71.0,43.0&startdate=2022-05-01T00&enddate=2022-05-01T12:00&parameters=co&format=application/json&datatype=c&verbose=0&api_key=EB9668CD-B274-4E1B-B3B1-82168A7057E9
      target:
        valueFrom: co.json
    out:
      - data

  get_ozone:
    run: download.cwl
    in:
      url:
        valueFrom: https://www.airnowapi.org/aq/data/?bbox=-73.0,41.0,-71.0,43.0&startdate=2022-05-01T00&enddate=2022-05-01T12:00&parameters=o3&format=application/json&datatype=c&verbose=0&api_key=EB9668CD-B274-4E1B-B3B1-82168A7057E9
      target:
        valueFrom: ozone.json
    out:
      - data

  aggregate_co:
    run: aggregate.cwl
    in:
      shapes:  unzip_shapes/shapes
      data: get_co/data
      target:
        valueFrom: co.csv
    out:
      - data

  aggregate_ozone:
    run: aggregate.cwl
    in:
      shapes:  unzip_shapes/shapes
      data: get_ozone/data
      target:
        valueFrom: ozone.csv
    out:
      - data

outputs:
#  shapes:
#    type: File[]
#    outputSource: unzip_shapes/shapes
#  co:
#    type: File
#    outputSource: get_co/data
#  ozone:
#    type: File
#    outputSource: get_ozone/data
  co:
    type: File
    outputSource: aggregate_co/data
  ozone:
    type: File
    outputSource: aggregate_ozone/data