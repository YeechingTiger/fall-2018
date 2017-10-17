# **************************************************************************** #
# ***************                GenABEL Example                 *************** #
# **************************************************************************** #

# URL:      http://www.genabel.org/packages
# URL:      http://www.genabel.org/sites/default/files/pdfs/GenABEL-tutorial.pdf
# Date:     Oct 17 2017
# Description: statistical analyses of polymorphic genome data 

# **************************************************************************** #
# ***************                Library/Install                       
# **************************************************************************** #

# install.packages("GenABEL")
library(GenABEL)
data(ge03d2ex)

# **************************************************************************** #
# ***************                Summary                       
# **************************************************************************** #

# In this tutorial, we will use the descriptives family of functions to facilitate the
# production of tables which can be directly used in a manuscript - it is
# possible to save the output as a file, which can be open by Excel or Word.

# **************************************************************************** #
# ***************                Data descriptives                       
# **************************************************************************** #

# Investigate the objects loaded by the command
ls()

# The ge03d2ex is an object of the class gwaa.data:
class(ge03d2ex)

# To check what are the names of variables in the phenotypic data frame
names(phdata(ge03d2ex))

# We can attach this data frame to the R search path by
attach(phdata(ge03d2ex))

# Let us investigate which traits are present in the loaded data frame and what are
# the characteristics of the distribution by using the GenABEL-package function
# descriptive.trait:
descriptives.trait(ge03d2ex)

# You can see that the phenotypic frame contains data on 136 people; the
# data on sex, age, height, weight, diet and body mass index (BMI) are available.
# Our trait of interest is dm2 (type 2 diabetes). Note that every single piece
# of information in this data set is simulated; however, we tried to keep our
# simulations in a way we think the control of T2D may work. 
# You can produce a summary for cases and controls separately and compare
# distributions of the traits by

descriptives.trait(ge03d2ex, by=dm2)

# Here, the by argument specifies the grouping variable. You can see that cases
# and controls are different in weight, which is expected, as T2D is associated
# with obesity. Similarly, you can produce grand GW descriptives of the marker 
# data by using

descriptives.marker(ge03d2ex)

# It is of note that we can see inflation of the proportion of the tests for HWE at
# a particular threshold, as compared to the expected. This may indicate poor
# genotyping quality and/or genetic stratification. We can test the GW marker 
# characteristics in controls by

descriptives.marker(ge03d2ex, ids=(dm2==0))

# Apparently, HWE distribution holds better in controls than in the total sample.
# Let us check whether there are indications that deviation from HWE is due
# to cases. At this stage we are only interested in the HWE distribution table,
# and therefore will ask to report the distrbution for cases (dm2==1) and report
# only table two:

descriptives.marker(ge03d2ex, ids=(dm2==1))[2]

# and for the controls

descriptives.marker(ge03d2ex, ids=(dm2==0))[2]

# It seems that indeed excessive number of markers are out of HWE in cases. If no
# laboratory procedure (e.g. DNA extraction, genotyping, calling) were done for
# cases and controls separately, this may indicate possible genetic heterogeneity
# specific for cases.
# In essence, the 'descriptives.marker' function uses the 'summary' function
# to generate the HW P-values distribution. It may be interesting to generate
# this distribution using the 'summary' function You do not need to do so, but this
# example shows how you can generate summaries from underlying SNP-tables.
# First, we need to compute summary SNP statistics by

s <- summary( gtdata( ge03d2ex[(dm2==1), ] ) )

# Note the you have produced the summary for the gtdata slot of ge03d2ex;
# this is the slot which actually contain all genetic data in special compressed
# format. You can see the first 5 rows of this very long summary table by

s[1:5, ]

# Note that the column 'Pexact' provides exact HWE test P-values we need. We
# can extract these to a separate vector by

pexcas <- s[, "Pexact"]

# and do characterization of the cummulative distribution by

catable(pexcas, c(0.001,0.01,0.05,0.1,0.5), cumulative=TRUE)

# You can generate the distribution for controls in similar manner.
# Let us first try do a GWA scan using the raw (before quality control)
# data. We will use the score test, as implemented in the qtscore()1
# function of GenABEL-package for testing:

an0 <- qtscore(dm2, ge03d2ex, trait="binomial")
  
# The first argument used describes the model; here it is rather simple - the
# affection status, dm2, is supposed to depend on SNP genotype only.
# You can see what information is computed by this function by using

an0

# Here, let us look at the 'Results table'. P1df, P2df and Pc1df are most interesting;
# the first two are vectors of 1 and 2 d.f. P-values obtained in the GWA
# analysis, the last one is 1 d.f. P-value corrected for inflation factor ?? (which
# is in the lambda object). effB corresponds to the (approximate) Odds Ratio
# estimate for the SNP. Let us see if there is evidence for the inflation of the 
# test statistics; for that let us obtain ?? with

lambda(an0)

# The estimate of ?? is 1.03, suggesting inflation of the test and some degree of
# stratification. Though the value obtained seems to be small, it should be noted
# that ?? grows linearly with sample size, so for this small number of cases and
# controls the value is worrisome.
# The ?? is computed by regression in a Q-Q plot. Both estimation of ?? and
# production of the ??2 ??? ??2 plot can be done using the estlambda function; this
# was already done automatically when running qtscore function, but let us
# repeat this manually:

estlambda(an0[, "P1df"], plot=TRUE)

# We can also present the obtained results using the "Manhatten plot", where
# the SNP genomic position is on the horizontal axis and ??? log10 of the P-value
# is shown on the vertical axis:

plot(an0)

# The resulting plot is show in Figure 5.2. By default, ??? log10(P-value) of the
# uncorrected 1 d.f. test are shown; see thehelp to figure out how this behaviour
# can be changed. We can also add the corrected P-values to the plot with

add.plot(an0, df="Pc1df", col=c("lightblue", "lightgreen"))

# You can see that the P-values corrected by genomic control are uniformly lower
# than the P-values from 'raw' analysis. This is to be expected as genomic control
# simply divides the 'raw' ??2 statistics by a constant ?? for all SNPs.
# You can also generate a descriptive table for the "top" (as ranked by P-value)
# results by

descriptives.scan(an0)
summary(an0)

# Here you see top 10 results, sorted by P-value with 1 d.f. If you want to sort
# by the corrected P-value, you can use descriptives.scan(an0, sort="Pc1df");
# to see more than 10 (e.g. 25) top results, use descriptives.scan(an0, top=25).
# You can combine all these options. Large part of results reports NA as effect
# estimates and 9.99 as P-value for 2 d.f. test - for these markers only two out
# of the three possible genotypes were observed, and consequently the 2 d.f. test
# could not be performed. Now let us apply the qtscore() function with times argument, 
# which tells it to compute empirical GW (or experiment-wise) significance

an0.e <- qtscore(dm2, ge03d2ex, times=200, quiet=TRUE)
descriptives.scan(an0.e, sort="Pc1df")

# Experimental-wise significance is computed by an empirical procedure, thus
# we consider P-values ??? 0.05 to be GW-significant. However, none of the SNPs
# hits GW significance. If, actually, any did pass the threshold, we could not
# trust the results, because the distribution of the HWE test and presence of
# inflation factor for the association test statistics suggest that the data may
# contain multiple errors (indeed they do). Therefore before association analysis
# we need to do rigorous Quality Control (QC). Note that at a certain SNP, 
# the corrected P-values become equal to 1 - at this point the order in the 
# list is arbitrary because sorting could not be done.



