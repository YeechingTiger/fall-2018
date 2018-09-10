# bioconductor Docker Images (https://www.bioconductor.org/help/docker/)
# macOS

# 1) open docker teminal

# 2) bioconductor/devel_core2
docker pull bioconductor/devel_core2

# 3a) boot into container
docker run -ti bioconductor/devel_base2 R

# 3b) boot into container with share folder that contains data
# Please change "/Users/xinghe/Dropbox\ \(UFL\)/2018/2018-Other/2018-Course/Trans_BioInfo/data" to your own folder path
docker run -ti -v /Users/xinghe/Dropbox\ \(UFL\)/2018/2018-Other/2018-Course/Trans_BioInfo/data:/data --rm bioconductor/devel_core2 R

# 4) from within R, change directories to sharedrive
setwd('/data')