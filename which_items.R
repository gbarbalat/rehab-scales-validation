all_scales <- c("MARS", "WEMWBS", "STORI", "EAS", "BIS","SERS", "ISMI", "SQoL")


#WEMWBS ----
myitems_WEMWBS <-  c("WEMWBS_Q1", "WEMWBS_Q2", "WEMWBS_Q3", "WEMWBS_Q4", "WEMWBS_Q5", "WEMWBS_Q6", "WEMWBS_Q7",
              "WEMWBS_Q8", "WEMWBS_Q9", "WEMWBS_Q10", "WEMWBS_Q11", "WEMWBS_Q12", "WEMWBS_Q13", "WEMWBS_Q14")
dimensions_WEMWBS <- list(1:14)
# Create the CFA model string dynamically
CFA.mydata_WEMWBS <- paste0(
  "all =~ ", 
  paste(myitems_WEMWBS, collapse = " + ")
)
binary_WEMWBS <- FALSE
nfactors_WEMWBS <- 1

#MARS ----
myitems_MARS <-  c("MARS_Q1", "MARS_Q2", "MARS_Q3", "MARS_Q4", "MARS_Q5", "MARS_Q6", "MARS_Q7",
                     "MARS_Q8", "MARS_Q9", "MARS_Q10" )
dimensions_MARS <- list(1:4, 5:8, 9:10)
CFA.mydata_MARS <- paste0(
  "factor1 =~ ", paste(myitems_MARS[1:4], collapse = " + "), "\n",
  "factor2 =~ ", paste(myitems_MARS[5:8], collapse = " + "), "\n",
  "factor3 =~ ", paste(myitems_MARS[9:10], collapse = " + ")
)
binary_MARS <- TRUE
nfactors_MARS <- 3


#IS_BIRCHWOOD ----
myitems_IS <-  c("IS_Q1", "IS_Q2", "IS_Q3", "IS_Q4", "IS_Q5", "IS_Q6", "IS_Q7",
                   "IS_Q8" )
dimensions_IS <- list(1:2, 3:4, 5:8)
CFA.mydata_IS <- paste0(
  "factor1 =~ ", paste(myitems_IS[1:2], collapse = " + "), "\n",
  "factor2 =~ ", paste(myitems_IS[3:4], collapse = " + "), "\n",
  "factor3 =~ ", paste(myitems_IS[5:8], collapse = " + ")
)
binary_IS <- FALSE
nfactors_IS <- 3


#SQOL18 ----
myitems_SQOL18 <- c("SQOL18_Q1", "SQOL18_Q2", "SQOL18_Q3", "SQOL18_Q4", "SQOL18_Q5", "SQOL18_Q6", "SQOL18_Q7","SQOL18_Q8","SQOL18_Q9","SQOL18_Q10",
                    "SQOL18_Q11", "SQOL18_Q12", "SQOL18_Q13", "SQOL18_Q14", "SQOL18_Q15", "SQOL18_Q16", "SQOL18_Q17","SQOL18_Q18"
)
SQOL18_SEL <- c(1,4)
SQOL18_RES <- c(2,3,7)
SQOL18_AUT <- c(5,6)
SQOL18_PHY <- c(8,9)
SQOL18_FAM <- c(10,11)
SQOL18_FRI <- c(12,13)
SQOL18_ROM <- c(14,15)
SQOL18_PSY <- c(16,17,18)
dimensions_SQOL18 <- list(SQOL18_SEL,SQOL18_RES,SQOL18_AUT,SQOL18_PHY,SQOL18_FAM,SQOL18_FRI,SQOL18_ROM,SQOL18_PSY)
CFA.mydata_SQOL18 <- paste0(
  "factor1 =~ ", paste(SQOL18_SEL, collapse = " + "), "\n",
  "factor2 =~ ", paste(SQOL18_RES, collapse = " + "), "\n",
  "factor3 =~ ", paste(SQOL18_AUT, collapse = " + "), "\n",
  "factor4 =~ ", paste(SQOL18_PHY, collapse = " + "), "\n",
  "factor5 =~ ", paste(SQOL18_FAM, collapse = " + "), "\n",
  "factor6 =~ ", paste(SQOL18_FRI, collapse = " + "), "\n",
  "factor7 =~ ", paste(SQOL18_ROM, collapse = " + "), "\n",
  "factor8 =~ ", paste(SQOL18_PSY, collapse = " + ")
)
binary_SQOL18 <- FALSE
nfactors_SQOL18 <- 8


#STORI ----
# Generate numbers from 1 to 50
numbers <- 1:50

