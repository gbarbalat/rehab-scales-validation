#hdr ----
# script adapted from https://github.com/alexadima/6-steps-protocol/blob/master/Scale_validation_-_RM-SIP_analysis_-_SM2.Rmd

rm(list=ls())

for (n in c('dplyr','tidyr','tidyverse','psych', 'memisc', 'Hmisc', 'ltm', 'MASS',
'lavaan','semTools','semPlot', 'qgraph','sem',
'mirt', 'eRm', 'mokken', 'rgl','scales',
'CTT','MBESS')) {
  
  library(n,character.only=TRUE)
  
}

today <- format(Sys.Date(), "%Y-%m-%d")

# Define variables ----

# which dx
all_dx <-"" #"" if want to run the analysis on the whole dataset
all_6dx <- c("2-Spectre De La Schizophrenie", "1-Troubles Neurodeveloppementaux",
"3-Troubles Bipolaires",  "18-Troubles De La Personnalite","4-Troubles Depressifs","anxiety disorders")
dx_to_keep <-all_6dx

# which scale
all_scales <- c("MARS", "WEMWBS", "STORI", "EAS", "IS","SERS", "ISMI", "SQOL18")
scale_to_keep <- all_scales[1]#run this analysis for this scale - for parallelization
all_suffix_tot <- c("MARS_TOT", "WEMWBS_TOT_NB", "STORI_ST_RETABLISSEMENT", "EAS_TOTAL", "IS_BIRCHWOOD_SC_TOT",
                    "SERS_SC_TOT", "ISMI_SC_TOT", "SQOL18_TOT_SATISF")
varOI <- all_suffix_tot[1]#this is the total score for the scale we're analysing - for parallelization

# which items; CFA model, binary responses or not, Nfactors and structure
source("./code/which_items.R")
myitems <- get(paste0("myitems_", scale_to_keep))
CFA.mydata <- get(paste0("CFA.mydata_", scale_to_keep))
binary <- get(paste0("binary_", scale_to_keep))
nfactors <- get(paste0("nfactors_", scale_to_keep))
dimensions <- get(paste0("dimensions_", scale_to_keep))

# NOT FOR USE
# fn to partition an item set into mokken scales - lowerbound from .05 to .80 
moscales.for.lowerbounds <- function( x, lowerbounds=seq(from=0.05,to=0.60,by=0.05) )
{
  ret.value <- NULL;
  for( lowerbound in lowerbounds )
  { print(lowerbound)
    tmp <- aisp( x,  lowerbound=lowerbound );
    if( is.null(ret.value) )
    {
      ret.value <- data.frame( "Item"=rownames(tmp), "Scales."=tmp[,1] );
    }
    else
    {
      ret.value <- cbind( ret.value, "Scales."=tmp[,1] );
    }
    names(ret.value)[ncol(ret.value)] <- sprintf("%.2f",lowerbound);
  }
  rownames(ret.value) <- NULL;
  ret.value;
}


#Step 0 Data cleaning ----
# load data
load(file="merged_gp.RData")

#select items on which you want to run the analysis and rm NA
initialdata <- merged_gp %>%
  dplyr::select(all_of(myitems)) %>%
  filter(if_all(contains("_Q"), ~!is.na(.)))
#if you want to filter by dx
initialdata_gp <- merged_gp %>%
  dplyr::select(all_of(myitems), LISTE_CLASSE_DIAG1R) %>%
  filter(if_all(contains("_Q"), ~!is.na(.))) %>%
  filter(LISTE_CLASSE_DIAG1R=="2-Spectre De La Schizophrenie")

# check data structure
str(initialdata)

