This package contains a single function : `spatialize`. Its purpose is to make a simple deterministic spatilization of an hourly record of a passed weather parameter based on the records stored by the PAMESEB automatic weather station network. As output this function produces a json file containing the spatialized data. You can then use it with e.g. a leaflet map.

# How to install it ?

Within R : 
`devtools::install_github("pokyah/spagromet", ref="master")`

# How to get the doc ? 

Once installed, simply type `help(spatialize)` within R.

# how to use this function from the command line ? 

Once the package is installed on your machine, you will need an extra piece of code to call its function. This code could of course be written in any language.

If you want to call it with a UNIX bash command and you are familiar with [Rscript](http://www.milanor.net/blog/bashr-howto-pass-parameters-from-bash-script-to-r/), you could simply copy/paste the `bash_spatialize.R` script in the directory of your choice and invoke it using the following bash command : 

```bash
spatialized_data=$( Rscript --vanilla <PATH_TO_bash_spatialize.R> <YYYY-MM-DD> <SENSOR_NAME> <spagromet_token>)
```

This `bash_spatialize.R` script basically parse the arguments <YYYY-MM-DD>, <SENSOR_NAME> and <API_TOKEN> you pass to your bash command and send them to the `spagromet::spatialize` function.

To echo the result in your terminal: 

```bash
echo"$spatialized_data"
```

Please note that if you use the [--vanilla flag](https://www.math.ucla.edu/~anderson/rw1001/library/base/html/Startup.html), the .Renviron file will not be loaded. So you might need to pass your API_TOKEN in a way that does not require a call the `Sys.getenv()`. More about invoking R from the command line in [this](https://colinfay.me/intro-to-r/appendix-b-invoking-r.html) "intro to R" book chapter




