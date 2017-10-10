# **************************************************************************** #
# ***************                DNA SEQUENCE STATISTICS       *************** #
# **************************************************************************** #

# URL:      https://media.readthedocs.org/pdf/a-little-book-of-r-for-bioinformatics/latest/a-little-book-of-r-for-bioinformatics.pdf 
# Date:     Sept 18 2017
# Description: seqinr package, basic sequence analysis and descriptive stats 

# **************************************************************************** #
# ***************                Library                       
# **************************************************************************** #

# install.packages("seqinr")
library(seqinr)

# **************************************************************************** #
# ***************                Summary                       
# **************************************************************************** #
 
# In this tutorial, we will cover the following R functions:
#  1. length() for finding the length of a vector or list
#  2. table() for printing out a table of the number of occurrences of each type of item in a vector or list.
#  3. GC() for calculating the GC content for a DNA sequence
#  4. count() for calculating the number of occurrences of DNA words of a particular length in a DNA sequence

# **************************************************************************** #
# ***************       Neglected Tropical diseases            
# **************************************************************************** #

# Neglected tropical diseases are serious diseases that affect many people in 
# tropical countries and which have been relatively little studied. The World 
# Health Organisation lists the following as neglected tropical diseases:
# trachoma, leprosy, schistosomiasis, soil transmitted helminths, lymphatic 
# filariasis, onchocerciasis, Buruli ulcer, yaws, Chagas disease, 
# African trypanosomiasis, leishmaniasis, Dengue fever, rabies, Dracunculiasis 
# (guineaworm # disease), and Fascioliasis 
# (see http://www.who.int/neglected_diseases/diseases/en/).

# The genomes of many of the organisms that cause neglected tropical diseases have been fully sequenced, including:
#  . the Dengue virus, which causes Dengue fever

# **************************************************************************** #
# ***************           FASTA FORMAT                       
# **************************************************************************** #

# The FASTA format is a simple and widely used format for storing biological 
# (DNA or protein) sequences. It was first used by the FASTA program for sequence 
# alignment. It begins with a single-line description starting with a
# ">" character, followed by lines of sequences. Here is an example of a FASTA file:

# > A06852 183 residues
# MPRLFSYLLGVWLLLSQLPREIPGQSTNDFIKACGRELVRLWVEICGSVSWGRTALSLEE
# PQLETGPPAETMPSSITKDAEILKMMLEFVPNLPQELKATLSERQPSLRELQQSASKDSN
# LNFEEFKKIILNRQNEAEDKSLLELKNLGLDKHSRKKRLFRMTLSEKCCQVGCIRKDIAR
# LC

# **************************************************************************** #
# ***************       The NCBI sequence database            
# **************************************************************************** #

# The National Centre for Biotechnology Information (NCBI) (www.ncbi.nlm.nih.gov) 
# in the US maintains a huge database of all the DNA and protein sequence data 
# that has been collected, the NCBI Sequence Database. This also a similar database 
# in Europe, the European Molecular Biology Laboratory (EMBL) Sequence Database 
# (www.ebi.ac.uk/embl), and also a similar database in Japan, 
# the DNA Data Bank of Japan (DDBJ; www.ddbj.nig.ac.jp). These three databases 
# exchange data every night, so at any one point in time, they contain almost 
# identical data.

# Each sequence in the NCBI Sequence Database is stored in a separate record, and 
# is assigned a unique identifier that can be used to refer to that sequence record. 
# The identifier is known as an accession, and consists of a mixture of numbers 
# and letters. For example, Dengue virus causes Dengue fever, which is classified 
# as a neglected tropical disease by the WHO. by any one of four types of Dengue virus: 
# DEN-1, DEN-2, DEN-3, and DEN-4. The NCBI accessions for the DNA sequences of the 
# DEN-1, DEN-2, DEN-3, and DEN-4 Dengue viruses are NC_001477, NC_001474, NC_001475 
# and NC_002640, respectively. Note that because the NCBI Sequence Database, 
# the EMBL Sequence Database, and DDBJ exchange data every night, the DEN-1 
# (and DEN-2, DEN-3, DEN-4) Dengue virus sequence will be present in all three databases, 
# but it will have different accessions in each database, as they each use their 
# own numbering systems for referring to their own sequence records.

# **************************************************************************** #
# ***************   Retrieving genome sequence data using SeqinR   
# **************************************************************************** #

# Instead of going to the NCBI website to retrieve sequence data from the NCBI 
# database, you can retrieve sequence data from NCBI directly from R, by using 
# the SeqinR R package.

