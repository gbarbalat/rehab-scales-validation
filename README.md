# rehab-scales-validation

Our network of rehabilitation centers across France uses 8 main questionnaires/scales: the BIS (insight), the WEMWBS (well-being), the ISMI (self-stigma), the STORI (recovery), the SQoL (quality of life), the SERS (self-esteem), the MARS (medication adherence), and the EAS (social autonomy). These scales are all self-questionaires except for the EAS which is a hetero-evaluation of a patient's autonomy.  
To the best of our knowledge, these scales have mostly been validated in healthy controls and in patients with schizophrenia. Only the SQoL has been validated in patients with bipolar disorders. In addition, these scales have not been validated in rehabilitation settings.  

The goal of this study is to confirm that these scales are appropriate for rehabilitation settings. We will assess their psychometric properties using **Mokken Scale Analysis (MSA)**, **Item Response Theory (IRT)**, **Factor Analysis**, and **Classical Test Theory (CTT)**.

### **1. Check data**
in particular: frequencies, bivariate correlations, outliers, and whether parametric assumptions hold

### **2. Mokken Scale Analysis (MSA)**
MSA helps evaluate whether the items form a unidimensional scale and meet assumptions like monotonicity and invariant item ordering (IIO).  
- identify idiosyncratic response patterns as per Guttman errors
- Loevinger’s $H$: $H > 0.3$ indicates scalability; $H > 0.5$ suggests a strong scale.
- automatic item selection algorithm: uni- or multi-dimensional scale.
- Monotonicity and IIO should show no significant violations.

### **2. Item Response Theory (IRT)**
IRT allows to evaluate item discrimination, difficulty, and information. For Likert-scale items, the graded response model (GRM) is appropriate.
- Items with moderate/good discrimination ($a > 0.7$) are informative.
- Threshold ($d$) indicates item difficulty
- Loadings and communality ($F$) for each factor 
- The test information curve shows where the scale is most precise.
  
### **3. Factor Analysis**
Factor analysis helps confirm unidimensionality or identify latent dimensions in your data.
- For EFA: Factor loadings $> 0.4$ suggest items load well on the latent factor.
- For CFA: Fit indices like RMSEA ($< 0.06$), CFI ($> 0.95$), and TLI ($> 0.95$) indicate good model fit.

### **4. Classical Test Theory (CTT)**
CTT evaluates reliability and total score validity.

- Cronbach’s alpha $> 0.7$ indicates acceptable reliability.
- High item-total correlations ($> 0.3$) suggest items contribute meaningfully to the total score.
