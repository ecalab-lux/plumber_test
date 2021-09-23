library(tidyverse)

#* @apiTitle ECA DM API

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}


# test by WO

#* Convert a SAP dump to an Excel file with relevant data only
#* @param fn the full path to to file to convert
#* @param agency the full path to to file to convert
#* @get /rawSAP

readRawSAP <- function(fn, agency){

# read file line by line
a <- read_lines(fn)
  
# fix encoding  
a <- iconv(a, from = 'ISO-8859-1', to = 'ASCII//TRANSLIT') %>% as_tibble()
  
# select the lines that contain data (by means of the presence of the separator)  
b <- a %>% as_tibble()%>% filter(stringr::str_detect(value, fixed("|") ))

#number of columns after splitting by space
ncols <- max(stringr::str_count(b$value,  fixed("|"))) + 1
  
#generate necessary column names
colnm <- paste("col", 1:ncols)

#create header for file
c <- b %>% head(1) %>% separate(value, sep ="\\|", into = colnm, remove = TRUE) 

#select relevant data only  
d <-b %>% filter(stringr::str_detect(value,agency))%>% separate(value, sep ="\\|", into = colnm, remove = TRUE) 

# add header  
ds <- bind_rows(c,d)
writexl::write_xlsx(ds,"PlumberTest.xlsx", col_names = FALSE)
}   