# For example, you can retrieve the DEN-1 Dengue virus genome sequence, which has NCBI
# accession NC_001477, from the NCBI website. To retrieve a sequence with a particular 
# NCBI accession, you can use R function "getncbiseq()" below, which you will first 
# need to copy and paste into R:

# function in the example

getncbiseq <- function(accession)
{
  require("seqinr") # this function requires the SeqinR R package
  # first find which ACNUC database the accession is stored in:
  dbs <- c("genbank","refseq","refseqViruses","bacterial")
  numdbs <- length(dbs)
  for (i in 1:numdbs)
  {
    db <- dbs[i]
    choosebank(db)
    # check if the sequence is in ACNUC database 'db':
    resquery <- try(query(".tmpquery", paste("AC=", accession)), silent = TRUE)
    if (!(inherits(resquery, "try-error")))
    {
      queryname <- "query2"
      thequery <- paste("AC=",accession,sep="")
      query(`queryname`,`thequery`)
      # see if a sequence was retrieved:
      seq <- getSequence(query2$req[[1]])
      closebank()
      return(seq)
    }
    closebank()
  }
  print(paste("ERROR: accession",accession,"was not found"))
}

# Error in getSequence(query2$req[[1]]) : object 'query2' not found
# google: getncbiseq() 
# https://stackoverflow.com/questions/37856007/error-with-a-function-to-retrieve-data-from-a-database

# new function

getncbiseq <- function(accession)
{
  require("seqinr") # this function requires the SeqinR R package
  # first find which ACNUC database the accession is stored in:
  dbs <- c("genbank","refseq","refseqViruses","bacterial")
  numdbs <- length(dbs)
  for (i in 1:numdbs)
  {
    db <- dbs[i]
    choosebank(db)
    # check if the sequence is in ACNUC database 'db':
    resquery <- try(query(".tmpquery", paste("AC=", accession)), silent = TRUE)
    
    if (!(inherits(resquery, "try-error"))) {
      queryname <- "query2"
      thequery <- paste("AC=", accession, sep="")
      query2 <- query(queryname, thequery)
      # see if a sequence was retrieved:
      seq <- getSequence(query2$req[[1]])
      closebank()
      return(seq)
    }
    closebank()
  }
  print(paste("ERROR: accession",accession,"was not found"))
}

# it works!!
dengueseq <- getncbiseq("NC_001477")

# The variable dengueseq is a vector containing the nucleotide sequence. 
# Each element of the vector contains one nucleotide of the sequence. 
# Therefore, to print out a certain subsequence of the sequence, we just 
# need to type the name of the vector dengueseq followed by the square 
# brackets containing the indices for those nucleotides. For example, 
# the following command prints out the first 50 nucleotides of the 
# DEN-1 Dengue virus genome sequence:

dengueseq[1:50]

# **************************************************************************** #
# ***************   Writing sequence data out as a FASTA file       
# **************************************************************************** #

# If you have retrieved a sequence from the NCBI database using the 
# "getncbiseq()" function, you may want to save the sequence to a FASTA-format file 
# on your computer, in case you need the sequence for further analyses 
# (either in R or in other software).

# You can write out a sequence to a FASTA-format file in R by using the 
# "write.fasta()" function from the SeqinR R package. The write.fasta() function 
# requires that you tell it the name of the output file using the "file.out" argument
# (input). You also need to specify the R variable that contains the sequence 
# using the "sequences" argument, and the name that you want to give to the sequence 
# using the "names" argument. For example, if you have stored the DEN-1 Dengue virus 
# sequence in a vector dengueseq, to write out the sequence to a FASTA-format file 
# called "den1.fasta" that contains the sequence labelled as "DEN-1", you can type:
  
write.fasta(names="DEN-1", sequences=dengueseq, file.out="den1.fasta")


# **************************************************************************** #
# ***************         Reading sequence data into R        
# **************************************************************************** #

# what is my working directory? 
getwd()

# copy "den1.fasta" to this location
dengue=read.fasta(file="den1.fasta")
dengue[[1]]

# **************************************************************************** #
# ***************         Length of a DNA sequence        
# **************************************************************************** #

length(dengueseq)  
# 10735

# **************************************************************************** #
# ***************         Base composition of a DNA sequence        
# **************************************************************************** #

table(dengueseq)

# a    c    g    t 
# 3426 2240 2770 2299 

# create variables that computes each base count individually
a=table(dengueseq)[1];a  # 3426
c=table(dengueseq)[2];c  # 2240
g=table(dengueseq)[3];g  # 2770
t=table(dengueseq)[4];t  # 2299


# **************************************************************************** #
# ***************         GC Content of DNA sequence        
# **************************************************************************** #

