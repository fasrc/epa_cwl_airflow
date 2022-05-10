#!/usr/bin/env cwl-runner
### R in-file example
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
baseCommand: [RScript, 'correlate.r']

doc: |
  This tool aggregates values bound to geographic coordinates
  (latitude and longitude) to zip codes using US Census shape files for zips

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: correlate.r
        entry: |
          args <- commandArgs(trailingOnly=TRUE)
          x <- read.csv(args[1])[, c("ZCTA5CE20", "Value")]
          y <- read.csv(args[2])[, c("ZCTA5CE20", "Value")]
          data <- merge(x, y, by = "ZCTA5CE20")
          print(data)
          c <- cor(data$Value.x, data$Value.y)
          print(c)
          write(paste("Corrleation coefficient = ", c), file="pearson.txt")

inputs:
  data1:
    type: File
    doc: First series of values
    inputBinding:
      position: 1
  data2:
    type: File
    doc: First series of values
    inputBinding:
      position: 2

outputs:
  result:
    type: File
    outputBinding:
      glob: "pearson.txt"
