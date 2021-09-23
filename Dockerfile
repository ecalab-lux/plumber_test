FROM rstudio/plumber
# Create a non-root user
# Please match this with host machine desired uid and gid
RUN groupadd -r --gid 1000 ruser # 901 for ecadockerhub, 1000 for black
RUN useradd --no-log-init --uid 1000 -r -m -g ruser ruser # 954 for ecadockerhub, 1000 for black
USER ruser
WORKDIR /home/ruser
RUN mkdir rlib
# install here all the packages you need
RUN R -e "install.packages('tidyverse', dependencies=TRUE, lib='rlib')"
# add the new user repositories
#RUN R -e "myPaths <- .libPaths()\nmyPaths <- c(myPaths, '/home/ruser/rlib')\n.libPaths(myPaths)"
ENV R_LIBS_USER="/home/ruser/rlib"