# One of the most fundamental properties of a genome sequence is its GC content, 
# the fraction of the sequence that consists of Gs and Cs, ie. the %(G+C).
# The GC content can be calculated as the percentage of the bases in the genome 
# that are Gs or Cs. That is, GC content = (number of Gs + number of Cs)*100/(genome length). 
# For example, if the genome is 100 bp, and 20 bases are Gs and 21 bases are Cs, 
# then the GC content is (20 + 21)*100/100 = 41%.

# You can easily calculate the GC content based on the number of As, Gs, Cs, and Ts 
# in the genome sequence. For example, for the DEN-1 Dengue virus genome sequence, 
# we know from using the table() function above that the genome contains 3426 As, 
# 2240 Cs, 2770 Gs and 2299 Ts. Therefore, we can calculate the GC content using the
# command:

(2240+2770)*100/(3426+2240+2770+2299)

# or 

(c+g)*100/(a+c+g+t)

# or

GC(dengueseq)

# **************************************************************************** #
# ***************         DNA words        
# **************************************************************************** #

# As well as the frequency of each of the individual nucleotides ("A", "G", "T", "C") 
# in a DNA sequence, it is also interesting to know the frequency of longer DNA "words". 
# The individual nucleotides are DNA words that are 1 nucleotide long, but we may also 
# want to find out the frequency of DNA words that are 2 nucleotides long 
# (ie. "AA", "AG", "AC", "AT", "CA", "CG", "CC", "CT", "GA", "GG", "GC", "GT", "TA", "TG", "TC", and "TT"), 
# 3 nucleotides long (eg. "AAA", "AAT", "ACG", etc.), 4 nucleotides long, etc.
# To find the number of occurrences of DNA words of a particular length, we can use 
# the count() function from the R SeqinR package. For example, to find the number of 
# occurrences of DNA words that are 1 nucleotide long in the sequence dengueseq, we type:

# counts of 1 nucleotide (same results as table())
count(dengueseq, 1)

# counts of 2 nucleotide
count(dengueseq, 2)

# extract the 3rd element 
count(dengueseq, 2)[3]

# **************************************************************************** #
# ***************         Exercises        
# **************************************************************************** #

# Answer key: https://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/src/chapter_answers.html#dna-sequence-statistics-1

# Q1. What are the last twenty nucleotides of the Dengue virus genome sequence(accession NC_001477)?

# Q2. What is the length in nucleotides of the genome sequence for the bacterium 
#     Mycobacterium leprae strain TN (accession NC_002677)?
#     Note: Mycobacterium leprae is a bacterium that is responsible for causing leprosy, 
#     which is classified by the WHO as a neglected tropical disease. 
#     As the genome sequence is a DNA sequence, if you are retrieving its sequence via the NCBI website, 
#     you will need to look for it in the NCBI Nucleotide database.

# Q3. How many of each of the four nucleotides A, C, T and G, and any other symbols, 
#     are there in the Mycobacterium leprae TN genome sequence?
#     Note: other symbols apart from the four nucleotides A/C/T/G may appear in a sequence. 
#     They correspond to positions in the sequence that are are not clearly one base or another 
#     and they are due, for example, to sequencing uncertainties. or example, 
#     the symbol 'N' means 'aNy base', while 'R' means 'A or G' (puRine). 
#     There is a table of symbols at www.bioinformatics.org/sms/iupac.html.

# Q4. What is the GC content of the Mycobacterium leprae TN genome sequence, 
#     when (i) all non-A/C/T/G nucleotides are included, (ii) non-A/C/T/G nucleotides are discarded?
#     Hint: look at the help page for the GC() function to find out how it deals with non-A/C/T/G nucleotides.

# Q5. How many of each of the four nucleotides A, C, T and G are there in the complement of the 
#     Mycobacterium leprae TN genome sequence?
#     Hint: you will first need to search for a function to calculate the complement of a sequence. 
#     Once you have found out what function to use, remember to use the help() function to find out 
#     what are the arguments (inputs) and results (outputs) of that function. How does the function deal 
#     with symbols other than the four nucleotides A, C, T and G? Are the numbers of As, Cs, Ts, and Gs 
#     in the complementary sequence what you would expect?

# Q6. How many occurrences of the DNA words CC, CG and GC occur in the Mycobacterium leprae TN genome sequence?

# Q7. How many occurrences of the DNA words CC, CG and GC occur in the (i) first 1000 and 
#     (ii) last 1000 nucleotides of the Mycobacterium leprae TN genome sequence?
#     How can you check that the subsequence that you have looked at is 1000 nucleotides long?



