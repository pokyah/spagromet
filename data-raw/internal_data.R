# calling the API to get the data
data2spatialize = agrometAPI::get_from_agromet_API(dfrom = as.Date("2017-03-04"), dto = as.Date("2017-03-04"))
data2spatialize = agrometAPI::prepare_agromet_API_data.fun(data2spatialize)

# making sure we only keep the relevant stations
data2spatialize = data2spatialize %>%
  dplyr::filter(!is.na(mtime)) %>%
  dplyr::filter(sid != 38 & sid != 41) %>%
  dplyr::filter(!is.na(from)) %>%
  dplyr::filter(!is.na(to)) %>%
  dplyr::filter(type_name != "PS2000" & type_name != "PESSL" & type_name != "BODATA" & type_name != "Sencrop" & type_name != "netdl1000" & type_name != "SYNOP") %>%
  dplyr::filter(poste != "China")

good_stations = data2spatialize$sid

load(paste0(getwd(), "/data-raw/expl.static.grid.df.rda"))
grid.sp = expl.static.grid.df
sf::st_geometry(grid.sp) <- NULL
sp::coordinates(grid.sp) = ~X+Y
grid_CRS <- sp::CRS("+proj=lcc +lat_1=49.83333333333334 +lat_2=51.16666666666666 +lat_0=50.797815 +lon_0=4.359215833333333 +x_0=649328 +y_0=665262 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs ")
raster::crs(grid.sp) = grid_CRS
sp::gridded(grid.sp) = TRUE


devtools::use_data(good_stations, grid.sp, internal = TRUE, overwrite = TRUE)
