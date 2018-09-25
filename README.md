This package contains a single function : `spatialize`.

# how to install it ?
from R : 
`devtools::intall_github("pokyah/spagromet@v1.0")`

# how to use it from the command line ? 

once the package is installed, you will need to copy/paste the `bash_spatialize.R` script in the directory of your choice. This script basically parse the arguments you will pass to your bash command and send them to the `spagromet::spatialize` function.

To call this script from a bash terminal :
`a=$( Rscript --vanilla <PATH_TO_bash_spatialize.R> 2017-03-04 tsa spagromet_token)`

Then to echo the result in your terminal: 
`echo"$a"`


# from docker 
sudo docker ps
sudo docker exec -i -t 210d3850788a /bin/bash

R

devtools::install_github("pokyah/spagromet", ref="master")

