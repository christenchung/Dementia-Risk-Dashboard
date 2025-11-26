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
*	Clinicians can utilize MMSE changes and brain volume as early warning signs of AD. Performing MMSEs are more feasible than ordering repeat MRIs examining brain volume. 

### MMSE 

* MMSEs (Mini-Mental Status Exams) assess dementia and can easily be done by health care providers.
* Dementia was most associated with how subjects did on MMSEs. When comparing scores of past MMSEs, doing worse was associated with future dementia diagnosis, even if the subject had no apparent cognitive impairment at that time. 
* MMSE change predicts future AD more reliably than focusing on a 'normal' MMSE score. Those that developed AD were found to do worse on subsequent MMSEs, despite still scoring 'normally'. 
* Worsening MMSE performance is associated with increasing AD severity.
* Change in MMSE from about 1-3 points may predict AD or its exacerbation.
* MMSE trends can be used to in AD prediction and gauging severity, especially in those appearing asymptomatic.
* Further analysis of MMSE change as a tool for early diagnosis could possibly save patients, families, and health care systems from further economic burden.

### Brain volume 

* In AD, brain degeneration leads to decreased brain volume. 
* Reduction in brain volume is associated with worsening dementia. In later stages, volume loss occurs at a faster rate.
* Earlier stages have a 4-5% reduction in brain volume. As disease progresses, brain volume decreased by 9%.
* Quantifying brain volume changes may offer insight on disease staging.
* Brain volume can be used to in AD prediction and gauging severity, similar to MMSE.
    <img width="1074" height="680" alt="Screenshot 2025-11-25 at 11 16 24 AM" src="https://github.com/user-attachments/assets/56de9b69-d1f0-42c6-b707-7d3e3bde62d2" />
    <img width="1686" height="519" alt="Screenshot 2025-11-25 at 9 03 36 AM" src="https://github.com/user-attachments/assets/3e9b14b8-4492-46d5-9892-cf7d362cddd0" />


### Age  

* There is an association between increasing age and dementia.
* Age can be used to assess AD presence but is not reliable assessing severity.
* MMSE and brain volume are more reliable in disease stage classification.
* Subjects with dementia had an average age of 76. Subjects over 76 years old with worsening MMSE scores likely have some degree of AD currently or in the future.

## Recommendations 

* While both brain volume and MMSEs are useful in Alzheimer's Dementia analysis, MMSEs present a cost-effective, time saving option if MRIs are inaccessible.
* Clinicians performing MMSEs should be constant to minimize variability for a patient's sequential visits.
* Further analysis is needed to address representation gaps in OASIS-1 and -2 (see [Assumptions and Caveats](#assumptions-and-caveats)). Specifically, studies should include a larger sample size that adequately represents males and subjects with advanced AD. 
* Quantifying findings into a "MMA" score may demonstrate AD. The proposed MMA score considers MMSE total, MMSE score change, and age in predicting AD.

## Assumptions and Caveats
* Both datasets disproportionately represented:
    * nondemented and early dementia significantly more than advanced disease.
    * subjects with normal cognition more than decreased cognition (baseline CDR). 
    * females more than males.
* Longitudinal values of advanced AD were likely limited due to death. 
* The cross-sectional data was missing values for 200 young subjects that the study used as controls. They likely did not meet dementia criteria given age and brain volume.  Since these subjects are assumed to be nondemented, correlational studies omitted these subjects. This may have affected data interpretation. Study a larger sample size with complete data, even in non-demented subjects, is recommended. 
* Evaluating MMSE may be subjective and dependent on clinician.

## Data Query and Visualization

