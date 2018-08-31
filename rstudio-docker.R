# Docker Images (https://www.bioconductor.org/help/docker/)

# bioconductor/devel_core2
docker pull bioconductor/devel_core2

# 1) open docker teminal

# 2) pull rocker/rstudio
docker pull rocker/rstudio

# 3) navigate to location of data thorugh CLI
# $ cd Documents/MyMetabolomics

# 4) run docker and mount "working directory" to directory "/home/data" in docker containter
# $ docker run -it -v "$(pwd)":/home/data bioconductor/release_metabolomics2 /bin/bash

# boot into rstudio
docker run --rm -d -p 8787:8787 -e PASSWORD=gator rocker/rstudio

# boot into rstudio with share folder
docker run -v /c/Users/djlemas/Documents/MyMetabolomics:/home/rstudio/data --rm -p 8787:8787 -e PASSWORD=gator rocker/rstudio

# open browswer and type into search bar
http://192.168.99.100:8787






