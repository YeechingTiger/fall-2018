# rstudio Docker Images (https://hub.docker.com/r/rocker/rstudio/)
# macOS

# 1) open macOS teminal

# 2) pull rocker/rstudio
docker pull rocker/rstudio

# 3a) boot into container
docker run --rm -d -p 8787:8787 -e PASSWORD=gator rocker/rstudio

# 3b) boot into container with share folder that contains data
# Please change "/Users/xinghe/Dropbox\ \(UFL\)/2018/2018-Other/2018-Course/Trans_BioInfo/data" to your own path
docker run -v /Users/xinghe/Dropbox\ \(UFL\)/2018/2018-Other/2018-Course/Trans_BioInfo/data:/home/rstudio/data --rm -p 8787:8787 -e PASSWORD=gator rocker/rstudio


# open browswer and type into search bar
http://localhost:8787

# username: rstudio
# password: gator
