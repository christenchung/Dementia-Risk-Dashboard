### Demographic correlations with dementia 

'''  
SELECT
    ROUND(CORR("MMSE", "CDR")::numeric, 3) AS "MMSE and CDR correlation r",
    ROUND(CORR("Educ", "CDR")::numeric, 3) AS "education and CDR correlation r",
    ROUND(CORR("SES", "CDR")::numeric, 3) AS "SES and CDR correlation r",
    ROUND(CORR("nWBV", "CDR")::numeric, 3) AS "brain volume and CDR correlation r",
    ROUND(CORR("MMSE", "CDR")::numeric, 3) AS "MMSE and CDR correlation r"
FROM t_cross;
'''

dd
