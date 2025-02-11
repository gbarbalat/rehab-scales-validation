# rehab-scales-validation

Our network of rehabilitation centers across France uses 8 main questionnaires/scales: the BIS (insight), the WEMWBS (well-being), the ISMI (self-stigma), the STORI (recovery), the SQoL (quality of life), the SERS (self-esteem), the MARS (medication adherence), and the EAS (social autonomy). These scales are all self-questionaires except for the EAS which is a hetero-evaluation of a patient's autonomy.  
To the best of our knowledge, these scales have mostly been validated in healthy controls and in patients with schizophrenia. Only the SQoL has been validated in patients with bipolar disorders. In addition, these scales have not been validated in rehabilitation settings.  

The goal of this study is to confirm that these scales are appropriate for rehabilitation settings. We will assess their psychometric properties using **Mokken Scale Analysis (MSA)**, **Item Response Theory (IRT)**, **Factor Analysis**, and **Classical Test Theory (CTT)**.

---

### **1. Mokken Scale Analysis (MSA)**
MSA helps evaluate whether the items form a unidimensional scale and meet assumptions like monotonicity and invariant item ordering (IIO).  
- Loevinger’s $H$: $H > 0.3$ indicates scalability; $H > 0.5$ suggests a strong scale.
- Monotonicity and IIO should show no significant violations.

---

### **2. Item Response Theory (IRT)**
IRT allows you to evaluate item discrimination, difficulty, and information. For Likert-scale items, the graded response model (GRM) is appropriate.

#### R Code:
```r
# Install and load the mirt package
install.packages("mirt")
library(mirt)

# Fit a graded response model
mod <- mirt(mydata, model = 1, itemtype = "graded")

# View item parameters
coef(mod)

# Plot item characteristic curves (ICCs)
plot(mod, type = "trace")

# Plot test information curve
plot(mod, type = "info")

# Calculate IRT-based scores
irt_scores <- fscores(mod, method = "EAP")
head(irt_scores)
```

#### Interpretation:
- Items with good discrimination ($$ a > 0.7 $$) are informative.
- The test information curve shows where the scale is most precise.

---

### **3. Factor Analysis**
Factor analysis helps confirm unidimensionality or identify latent dimensions in your data.

#### R Code:
```r
# Install and load psych package
install.packages("psych")
library(psych)

# Perform exploratory factor analysis (EFA) with 1 factor
efa_result <- fa(mydata, nfactors = 1, rotate = "none")
print(efa_result)

# Perform confirmatory factor analysis (CFA) using lavaan
install.packages("lavaan")
library(lavaan)

# Define CFA model with one factor
cfa_model <- 'Factor =~ V1 + V2 + V3 + ... + V14' # Replace with your item names

cfa_result <- cfa(cfa_model, data = mydata)
summary(cfa_result, fit.measures = TRUE)
```

#### Interpretation:
- For EFA: Factor loadings $$ > 0.4 $$ suggest items load well on the latent factor.
- For CFA: Fit indices like RMSEA ($$< 0.06$$), CFI ($$> 0.95$$), and TLI ($$> 0.95$$) indicate good model fit.

---

### **4. Classical Test Theory (CTT)**
CTT evaluates reliability and total score validity.

#### R Code:
```r
# Install and load psych package
library(psych)

# Calculate Cronbach's alpha for reliability
alpha_result <- alpha(mydata)
print(alpha_result)

# Calculate item-total correlations
item_total_corr <- item.total(mydata)
print(item_total_corr)

# Descriptive statistics for total scores
total_scores <- rowSums(mydata)
summary(total_scores)
```

#### Interpretation:
- Cronbach’s alpha $$ > 0.7 $$ indicates acceptable reliability.
- High item-total correlations ($$ > 0.3 $$) suggest items contribute meaningfully to the total score.

---

### **5. Steps to Confirm Use in Rehabilitation Settings**
To validate the scales for rehabilitation settings:
1. **Compare psychometric properties**: Ensure reliability ($$ \alpha > 0.7 $$), unidimensionality (via MSA or factor analysis), and good IRT parameters.
2. **Test for invariance**: Use multi-group CFA or Differential Item Functioning (DIF) analysis to check if items function similarly across groups (e.g., general psychiatry vs rehabilitation).
3. **Evaluate content validity**: Confirm that items are relevant to rehabilitation settings through expert review or patient feedback.

---

### Example Workflow Summary

```r
# Load necessary packages
library(mokken)
library(mirt)
library(psych)
library(lavaan)

# Step 1: Mokken Scale Analysis
H <- coefH(mydata)
monotonicity <- check.monotonicity(mydata)
iio <- check.iio(mydata)

# Step 2: IRT Analysis
mod <- mirt(mydata, model = 1, itemtype = "graded")
plot(mod, type = "trace")
irt_scores <- fscores(mod)

# Step 3: Factor Analysis
efa_result <- fa(mydata, nfactors = 1)
cfa_model <- 'Factor =~ V1 + V2 + ... + V14'
cfa_result <- cfa(cfa_model, data = mydata)

# Step 4: Classical Test Theory
alpha_result <- alpha(mydata)
item_total_corr <- item.total(mydata)
```
