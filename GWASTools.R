# **************************************************************************** #
# ***************                GWASTools Example                 *************** #
# **************************************************************************** #

# URL:      http://bioconductor.org/packages/release/bioc/html/GWASTools.html 
# Date:     Oct 09 2017
# Description: Tools for Genome Wide Association Studies 

# **************************************************************************** #
# ***************                Library/Install                       
# **************************************************************************** #

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("GWASTools")
biocLite("GWASdata")

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("GWASdata")

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()    



library(GWASTools)
library(GWASdata)

browseVignettes("GWASTools")

# **************************************************************************** #
# ***************                Summary                       
# **************************************************************************** #

# In this tutorial, we will:
#  1. learn about the Sequence Read Archives (SRA)
#  2. learn to index the SRA
#  3. download a sequence file

# **************************************************************************** #
# ***************                Introduction                       
# **************************************************************************** #

# This vignette takes a user through the data cleaning steps developed and used for genome wide
# association data as part of the Gene Environment Association studies (GENEVA) project. This
# project (http://www.genevastudy.org) is a collection of whole-genome studies supported by the
# NIH-wide Gene-Environment Initiative. The methods used in this vignette have been published in
# Laurie et al. (2010).1 For replication purposes the data used here are taken from the HapMap project. 
# These data were # kindly provided by the Center for Inherited Disease Research (CIDR) at Johns Hopkins University
# and the Broad Institute of MIT and Harvard University (Broad). The data are in the same format
# as these centers use in providing data to investigators: the content and format of these data are
# a little different from those for processed data available at the HapMap project site. The data
# supplied here should not be used for any purpose other than this tutorial.

