#!/usr/bin/env cwl-runner
### Python processor example
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
class: CommandLineTool
baseCommand: [python, '-m', 'fasrc_sample_tools.geo_aggregator']

doc: |
  This tool aggregates values bound to geographic coordinates
  (latitude and longitude) to zip codes using US Census shape files for zips

requirements:
  InlineJavascriptRequirement: {}


inputs:
  shapes:
    type: File[]
    doc:
    inputBinding:
      position: 1
  data:
    type: File
    doc: 
    inputBinding:
      position: 2
  target:
    type: string
    doc: A name of the file with the aggregated data
    inputBinding:
      position: 3


outputs:
    data:
      type: File
      outputBinding:
        glob: $(inputs.target)
