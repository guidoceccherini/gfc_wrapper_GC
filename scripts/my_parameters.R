## parameters
threshold   <- 30
max_year    <- 18
aoi_list    <- c("BIH")
countrycode <- aoi_list[1]
spacing     <- 1000 #0.011
offset      <- 0.001
proj        <- '+proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
nb_iter     <- 10

## Set a range of sub-sampling (take a point every xx point)
classes <- c(100,50,40,30,20,10,5,4,3,2,1)
