# **************************************************************************** #
# ***************                SRAdb Example                 *************** #
# **************************************************************************** #

# URL:      https://bioconductor.org/packages/release/bioc/html/SRAdb.html   
# Date:     Sept 23 2017
# Description: SRAdb package, basic sequence analysis and descriptive stats 

# **************************************************************************** #
# ***************                Library/Install                       
# **************************************************************************** #

## try http:// if https:// URLs are not supported
#  source("https://bioconductor.org/biocLite.R")
#  biocLite("SRAdb")

library(SRAdb)
setInternet2(use=FALSE)

# tutorial document
browseVignettes("SRAdb")

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

# High throughput sequencing technologies have very rapidly become standard tools in biology.
# The data that these machines generate are large, extremely rich. As such, the Sequence
# Read Archives (SRA) have been set up at NCBI in the United States, EMBL in Europe,
# and DDBJ in Japan to capture these data in public repositories in much the same spirit as
# MIAME-compliant microarray databases like NCBI GEO and EBI ArrayExpress.
# Accessing data in SRA requires finding it first. This R package provides a convenient and
# powerful framework to do just that. In addition, SRAdb features functionality to determine
# availability of sequence files and to download files of interest.
# SRA currently store aligned reads or other processed data that relies on alignment to a reference
# genome. Please refer to the SRA handbook (http://www.ncbi.nlm.nih.gov/books/NBK47537/)
# for details. NCBI GEO also often contain aligned reads for sequencing experiments and the
# SRAdb package can help to provide links to these data as well. In combination with the
# GEOmetadb and GEOquery packages, these data are also, then, accessible.

# **************************************************************************** #
# ***************                Getting Started                       
# **************************************************************************** #

# Since SRA is a continuously growing repository, the SRAdb SQLite file is updated regularly.
# The first step, then, is to get the SRAdb SQLite file from the online location. The download
# and uncompress steps are done automatically with a single command, getSRAdbFile.

# this will create 'SRAmetadb.sqlite' in working directory
sqlfile <- 'SRAmetadb.sqlite'
if(!file.exists('SRAmetadb.sqlite')) sqlfile <<- getSRAdbFile()

# details about the 'SRAmetadb.sqlite' file
file.info('SRAmetadb.sqlite')

# create a connection to the SRA database for later queries
sra_con <- dbConnect(SQLite(),sqlfile)
sra_tables <- dbListTables(sra_con)
sra_tables

# **************************************************************************** #
# ***************                Conversion of SRA entity types                      
# **************************************************************************** #

# Large-scale consumers of SRA data might want to convert SRA entity type from one to
# others, e.g. finding all experiment accessions (SRX, ERX or DRX) and run accessions (SRR,
# ERR or DRR) associated with "SRP001007" and "SRP000931". Function sraConvert does
# the conversion with a very fast mapping between entity types.

#Covert "SRP001007" and "SRP000931" to other possible types in the SRAmetadb.sqlite:
conversion <- sraConvert( c('SRP001007','SRP000931'), sra_con = sra_con )
conversion[1:3,]

# Check what SRA types and how many entities for each type:
apply(conversion, 2, unique)

# **************************************************************************** #
# ***************                Download SRA data files                      
# **************************************************************************** #

# List ftp addresses of the fastq files associated with "SRX000122":
rs = listSRAfile( c("SRX000122"), sra_con, fileType = 'sra' )

# The above function does not check file availability, size and date of the sra data files on
# the server, but the function getSRAinfo does this, which is good to know if you are preparing
# to download them:
  
rs = getSRAinfo ( c("SRX000122"), sra_con, sraType = "sra" )
rs[1:3,]

# Next you might want to download sra data files from the ftp site. The getSRAfile function
# will download all available sra data files associated with "SRR000648" and "SRR000657"from
# the NCBI SRA ftp site to the current directory:

getSRAfile( c("SRR000648"), sra_con, fileType = 'sra' )

# If download fails, copy and past the link below into browser
# ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX000/SRX000122/SRR000648/SRR000648.sra

# Then downloaded sra data files can be easily converted into fastq files using fastq-dump
# in SRA Toolkit ( http://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software ). This requires
# installation of SRA toolskit AND including the program in the PATH.

system ("fastq-dump SRR000648.sra")
  
