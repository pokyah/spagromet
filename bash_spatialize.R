#!/usr/bin/env Rscript

#parsing the CLI args
args = commandArgs(trailingOnly=TRUE)

# test if there required argument are passed. if not, return an error
if (length(args) == 0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args) == 2) {
  # default output file
json = spagromet::spatialize(as.character(args[1]), as.character(args[2]))
 cat(json)
}