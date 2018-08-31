# bioconductor Docker Images (https://www.bioconductor.org/help/docker/)
# windows

# 1) open docker teminal

# 2) bioconductor/devel_core2
docker pull bioconductor/devel_core2

# 3a) boot into container
docker run -ti bioconductor/devel_base2 R

# 3b) boot into container with share folder that contains data
docker run -ti -v /c/Users/djlemas/Documents/MyMetabolomics:/data --rm bioconductor/devel_core2 R

# 4) from within R, change directories to sharedrive
setwd('/data')