# rstudio Docker Images (https://hub.docker.com/r/rocker/rstudio/)
# windows

# 1) open docker teminal

# 2) pull rocker/rstudio
docker pull rocker/rstudio

# 3a) boot into container
docker run --rm -d -p 8787:8787 -e PASSWORD=gator rocker/rstudio

# 3b) boot into container with share folder that contains data
docker run -v /c/Users/djlemas/Documents/MyMetabolomics:/home/rstudio/data --rm -p 8787:8787 -e PASSWORD=gator rocker/rstudio

# open browswer and type into search bar
http://192.168.99.100:8787