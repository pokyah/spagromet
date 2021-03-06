#' Query the API and spatialize the data
#' @author Thomas Goossens
#' @importFrom jsonlite toJSON
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#' @importFrom raster crs
#' @importFrom gstat idw
#' @importFrom agrometAPI get_data
#' @importFrom agrometAPI type_data
#' @importFrom sp coordinates
#' @importFrom sp CRS
#' @importFrom sp spTransform
#' @param isodatetime A character specifying the isodatetime ("YYYY-MM-DDTHH:MM:SS") set of records you want to spatialize
#' @param sensor A character specifying the sensor you want to spatiliaze (tsa, hra)
#' @param token_env_var A character specifying your agromet API token.
#' @return A json containing the spatialized data.
#' @export
spatialize <- function(isodatetime, sensor, user_token){

 # calling the API to get the data
 data2spatialize = agrometAPI::get_data(dfrom = as.Date(isodatetime), dto = as.Date(isodatetime), user_token = user_token)
 data2spatialize = agrometAPI::type_data(data2spatialize)

 # making sure we only keep the relevant stations
 data2spatialize = data2spatialize %>%
   dplyr::filter(sid %in% (as.character(good_stations)))

 # transforming to a sp spatial object and setting the CRS (which is known from the API metadata)
 sp::coordinates(data2spatialize) = ~longitude+latitude
 API_CRS <- sp::CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
 raster::crs(data2spatialize) = API_CRS

  # reprojecting in the same CRS as grid
 data2spatialize <- sp::spTransform(data2spatialize, raster::crs(grid.sp))

 # interpolating using simple IDW
 f <- paste0(sensor,"~1")
 f <- as.formula(f)
 spatialized = gstat::idw(f, data2spatialize, grid.sp)
 spatialized = spatialized["var1.pred"]
 spatialized = sp::spTransform(spatialized, API_CRS)

 # generate the maps
 # static.map = sp::spplot(spatialized, do.log = F, colorkey = TRUE,  main = paste0("interpolated ", sensor))
 # interactive.map = mapview::mapview(spatialized)

 # transforming to dataframe with proper column names
 spatialized = as.data.frame(spatialized)
 colnames(spatialized) = c(sensor, "longitude", "latitude")

 # export as json object
 spatialized <- jsonlite::toJSON(spatialized)

 # return the json object
 return(spatialized)

 # https://gis.stackexchange.com/questions/171827/generate-html-file-with-r-using-leaflet

}