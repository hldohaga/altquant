
library(raster)
library(rgdal)
library(tmap)
library(maptools)
library(sf)


ogrInfo("infuse_rgn_2011.shp")
plot(readOGR("infuse_rgn_2011.shp"))

plot(readOGR("infuse_gb_2011.shp"))
download.file("https://borders.ukdataservice.ac.uk/ukborders/easy_download/prebuilt/shape/England_gor_2011.zip",
              destfile = "eregions.zip")
unzip("eregions.zip")

download.file("https://borders.ukdataservice.ac.uk/ukborders/easy_download/prebuilt/shape/Wales_2011.zip",
              destfile = "wregions.zip")
unzip("wregions.zip")

England<- readOGR("England_gor_2011")


regions <- sf::read_sf("england_gor_2011.shp")
ogrInfo("england_gor_2011.shp")
pryr::object_size(regions)

regions_1k <- sf::st_simplify(regions, preserveTopology = TRUE, dTolerance = 1000)
pryr::object_size(regions_1k)

plot(regions_1k)

regions_10k <- sf::st_simplify(regions, preserveTopology = TRUE, dTolerance = 10000)
pryr::object_size(regions_10k)
plot(regions_10k)



library(sf)
regions <- sf::read_sf("england_gor_2011.shp")
regions_1k <- sf::st_simplify(regions, preserveTopology = TRUE, dTolerance = 1000)
plot(regions_1k)
regions_10k <- sf::st_simplify(regions, preserveTopology = TRUE, dTolerance = 10000)
plot(regions_10k)
devtools::install_github("rsbivand/rgrass7")
library(rgrass)
td <- tempdir()
library(maptools)
SG <- Sobj_SpatialGrid(as(regions, "Spatial"))$SG
initGRASS("/home/rsb/topics/grass/g720/grass-7.2.0", td, SG)
writeVECT(regions, "regions", v.in.ogr_flags="o")
execGRASS("v.generalize", input="regions", type="area", output="regions10k", threshold=10000, method="douglas")
regions_10k_GRASS <- readVECT("regions10k")
plot(regions_10k_GRASS)




