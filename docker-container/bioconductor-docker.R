# bioconductor Docker Images (https://www.bioconductor.org/help/docker/)
# windows

# 1) open docker teminal

# 2) bioconductor/devel_core2
docker pull bioconductor/devel_core2

# 3a) boot into container
docker run --rm -d -p 8787:8787 -e PASSWORD=gator bioconductor/devel_core2

# 3b) boot into container with share folder that contains data
docker run -v /c/Users/djlemas/Documents/MyMetabolomics:/home/rstudio/data --rm bioconductor/devel_core2