# Create the STORI_Q vector with desired format
myitems_STORI <- c(paste("STORI_Q", numbers, sep=""))

STORI_MORAT <- seq(1, 50,5)
STORI_CONSC <- seq(2, 50,5)
STORI_PREPAR <- seq(3, 50,5)
STORI_RECONST <- seq(4, 50,5)
STORI_CROISS <- seq(5, 50,5)

dimensions_STORI <- list(STORI_MORAT, STORI_CONSC, STORI_PREPAR, STORI_RECONST, STORI_CROISS)
CFA.mydata_STORI <- paste0(
  "factor1 =~ ", paste(STORI_MORAT, collapse = " + "), "\n",
  "factor2 =~ ", paste(STORI_CONSC, collapse = " + "), "\n",
  "factor3 =~ ", paste(STORI_PREPAR, collapse = " + "), "\n",
  "factor4 =~ ", paste(STORI_RECONST, collapse = " + "), "\n",
  "factor5 =~ ", paste(STORI_CROISS, collapse = " + ")
)
binary_STORI <- FALSE
nfactors_STORI <- 5

#ISMI ----
# Generate numbers from 1 to 29
numbers <- seq(1, 29)

# Create the STORI_Q vector with desired format
myitems_ISMI <- c(paste("ISMI_Q", numbers, sep=""))

ISMI_ALIEN <- c(1,5,8, 16,17,21)
ISMI_APPRO <- c(2,6,10,18,19,23,29)
ISMI_DISCRIM <- c(3,15,22,25,28)
ISMI_RETRAIT <- c(4,9,11,12,13,20)
ISMI_RESIST <- c(7,14,24,26,27)

dimensions_ISMI <- list(ISMI_ALIEN, ISMI_APPRO, ISMI_DISCRIM, ISMI_RETRAIT, ISMI_RESIST)
CFA.mydata_ISMI <- paste0(
  "factor1 =~ ", paste(ISMI_ALIEN, collapse = " + "), "\n",
  "factor2 =~ ", paste(ISMI_APPRO, collapse = " + "), "\n",
  "factor3 =~ ", paste(ISMI_DISCRIM, collapse = " + "), "\n",
  "factor4 =~ ", paste(ISMI_RETRAIT, collapse = " + "), "\n",
  "factor5 =~ ", paste(ISMI_RESIST, collapse = " + ")
)
binary_ISMI <- FALSE
nfactors_ISMI <- 5

#EAS ----
# Generate numbers from 1 to 17
numbers <- seq(1, 17)

# Create the STORI_Q vector with desired format
myitems_EAS <- c(paste("EAS_Q", numbers, sep=""))
EAS_SOINS <- 1:3
EAS_VIEQUOT <- 4:7
EAS_RES <- 8:10
EAS_RELEXT <- 11:14
EAS_RELSOC <- 15:17


dimensions_EAS <- list(EAS_SOINS,EAS_VIEQUOT, EAS_RES, EAS_RELEXT, EAS_RELSOC)
CFA.mydata_EAS <- paste0(
  "factor1 =~ ", paste(EAS_SOINS, collapse = " + "), "\n",
  "factor2 =~ ", paste(EAS_VIEQUOT, collapse = " + "), "\n",
  "factor3 =~ ", paste(EAS_RES, collapse = " + "), "\n",
  "factor4 =~ ", paste(EAS_RELEXT, collapse = " + "), "\n",
  "factor5 =~ ", paste(EAS_RELSOC, collapse = " + ")
)
binary_EAS <- FALSE
nfactors_EAS <- 5

#SERS ----
# Generate numbers from 1 to 20
numbers <- seq(1, 20)

# Create the STORI_Q vector with desired format
myitems_SERS <- c(paste("SERS_Q", numbers, sep=""))
SERS_pos <- c(2,4,5,6,7,8,11,12,14,19)
SERS_neg <- c(1,3,9,10,13,15,16,17,18,20)

dimensions_SERS <- list(SERS_pos, SERS_neg)
CFA.mydata_SERS <- paste0(
  "factor1 =~ ", paste(SERS_pos, collapse = " + "), "\n",
  "factor2 =~ ", paste(SERS_neg, collapse = " + ")
)
binary_SERS <- FALSE
nfactors_SERS <- 2


#all of my items ----
all_of_myitems <- c(myitems_IS, myitems_MARS, myitems_SQOL18, myitems_WEMWBS,
                    myitems_STORI, myitems_ISMI, myitems_EAS, myitems_SERS)

