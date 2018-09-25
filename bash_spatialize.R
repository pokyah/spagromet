#!/usr/bin/env Rscript

#parsing the CLI args
args = commandArgs(trailingOnly=TRUE)

# test if there required argument are passed. if not, return an error
if (length(args) == 0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args) == 3) {
  # default output file
json = spagromet::spatialize(isodatetime = as.character(args[1]), sensor = as.character(args[2]), token_env_var = as.character(args[3]))
 cat(json)
}
