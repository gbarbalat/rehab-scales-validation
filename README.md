# rehab-scales-validation

Our network of rehabilitation centers across France uses 8 main questionnaires/scales: the BIS (insight), the WEMWBS (well-being), the ISMI (self-stigma), the STORI (recovery), the SQoL (quality of life), the SERS (self-esteem), the MARS (medication adherence), and the EAS (social autonomy). These scales are all self-questionaires except for the EAS which is a hetero-evaluation of a patient's autonomy.  
To the best of our knowledge, these scales have mostly been validated in healthy controls and in patients with schizophrenia. Only the SQoL has been validated in patients with bipolar disorders. In addition, these scales have not been validated in rehabilitation settings.  

The goal of this study is to confirm that these scales are appropriate for rehabilitation settings. We will assess their psychometric properties using **Mokken Scale Analysis (MSA)**, **Item Response Theory (IRT)**, **Factor Analysis**, and **Classical Test Theory (CTT)**.

### **1. Check data**
in particular: frequencies, bivariate correlations, outliers, and whether parametric assumptions hold

### **2. Mokken Scale Analysis (MSA)**
MSA helps evaluate whether the items form a unidimensional scale and meet assumptions like monotonicity and invariant item ordering (IIO).  
- identify idiosyncratic response patterns as per Guttman errors
- Loevinger’s $H$: $H > 0.3$ indicates weak scalability; $H > 0.4$ suggests medium scalability; $H > 0.5$ suggests good scalability.
- automatic item selection algorithm: uni- or multi-dimensional scale.
- Monotonicity and IIO should show no significant violations.

### **2. Item Response Theory (IRT)**
IRT allows to evaluate item discrimination, difficulty, loadings, and reliability.
- Model fit as per RMSEA, SRMSR, TLI, CFI. RMSEA ($< 0.05$), CFI ($> 0.95$), and TLI ($> 0.95$) indicate excellent model fit. RMSEA ($< 0.08$), CFI ($> 0.90$), and TLI ($> 0.90$) are acceptable.
- Item fit, pval should be >0.05
- Items with moderate/good discrimination ($a > 0.7$) are informative.
- Threshold ($d$) indicates item difficulty. Should go higher from one threshold to the next.
- Loadings ($F$) and communality ($h$) for each factor. $>0.4$ acceptable; $>0.6$ good; average $>0.7$ ideal.
- Marginal ($>0.7$) and empirical ($>0.8$) reliability.
  
### **3. Factor Analysis**
Factor analysis helps confirm dimensionality or identify latent dimensions in the data.
- For EFA: Factor loadings Poor: $<0.32$ ; Fair: $>0.45$ ; Good: $>0.55$ ; Very Good: $>0.63$ ; Excellent: $>0.71$ - communality acceptable $> 0.4$ - high $> 0.7$.
- For CFA: Fit indices. Also look at loadings (estimate and pval: acceptable $>0.4$; strong $>0.6$; very strong $>0.7$), thresholds (going from one to the next), and variances.

### **4. Classical Test Theory (CTT)**
CTT evaluates reliability and total score validity.
- Cronbach’s alpha $> 0.7$ indicates acceptable reliability; good $>0.8$; excellent $>0.9$.
- McDonald's omega.
- High item-total correlations ($> 0.3$) suggest items contribute meaningfully to the total score.
