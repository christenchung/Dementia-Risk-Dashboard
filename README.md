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

*	Whether or not a patient has AD is strongly associated with age, cognitive function, and decreased brain volume. The severity of AD is strongly related to decreasing cognitive function and brain volume.
*	Cognitive function is easily measured at routine doctor appointments through a brief Mini-Mental Status Exam (MMSE). Poor MMSE performance is related to AD.
*	Age is still related to AD severity, but to a lesser extent than factors directly related to the disease process, such as brain volume and cognitive function. People can age without developing AD. 
*	Decreasing brain volume signifies brain atrophy, which causes cognitive decline. This manifests as poor MMSE performance.
*	Clinicians can utilize MMSE changes and brain volume as early warning signs of AD.
<img width="1845" height="993" alt="Screenshot 2025-11-24 at 7 01 15 PM" src="https://github.com/user-attachments/assets/2658d6c7-5afd-4645-a58b-fffa8197c053" />

### MMSE trends best predict AD 

*	Poor MMSE performance has the strongest correlation with dementia presence and degree. Scoring 1.5-7 points lower from prior MMSE correlates with dementia at any stage. 
* Although a normal MMSE score is considered to be 25+ out of 30, patients with mild dementia scored greater than 25. There is a discrepancy in AD classification and MMSE score. Tunnel vision of numeric thresholds (such as MMSE score of 25+) ignores the asymptomatic, early stages of AD. Delaying diagnosis contribute to significant economic burden. 
* Instead, early diagnosis can be facilitated by examining changes to MMSE performance, even if the score is considered normal (25 or above).
* Early AD was diagnosed in patients, 90% of whom scored 25+ on the MMSE. 80% of the newly diagnosed did worse on the MMSE.
* Those in the early stages of dementia had appearantly normal MMSE scores, but most were found to have worsened MMSE performance. Thus, it is worth looking at MMSE score change.
* Most saw a score change of 0 to -3 points, with the average being -1.4 points. 
* MMSE score trends can demonstrate early AD in asymptomatic patients with MMSE greater than 25. 
 <img width="1306" height="207" alt="Screenshot 2025-11-24 at 5 33 47 PM" src="https://github.com/user-attachments/assets/ed4ef1eb-92e3-4318-8f9f-5e2ca7fa0777" />

### Brain volume is difficult 

* After MMSE, decreased brain volume has the next strongest correlation with dementia.
* Average brain volume in early dementia patients was 0.73, which is significantly decreased compared to 0.77 in non-demented patients.
* This is done with MRIs which is not as feasible than MMSEs. 

### Age  

* There is a proportional relationship between increasing age and dementia severity, though this is not as strong as MMSE and brain volume.
* The average age of dementia patients was 76, with 67% of dementia patients are within ages 70-84. 

## Recommendations 

* Given that MMSEs are more easily performed compared to MRIs, using MMSE to predict dementia is more cost and time efficient. This is bolstered by the fact that MMSE performance has a stronger relationship to AD than brain volume.
* To maintain consistency and precision, the clinician proctoring routine MMSEs patient should be constant for a certain patient.
* Quantifying findings into a "MMA" score may demonstrate AD. The proposed MMA score considers MMSE total, MMSE score change, and age in predicting AD.

## Assumptions and Caveats

* Given the study of dementia, correlation studies omit control subjects who were missing values for education, SES, MMSE, and CDR. These subjects with missing values likely did not meet criteria for dementia given relative increased brain volume and young age. Further analysis that include missing values for control subjects would be helpful. 
*	Evaluating MMSE may be subjective and dependent on the clinician. 
*	There is a small sample of newly diagnosed dementia patients. Further longitudinal studies with larger sample size would be beneficial.
*	Further analysis with a larger sample size is encouraged to better understand MMSE changes in dementia of asymptomatic and symptomatic patients. 

## Data Query and Visualization

