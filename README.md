# Dementia Risk Dashboard 

## Table of Contents

- [Project Background](#project-background) <br>
- [Executive Summary](#executive-summary) <br>
- [Insights](#insights) <br>
  - [Demographic and clinical trends](#demographic-and-clinical-trends) <br>
  - [Cognition](#cognition) <br>
  - [Brain Volume](#brain-volume) <br>
  - [Age](#age) <br>
- [Recommendations](#recommendations) <br>
  - [Dementia Dashboard](#dementia-dashboard) <br>
  - [Further studies recommended](#further-studies-recommended)
- [Assumptions and Caveats](#assumptions-and-caveats) <br>

## Project Background

Alzheimer's dementia (AD) is incurable and a leading cause of death in the U.S. [(Skaria, 2022)](https://www.ajmc.com/view/the-economic-and-societal-burden-of-alzheimer-disease-managed-care-considerations). Cognitive decline significantly impedes quality of life. AD diagnosis is difficult and takes time. Only 50% of those with AD are diagnosed. It comes on very silently and gradually. These early, asymptomatic stages often last 3-11 years. [(Mayo Clinic)](https://www.mayoclinic.org/diseases-conditions/alzheimers-disease/in-depth/alzheimers-stages/art-20048448). AD often reveals itself after significant disease progression. When one finally notices symptoms a decade into silent disease, confirmatory tests are invasive, time consuming, and not readily available [(Skaria, 2022)](https://www.ajmc.com/view/the-economic-and-societal-burden-of-alzheimer-disease-managed-care-considerations). Early AD diagnoses reduce future costs and improve quality of life. This provides patients and families time to start treatment, address risk factors, enroll in clinical trials, and to plan for long-term care. Early AD diagnosis is cost-effective for patients, families, and Medicare/Medicaid, as demonstrated by several studies. Early AD diagnosis was found to reduce annual patient cost by 9-14%, or $4,300 per patient per year. This is significant, given that AD costs will triple and be greater than $1 trillion by 2060, when AD in Americans is projected to double. Early diagnosis is a key tool in alleviating economic burden. By exploring Open Access Series of Imaging Studies (OASIS) data, [OASIS-1](https://sites.wustl.edu/oasisbrains/home/oasis-1/) and [OASIS-2](https://sites.wustl.edu/oasisbrains/home/oasis-2/), I explore the various stages of AD in order to find signs that may predict its silent early stage. 

## Executive Summary 

* **Problem**:  Due to the silent, early stages of AD, diagnosis when patients are already symptomatic are typical. However, late diagnosis exacerbates quality of life, economic burden, and the healthcare system.
  
* **Methodology and Data**:  I used PostgreSQL and Python to clean, transform, and appropriately managed missing values and outliers in 1200+ cross-sectional and longitudinal patient visits. With SQL, Python, and R, I performed exploratory data analysis (EDA) to reveal statistically significant correlational relationships using t-tests, regression lines, and confidence intervals. I applied this analysis on Tableau. I created a [Dementia Dashboard](https://public.tableau.com/views/AlzheimersDementiaPatientTracker/Dashboard12?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) for decision support. To test this, I created a sample of patients with MRI and cognitive data similar to OASIS studies. The Patient Tracker flags patients with early AD risk. 
  
* **Key Findings**:  2 factors were significantly associated with any AD, including asymptomatic early AD: (1) cognitive function and (2) brain volume. Worsening cognitive function and decreased brain volume was associated with AD despite being asymptomatic.
  
* **Recommendations**: Pursue additional studies on features of early AD. Extend studies to a larger sample size in order to refine flagging parameters, with a future goal to implement this  [Dementia Dashboard](https://public.tableau.com/views/AlzheimersDementiaPatientTracker/Dashboard12?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) for early diagnosis. Its patient tracker identifies high risk patients through MRI imaging and clinical cognitive assessments, even if the patient seems asymptomatic.

## Insights

### Demographic and clinical trends  

* AD diagnosis is associated with cognitive function, decreased brain volume, and age. The severity of AD is strongly related to decreasing cognitive function and brain volume.
* Cognitive function is easily measured at routine doctor appointments through a brief Mini-Mental Status Exam (MMSE). Poor MMSE performance is related to AD.
* Age is still related to AD severity, but to a lesser extent than factors directly related to the disease process, such as brain volume and cognitive function. People can age without developing AD. 
* Decreasing brain volume signifies brain atrophy, which causes cognitive decline. This manifests as poor MMSE performance.
* Clinicians can utilize MMSE changes and brain volume as early warning signs of AD. 

### Cognition 

* MMSEs (Mini-Mental Status Exams) assess dementia and can easily be done by health care providers.
* Dementia was most associated with how subjects did on MMSEs. When comparing scores of past MMSEs, doing worse was associated with future dementia diagnosis, even if the subject had no apparent cognitive impairment at that time. 
* AD analysis could improve by broadening focus from today's score to look at score trends.
* Those that developed AD were found to do worse on subsequent MMSEs despite scoring 'normally'. 
* Worsening MMSE performance is associated with increasing AD severity.
* Change in MMSE from about 1-3 points may predict AD or its exacerbation.
* MMSE trends can be used to in AD prediction and gauging severity, especially in those appearing asymptomatic.
* Further analysis of MMSE change as a tool for early diagnosis could possibly save patients, families, and health care systems from further economic burden.

### Brain volume 

* In AD, brain degeneration leads to decreased brain volume measured from MRI. 
* Reduction in brain volume is associated with clinical diagnosis of dementia. In later stages, volume loss occurs at a faster rate.
* Newly diagnosed subjects had a 3% reduction in brain volume.
* In early stages of AD, there was 4-5% reduction in brain volume. In severe AD, brain volume decreased by 9%.
* Both newly diagnosed and demented subjects had similar atrophy rates, which were almost twice as fast as normal aging subjects. MRI revealed worsening atophy even though the patient  MMSE scores.
* Quantifying brain volume changes may offer insight on disease staging.
* Brain volume can be used to in AD prediction and gauging severity, similar to MMSE.

### Age  

* There is some association between increasing age and dementia.
* Age can be used to assess AD presence but is not reliable assessing severity.
* MMSE and brain volume are more reliable in disease stage classification.
* Subjects with dementia had an average age of 76. Subjects over 76 years old with worsening MMSE scores of 3 or more points likely have some degree of AD currently or in the future.
<img width="1435" height="860" alt="Screenshot 2025-12-10 at 8 09 17 AM" src="https://github.com/user-attachments/assets/575f3e03-5f2b-4bd0-9838-7ad460ef2cbb" />

## Recommendations 

### Dementia Dashboard 

  * [This Tableau dementia dashboard](https://public.tableau.com/views/AlzheimersDementiaPatientTracker/Dashboard12?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) is intended for clinician use to aid diagnostic decision making. It considers clinical and quantitative change using MMSE and MRI values, respectively.
  * The dashboard flags patients with worsening MMSE performance and/or decreased brain volume. This includes those without AD history. If flagged, the dashboard recommends further workup for possible disease onset. 
<img width="1377" height="857" alt="Screenshot 2025-12-08 at 11 43 49 AM" src="https://github.com/user-attachments/assets/e3d413ed-3c71-46bb-8059-b6d23a519e1d" />

### Further studies recommended:

  * to address representation gaps in OASIS-1 and -2 (see [Assumptions and Caveats](#assumptions-and-caveats)) 
  * on other features (clinical and imaging) of early AD.
  * compare brain volume accuracy of CT scan versus MRI. CT scans may offer convenience and affordability over MRIs.
  * to analyze if MMSE change is a sufficient feature of early AD. While both brain volume and MMSEs are useful in Alzheimer's Dementia analysis, MMSEs may present a cost-effective, time saving option if MRIs are inaccessible.
  * The same clinicians should perform MMSEs for a given patient in order to minimize variability.

## Assumptions and Caveats

* Both datasets disproportionately represented:
    * nondemented and early dementia significantly more than advanced disease.
    * subjects with normal cognition more than decreased cognition (baseline CDR). 
    * females more than males.
* Longitudinal values of advanced AD were likely limited due to death. 
* The cross-sectional data was missing values for 200 young subjects that the study used as controls. They likely did not meet dementia criteria given age and brain volume.  Since these subjects are assumed to be nondemented, correlational studies omitted these subjects. This may have affected data interpretation. Study a larger sample size with complete data, even in non-demented subjects, is recommended. 
* Evaluating MMSE may be subjective and dependent on clinician.

