#!/usr/bin/env Rscript

#parsing the CLI args
args = commandArgs(trailingOnly=TRUE)

# test if there required argument are passed. if not, return an error
if (length(args) == 0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args) == 3) {
  # default output file
json = spagromet::spatialize(isodatetime = (args[1]), sensor = (args[2]), user_token = (args[3]))
 cat(json)
}

# using this command from bash :
# spatialized_data=$( Rscript --vanilla <PATH_TO_bash_spatialize.R> <YYYY-MM-DD> <SENSOR_NAME> <API_TOKEN>)
