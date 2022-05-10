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
    doc: |
      Download zip code shape files for year 2020 from US Census website.
      Files are downloaded as single zip archive
    run: download.cwl
    in:
      url:
        valueFrom: https://www2.census.gov/geo/tiger/GENZ2020/shp/cb_2020_us_zcta520_500k.zip
      target:
        valueFrom: shapes.zip
    out:
      - data

  unzip_shapes:
    doc: Unzip downloaded shape files
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
    doc: |
      Retrieve data for CO air concentration for an area surrounding
      the city of Cambridge, MA for one day (May 1, 2022) as JSON file
    run: download.cwl
    in:
      url:
        valueFrom: https://www.airnowapi.org/aq/data/?bbox=-73.0,40.0,-71.0,43.0&startdate=2022-05-01T00&enddate=2022-05-01T12:00&parameters=co&format=application/json&datatype=c&verbose=0&api_key=EB9668CD-B274-4E1B-B3B1-82168A7057E9
      target:
        valueFrom: co.json
    out:
      - data

  get_ozone:
    doc: |
      Retrieve data for Ozone air concentration for an area surrounding
      the city of Cambridge, MA for one day (May 1, 2022) as JSON file
    run: download.cwl
    in:
      url:
        valueFrom: https://www.airnowapi.org/aq/data/?bbox=-73.0,40.0,-71.0,43.0&startdate=2022-05-01T00&enddate=2022-05-01T12:00&parameters=o3&format=application/json&datatype=c&verbose=0&api_key=EB9668CD-B274-4E1B-B3B1-82168A7057E9
      target:
        valueFrom: ozone.json
    out:
      - data

  aggregate_co:
    doc: |
      Using shape files, aggregate CO data to ZIP code level, calculating
      mean vallue in a Python program.
    run: aggregate.cwl
    in:
      shapes:  unzip_shapes/shapes
      data: get_co/data
      target:
        valueFrom: co.csv
    out:
      - data

  aggregate_ozone:
    doc: |
      Using shape files, aggregate Ozone data to ZIP code level, calculating
      mean vallue in a Python program.
    run: aggregate.cwl
    in:
      shapes:  unzip_shapes/shapes
      data: get_ozone/data
      target:
        valueFrom: ozone.csv
    out:
      - data

  correlate:
    doc: |
      Using R script, find Pearson correlation coefficient
      between CO and Ozone
    run: correlate.cwl
    in:
      data1: aggregate_co/data
      data2: aggregate_ozone/data
    out:
      - result


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
  correlation:
    type: File
    outputSource:  correlate/result
    