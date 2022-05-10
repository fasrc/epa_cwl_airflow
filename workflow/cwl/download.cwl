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
class: CommandLineTool
baseCommand: [curl]

requirements:
  InlineJavascriptRequirement: {}


inputs:
  url:
    type: string
    doc: Download URL
    inputBinding:
      position: 2
  target:
    type: string
    doc: A name of the file with the downloaded data
    inputBinding:
      prefix: "-o"

arguments:
    - valueFrom: "-L"
      position: 1

outputs:
    data:
      type: File
      outputBinding:
        glob: $(inputs.target)
