FROM rstudio/plumber
# install here all the packages you need
RUN Rscript -e "install.packages('tidyverse')"

