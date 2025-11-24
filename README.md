# Clinical Features of Alzheimer's Dementia 

## Table of Contents

- [Project Background](#project-background) <br>
- [Executive Summary](#executive-summary) <br>
- [Insights](#insights) <br>
- [Recommendations](#recommendations) <br>
- [Assumptions and Caveats](#assumptions-and-caveats) <br>
- [Data Query and Visualization](#data-query-and-visualization)

## Project Background

Alzheimer's dementia (AD) is the sixth leading cause of death in the U.S., the most common culprit of dementia, and incurable [(Skaria, 2022)](https://www.ajmc.com/view/the-economic-and-societal-burden-of-alzheimer-disease-managed-care-considerations). It is characterized by cognitive decline, significantly impeding quality of life. Half of patients with AD are diagnosed. This may be due to AD's silent and gradual onset. On average, patients are asymptomatic for 3-11 years before noticeable changes [(Mayo Clinic)](https://www.mayoclinic.org/diseases-conditions/alzheimers-disease/in-depth/alzheimers-stages/art-20048448). Further, tests confirming AD are either invasive, time consuming, or inaccessible [(Skaria, 2022)](https://www.ajmc.com/view/the-economic-and-societal-burden-of-alzheimer-disease-managed-care-considerations). AD often reveals itself after significant disease progression. Early AD diagnoses reduce future costs from otherwise worsened AD. This provides patients and families time to start treatment, address risk factors, enroll in clinical trials, and to plan for long-term care. During this time, cognition can be improved by targeting intellectual engagement, exercise, tobacco smoking, eating habits, diabetes, hypertension, and body mass index. Early AD diagnosis is cost-effective for patients, families, and Medicare/Medicaid, as demonstrated by several studies. Early AD diagnosis was found to reduce annual patient cost by 9-14%, or $4,300 per patient per year. By 2060, AD in Americans is projected to double, tripling health care costs to greater than $1 trillion. Therefore, cost reduction, that could be achieved by early diagnosis, is significant in alleviating economic burden. By exploring Open Access Series of Imaging Studies (OASIS) data, [OASIS-1](https://sites.wustl.edu/oasisbrains/home/oasis-1/) and [OASIS-2](https://sites.wustl.edu/oasisbrains/home/oasis-2/), I explore the various stages of AD in order to find signs that may predict its silent early stage.

## Executive Summary 



## Insights

### Demographic and clinical trends  

*	AD presence is strongly associated with age, MMSE performance, and brain volume.
*	However, AD severity is best conveyed by MMSE and brain volume.
*	Clinicians can utilize MMSE changes and brain volume as early warning signs of AD.
  
### MMSE in predicting dementia 

* Worsening performance on MMSE by 1.5-7 points correlate with dementia. 
*	Poor MMSE performance has the strongest correlation with dementia presence and degree.
* Although normal MMSE score is considered to be 25 or greater, the average MMSE of patients with mild dementia was found to be greater than 25. Therefore, AD can be better predicted by examining MMSE score change rather than a certain numerical threshold. 
* Amongst newly diagnosed patients, MMSE score decreased about -1.4 points. 
* Decrease of 1.4-3 points could point towards future dementia onset, especially in asymptomatic patients who likely score above 25 on MMSE.

### Brain volume in predicting dementia 

* After MMSE, decreased brain volume has the next strongest correlation with dementia.
* Average brain volume in early dementia patients was 0.73, which is significantly decreased compared to 0.77 in non-demented patients. 

## Recommendations 

* Given that MMSEs are more easily performed compared to MRIs, using MMSE to predict dementia is more cost and time efficient. This is bolstered by the fact that MMSE performance has a stronger relationship to AD than brain volume.
* Analysis of MMSE trends aids AD diagnosis, specifically with MMSE score decrease by 1.5-7 points. MMSE scores may demonstrate early AD in asymptomatic patients with MMSE greater than 25.  
* To maintain consistency and precision, the clinician proctoring routine MMSEs patient should be constant for a certain patient.

## Assumptions and Caveats

* Given the study of dementia, correlation studies omit control subjects who were missing values for education, SES, MMSE, and CDR. These subjects with missing values likely did not meet criteria for dementia given relative increased brain volume and young age. Further analysis that include missing values for control subjects would be helpful. 
*	Evaluating MMSE may be subjective and dependent on the clinician. 
*	There is a small sample of newly diagnosed dementia patients. Further longitudinal studies with larger sample size would be beneficial.
*	Further analysis with a larger sample size is encouraged to better understand MMSE changes in dementia of asymptomatic and symptomatic patients. 

## Data Query and Visualization