# main function (runs dima's 6 steps)
SixStepsValid <- function(mydata, binary, nfactors, CFA.mydata, dimensions){
  
#Step 1 Descriptive ----

##Item frequencies ----
# describe treats all variables as numeric, so use it only for ordinal to ratio when properly coded
descrmyitems <- as.data.frame( round( psych::describe( mydata ), 2 ))
cat("item description\n"); print(descrmyitems)
# if required, exclude from next analyses items that have no/little variance 

##Correlations between items ----
#ordinal: Spearman
#binary: tetrachoric
if (binary) {
bluesqs <- psych::tetrachoric(mydata)$rho
} else {
bluesqs <- cor(mydata, method = "spearman");
}
cor.plot(bluesqs, numbers=TRUE, main="correlations between items", 
         cex=0.5, cex.axis=0.7)

## total score distrib ----
hist(merged_gp %>% pull(!!sym(varOI)))
car::qqPlot(merged_gp %>% pull(!!sym(varOI)))

## Multivariate outliers ----
# based on Mahalanobis squared distances 
d2mydata <- outlier(mydata, cex=.6, bad=3, ylim=c(0,130)); hist(d2mydata)
round(max(d2mydata), 2)

# outliers are <.001 according to Tabachnick, B.G., & Fidell, L.S. (2007). Using Multivariate Statistics (5th Ed.). Boston: Pearson. (p. 74) 
sum((1-pchisq(d2mydata, ncol(mydata)))<.001)
who_outliers_D2 <- (1-pchisq(d2mydata, ncol(mydata)))<.001
print(paste0("nOutliers as per D2:",sum((1-pchisq(d2mydata, ncol(mydata)))<.001)))

# Step 2: Item properties - Mokken Scaling Analysis (MSA) ----

## outliers - Guttman ----
gPlus   <- check.errors(mydata)$Gplus;hist(gPlus)
Q3 <- summary(gPlus)[[5]]
IQR <- Q3 - summary(gPlus)[[2]]
who_outliers_Gutt <- gPlus > Q3 + 1.5 * IQR
print(paste0("nOutliers as per Guttman:",nrow(mydata[who_outliers_Gutt,])))

## scalability ----
print("Scalability:")
Hvalues <- coefH(mydata)

## aisp ----
# to which scale an item belongs
#motable.mydata <- moscales.for.lowerbounds( mydata )
# change lowerbound if needed
myselection <- aisp(mydata,  lowerbound=.3)
# check which items are in which subscales
cat("aisp\n");print(myselection)

## check conditional association (local dependence) ----
CA.def.mysubscale1 <- check.ca(mydata, TRUE)#mysubscale1
# CA.def.mysubscale1$InScale
# CA.def.mysubscale1$Index
# CA.def.mysubscale1$Flagged

## check monotonicity ----
# with default minsize (may want to try 60 to 10)
monotonicity.def.mysubscale1 <- check.monotonicity(mydata)
cat("monotonicity\n");print(summary(monotonicity.def.mysubscale1))

## check of invariant item ordering ----
miio.mysubscale1 <- check.iio(mydata)
cat("iio\n");print(miio.mysubscale1$violations)

# Step 3:Parametric IRT ----
itemtype <- ifelse(binary, "2PL", "graded")
grm_model <- mirt(mydata, model = nfactors, itemtype = itemtype)

## Calculate M2 fit statistic ----
modeltype <- ifelse(binary,"C2","M2")
fit_model <- M2(grm_model, type=modeltype)#M2, M2*, C2
cat("modelfit\n");print(fit_model)

## Perform item-fit analysis ----
item_fit <- mirt::itemfit(grm_model)
cat("itemfit\n");print(item_fit)

## Posterior Predictive Model Checking (PPMC) ----
ppmc_results <- residuals(grm_model, type = "LDG2")
cat("PPMC\n");print(ppmc_results)

## G² statistic ----
g_squared <- anova(grm_model)
print(g_squared)

## information based fit ----
plot(grm_model, type = "info")

## Discrimination, Difficulty  and loadings ----
cat("discrim a & diffic d\n");print(coef(grm_model, simplify = TRUE))
cat("loadings & communal\n");print(summary(grm_model))#none promax

##  reliability ----
if (nfactors==1) {
marginal_reliability <- marginal_rxx(grm_model)
cat("marginal reliab\n");print(marginal_reliability)
# Calculate IRT-based scores
irt_scores <- fscores(grm_model, full.scores = TRUE,  full.scores.SE=TRUE)
#calculate empirical reliability
empirical_reliability <- empirical_rxx(irt_scores)
cat("empirical_reliability\n");print(empirical_reliability)
} else {
  for (i in 1:nfactors) {
    print(i)
      # Fit the IRT model for the current dimension
      itemtype <- ifelse(length(dimensions[[i]])==2,"1PL",itemtype)
      grm_model_x <- mirt(mydata[, myitems[dimensions[[i]]]], model = 1, itemtype = itemtype)
      
      # marginal reliability
      dim_reliability <- marginal_rxx(grm_model_x)
      cat("Marginal Reliability:\n"); print(dim_reliability)
     
      # empirical reliability
      fs <- fscores(grm_model_x, full.scores.SE = TRUE)
      empirical_reliability <- empirical_rxx(fs)
      cat("Empirical Reliability:\n", empirical_reliability)
  }
}


# Step 4: Factor analysis ----

## EFA ----
which_cor <- ifelse(binary,"tetrachoric","cor")
efa_result <- psych::fa(mydata, nfactors = nfactors, rotate = "promax", cor=which_cor)#none promax
cat("efa\n");print(efa_result) 

## CFA ----

# fit the model
if (binary) {
  ordered <- TRUE
} else (ordered <- names(mydata) )
fitCFA.mydata <- lavaan::cfa(CFA.mydata, 
                             data=mydata,
                             ordered = ordered )
# model summary
summary(fitCFA.mydata) -> fitCFA.mydata_sum
cat("cfa\n");print(fitCFA.mydata_sum)
cat("fit cfa\n");print(fitMeasures(fitCFA.mydata,c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr")))

# Step 5: CTT ----
Calphamysubscale1 <- psych::alpha(mydata) 
cat("alpha cron\n");print(Calphamysubscale1$total)

Comegamysubscale1 <- psych::omega(mydata,nfactors = nfactors) 
cat("omega tot\n");print(Comegamysubscale1$omega.tot)
cat("omega hierarchical\n"); print(Comegamysubscale1$omega_h)
if( nfactors > 1) {
  for (i in 1:nfactors) {
    print(i)
    Calphamysubscale1 <- psych::alpha(mydata[, myitems[dimensions[[i]]]]) 
    cat("alpha cron\n");print(Calphamysubscale1$total)
   
    Comegamysubscale1 <- psych::omega(mydata[, myitems[dimensions[[i]]]],nfactors = 1) 
    cat("omega tot\n");print(Comegamysubscale1$omega.tot)
    cat("omega hierarchical\n"); print(Comegamysubscale1$omega_h)  
    }
}


return(who_outliers_Gutt)
}

# Run function
who_outliers <- SixStepsValid(mydata=initialdata, binary = binary, nfactors=nfactors, CFA.mydata=CFA.mydata, dimensions=dimensions); 
sum(who_outliers)


#re-run w/o outlier observations
data2 <- initialdata[!who_outliers,]; who_outliers2 <- SixStepsValid(mydata=data2)
#re-run w/o certain items
data2 <- initialdata[!who_outliers,] %>% dplyr::select(-WEMWBS_Q11); who_outliers2 <- SixStepsValid(mydata=data2)



# Step 6: Total scores and factor scores ---- 
# this is simply copy-pasted from Dima et al.
# where she compared SIP24 (full scale) to SIP15 (reduced)

# specify which items belong to which scales
myKeys <- make.keys(nvar=24,list(SIP24 = c(1:24),
                                 SIP15 = names(mysubscale2)),
                    item.labels = colnames(mydata[,1:24]))
# form several scales, default is average score (totals=FALSE)
# (***** if you want sum scores, for example for binary items, add totals=TRUE)
mydata.scores <- scoreItems(myKeys, mydata[,1:24], totals=TRUE)
# check the highlights of the results
mydata.scores
# check everything about your scores
print(mydata.scores, short=FALSE)
# add them to your itemset
mydata <- cbind(mydata, mydata.scores$scores)

# examine frequencies
table(mydata$SIP24, exclude=NULL)
table(mydata$SIP15, exclude=NULL)

# ceiling and floor effects
sum(mydata$SIP24==0)*100/nrow(mydata)
sum(mydata$SIP24==24)*100/nrow(mydata)
sum(mydata$SIP15==0)*100/nrow(mydata)
sum(mydata$SIP15==15)*100/nrow(mydata)

# check descriptives
# for multiple scales (with psych::describe)
descrScales <- as.data.frame( round( psych::describe( mydata[,c("SIP24", "SIP15")] ), 2 ))
#hist and cor

#bivariate and multivariate anal (if necessary)
