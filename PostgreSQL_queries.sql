
----------------------------------------------------------------------------- OASIS-1 CROSS SECTIONAL QUERIES -----------------------------------------------------------------------------

--Dementia trend by demographic, MMSE, and brain volume averages--
SELECT
    "CDR" as "clinical dementia rating",
    ROUND(AVG("Educ") * 1.0, 2) AS "educ avg",
    ROUND(AVG("SES") * 1.0, 2) AS "SES avg",
    ROUND(AVG("MMSE") * 1.0, 2) AS "MMSE avg",
    ROUND(AVG("nWBV") * 1.0, 2) AS "normalized brain volume avg"
FROM "t_cross"
WHERE
    "CDR" >= '0'
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "MMSE" IS NOT NULL
    AND "nWBV" IS NOT NULL
GROUP BY "CDR"
ORDER BY "CDR" DESC;

--Early dementia averages--
SELECT
    "CDR" as "clinical dementia rating",
    ROUND(AVG("Age") * 1.0, 2) AS "avg age",
    ROUND(AVG("Educ") * 1.0, 2) AS "educ avg",
    ROUND(AVG("SES") * 1.0, 2) AS "SES avg",
    ROUND(AVG("MMSE") * 1.0, 2) AS "MMSE avg",
    ROUND(AVG("nWBV") * 1.0, 2) AS "normalized brain volume avg"
FROM "t_cross"
WHERE
    "CDR" = '0.5'
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "MMSE" IS NOT NULL
    AND "nWBV" IS NOT NULL
GROUP BY "CDR"
ORDER BY "CDR" DESC;

--Dementia and brain volume trend considering gender--
SELECT
    "M/F",
    "CDR" as "clinical dementia rating",
    ROUND(AVG("Age") * 1.0, 2) AS "avg age",
    ROUND(AVG("Educ") * 1.0, 2) AS "avg educ",
    ROUND(AVG("SES") * 1.0, 2) AS "avg SES",
    ROUND(AVG("MMSE") * 1.0, 2) AS "avg MMSE",
    ROUND(AVG("nWBV") * 1.0, 2) AS "avg nWBV"
FROM "t_cross"
WHERE
    "CDR" >= '0'
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "MMSE" IS NOT NULL
    AND "nWBV" IS NOT NULL
GROUP BY "M/F", "CDR"
ORDER BY "M/F", "CDR" DESC;

--Non-demented patient averages--
SELECT
    "M/F",
    "CDR" as "clinical dementia rating",
    ROUND(AVG("Educ") * 1.0, 2) AS "avg educ",
    ROUND(AVG("SES") * 1.0, 2) AS "avg SES",
    ROUND(AVG("MMSE") * 1.0, 2) AS "avg MMSE",
    ROUND(AVG("nWBV") * 1.0, 2) AS "avg nWBV"
FROM "t_cross"
WHERE
    "CDR" = '0'
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "MMSE" IS NOT NULL
    AND "nWBV" IS NOT NULL
GROUP BY "M/F", "CDR"
ORDER BY "M/F", "CDR" DESC;

--Dementia onset during study with 0.5 CDR increase--
SELECT
    "Subject ID",
    "Visit",
    "MR Delay",
    "CDR" AS "clinical dementia rating",
    "nWBV" AS "normalized brain volume",
    "Age"
FROM "t_long"
WHERE "Group" = 'Converted'
ORDER BY "Subject ID", "Visit" DESC;

--Longitudinal dementia change of newly diagnosed--
WITH "rank" AS (
    SELECT
        "Subject ID",
        "Group",
        "Visit",
        "MR Delay",
        "CDR",
        "M/F",
        "nWBV",
        "Age",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" ASC
        ) AS "visit_rank_asc",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" Desc
        ) AS "visit_rank_desc"
    FROM "t_long"
    WHERE "Group" = 'Converted'
        )
SELECT
    f."Subject ID",
    f."Visit" AS "first_visit",
    l."Visit" AS "latest_visit",
    f."Age" AS "first_age",
    l."Age" AS "latest_age",
    f."M/F" as "gender",
    f."CDR" AS "first_CDR",
    l."CDR" AS "latest_CDR",
    f."nWBV" AS "first_nWBV",
    l."nWBV" AS "latest_nWBV",
    ROUND((l."nWBV" - f."nWBV") * 100, 2) AS "percent change nWBV"
FROM "rank" f
JOIN "rank" l
    ON f."Subject ID" = l."Subject ID"
WHERE f."visit_rank_asc" = 1
    AND l."visit_rank_desc" = 1
ORDER BY "percent change nWBV";


--Avg percent change of brain volume with new onset dementia--
WITH "rank" AS (
    SELECT
        "Subject ID",
        "Group",
        "Visit",
        "MR Delay",
        "CDR",
        "M/F",
        "nWBV",
        "Age",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" ASC
        ) AS "visit_rank_asc",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" Desc
        ) AS "visit_rank_desc"
    FROM "t_long"
    WHERE "Group" = 'Converted'
        ),
"change" AS (
SELECT
    f."Subject ID",
    f."Visit" AS "first_visit",
    l."Visit" AS "latest_visit",
    f."Age" AS "first_age",
    l."Age" AS "latest_age",
    f."M/F" as "gender",
    f."CDR" AS "first_CDR",
    l."CDR" AS "latest_CDR",
    f."nWBV" AS "first_nWBV",
    l."nWBV" AS "latest_nWBV",
    ROUND((l."nWBV" - f."nWBV") * 100, 2) AS "percent change nWBV"
FROM "rank" f
JOIN "rank" l
    ON f."Subject ID" = l."Subject ID"
WHERE f."visit_rank_asc" = 1
    AND l."visit_rank_desc" = 1)

SELECT
    ROUND(AVG ("percent change nWBV"), 2)
FROM "change"
WHERE "latest_CDR" = '0.5';

-- Avg percent change of MMSE in new onset dementia --
WITH "rank" AS (
    SELECT
        "Subject ID",
        "Group",
        "Visit",
        "MR Delay",
        "MMSE",
        "CDR",
        "M/F",
        "nWBV",
        "Age",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" ASC
        ) AS "visit_rank_asc",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" Desc
        ) AS "visit_rank_desc"
    FROM "t_long"
    WHERE "Group" = 'Converted'
        ),
"change" AS (
SELECT
    f."Subject ID",
    f."Visit" AS "first_visit",
    l."Visit" AS "latest_visit",
    f."Age" AS "first_age",
    l."Age" AS "latest_age",
    f."M/F" as "gender",
    f."CDR" AS "first_CDR",
    l."CDR" AS "latest_CDR",
    f."MMSE" AS "first_MMSE",
    l."MMSE" AS "latest_MMSE",
    f."nWBV" AS "first_nWBV",
    l."nWBV" AS "latest_nWBV",
    ROUND(((l."MMSE" - f."MMSE") * 100) / (f."MMSE"), 2) AS "percent change MMSE"
FROM "rank" f
JOIN "rank" l
    ON f."Subject ID" = l."Subject ID"
WHERE f."visit_rank_asc" = 1
    AND l."visit_rank_desc" = 1)

SELECT
    AVG ("percent change MMSE")
FROM "change"
WHERE "latest_CDR" = '0.5';

-- Avg change of MMSE score in new onset dementia --
WITH "rank" AS (
    SELECT
        "Subject ID",
        "Group",
        "Visit",
        "MR Delay",
        "MMSE",
        "CDR",
        "M/F",
        "nWBV",
        "Age",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" ASC
        ) AS "visit_rank_asc",
        ROW_NUMBER() OVER (
            PARTITION BY "Subject ID"
            ORDER BY "Visit" Desc
        ) AS "visit_rank_desc"
    FROM "t_long"
    WHERE "Group" = 'Converted'
        ),
"change" AS (
SELECT
    f."Subject ID",
    f."Visit" AS "first_visit",
    l."Visit" AS "latest_visit",
    f."Age" AS "first_age",
    l."Age" AS "latest_age",
    f."M/F" as "gender",
    f."CDR" AS "first_CDR",
    l."CDR" AS "latest_CDR",
    f."MMSE" AS "first_MMSE",
    l."MMSE" AS "latest_MMSE",
    f."nWBV" AS "first_nWBV",
    l."nWBV" AS "latest_nWBV",
    ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
FROM "rank" f
JOIN "rank" l
    ON f."Subject ID" = l."Subject ID"
WHERE f."visit_rank_asc" = 1
    AND l."visit_rank_desc" = 1)

SELECT
    AVG ("average change of MMSE score")
FROM "change"
WHERE "latest_CDR" = '0.5';


--Dementia by gender

WITH "cte_avg" AS (

SELECT
    "M/F",
    "CDR" as "clinical dementia rating",
    ROUND(AVG("Age") * 1.0, 2) AS "avg age",
    ROUND(AVG("Educ") * 1.0, 2) AS "avg educ",
    ROUND(AVG("SES") * 1.0, 2) AS "avg SES",
    ROUND(AVG("MMSE") * 1.0, 2) AS "avg MMSE",
    ROUND(AVG("nWBV") * 1.0, 2) AS "avg nWBV"
FROM "t_cross"
WHERE
    "CDR" >= '0.5'
    AND "M/F" = 'F'
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "MMSE" IS NOT NULL
    AND "nWBV" IS NOT NULL
GROUP BY "M/F", "CDR"
ORDER BY "M/F", "CDR")

SELECT
        "avg MMSE",
        STDDEV_SAMP("avg MMSE"),
        "avg nWBV",
        STDDEV_SAMP("avg nWBV")
FROM "cte_avg"
GROUP BY "avg MMSE", "avg nWBV";



--Correlation (r-value) of clinical dementia severity (CDR) with the following--
    SELECT
        ROUND(CORR("Age", "CDR")::numeric, 3) AS "age",
        ROUND(CORR("Educ", "CDR")::numeric, 3) AS "education",
        ROUND(CORR("SES", "CDR")::numeric, 3) AS "SES",
        ROUND(CORR("nWBV", "CDR")::numeric, 3) AS "brain volume",
        ROUND(CORR("MMSE", "CDR")::numeric, 3) AS "MMSE"
    FROM t_cross
    WHERE "Age" IS NOT NULL
    AND "Educ" IS NOT NULL
    AND "SES" IS NOT NULL
    AND "nWBV" IS NOT NULL
    AND "MMSE" IS NOT NULL;

--Correlation (r-value) of brain volume with the following--
    SELECT
        ROUND(CORR("Age", "nWBV")::numeric, 3) AS "age",
        ROUND(CORR("Educ", "nWBV")::numeric, 3) AS "education",
        ROUND(CORR("SES", "nWBV")::numeric, 3) AS "SES",
        ROUND(CORR("CDR", "nWBV")::numeric, 3) AS "CDR",
        ROUND(CORR("MMSE", "nWBV")::numeric, 3) AS "MMSE"
    FROM t_cross
    WHERE "Age" IS NOT NULL
        AND "Educ" IS NOT NULL
        AND "SES" IS NOT NULL
        AND "nWBV" IS NOT NULL
        AND "MMSE" IS NOT NULL;

--Correlation (r-value) of MMSE with the following--
    SELECT
        ROUND(CORR("Age", "MMSE")::numeric, 3) AS "age",
        ROUND(CORR("Educ", "MMSE")::numeric, 3) AS "education",
        ROUND(CORR("SES", "MMSE")::numeric, 3) AS "SES",
        ROUND(CORR("CDR", "MMSE")::numeric, 3) AS "CDR",
        ROUND(CORR("nWBV", "MMSE")::numeric, 3) AS "nWBV"
    FROM t_cross
    WHERE "Age" IS NOT NULL
        AND "Educ" IS NOT NULL
        AND "SES" IS NOT NULL
        AND "nWBV" IS NOT NULL
        AND "MMSE" IS NOT NULL;

-- statistical analysis of brain volume --
    SELECT
        ROUND(AVG("nWBV"), 2) AS mean,
        ROUND(STDDEV_SAMP("nWBV"), 2) AS stddev,
        ROUND(COUNT(*), 2) AS n
    FROM "t_cross"
    WHERE "Age" IS NOT NULL
        AND "Educ" IS NOT NULL
        AND "SES" IS NOT NULL
        AND "nWBV" IS NOT NULL
        AND "MMSE" IS NOT NULL;

-- Average brain volume of demented patients --
    SELECT
        CAST(ROUND(AVG("nWBV"), 2) AS REAL)
    FROM "t_cross"
    WHERE "CDR" >= 0.5;


--Age and MMSE in dementia patients--
SELECT
    ROUND(AVG("Age"), 2) AS "Age mean",
    STDDEV_SAMP("Age") AS "Age Std Dev",
    ROUND(AVG("MMSE"), 2) AS "MMSE mean",
    STDDEV_SAMP("MMSE") AS "MMSE Std Dev",
    ROUND(COUNT(*), 2) AS n
FROM "t_cross"
WHERE "CDR" >= '0.5';

--Age and MMSE in non-dementia patients--
SELECT
    ROUND(AVG("Age"), 2) AS "Age mean",
    STDDEV_SAMP("Age") AS "Age Std Dev",
    ROUND(AVG("MMSE"), 2) AS "MMSE mean",
    STDDEV_SAMP("MMSE") AS "MMSE Std Dev",
    ROUND(COUNT(*), 2) AS n
FROM "t_cross"
WHERE "CDR" = '0';



--Factors by dementia severity--
SELECT
    ROUND("CDR", 2) AS "cdr",
    ROUND(AVG("Age"), 2) AS "age avg",
    ROUND(AVG("MMSE"), 2) AS "mmse avg",
    ROUND(AVG("nWBV"), 2) AS "nWBV avg"
FROM "t_cross"
GROUP BY "CDR"
ORDER BY "CDR";


--Distribution of CDR amongst OASIS-1--
WITH "cte1" AS (
SELECT
    COUNT(CASE WHEN("CDR" = 0) THEN 1 END) AS "no dementia",
    COUNT(CASE WHEN("CDR" = 0.5) THEN 1 END) AS "mild",
    COUNT(CASE WHEN("CDR" = 1) THEN 1 END) AS "moderate",
    COUNT(CASE WHEN("CDR" = 2) THEN 1 END) AS "severe",
    COUNT(*) AS "all"
FROM "t_cross"
)

SELECT
    ROUND(("no dementia" * 100)/"all", 2) AS "%no_dementia",
    ROUND(("mild" * 100)/"all", 2) AS "%mild",
    ROUND(("moderate" * 100)/"all", 2) AS "%moderate",
    ROUND(("severe" * 100)/"all", 2) AS "%severe"
FROM "cte1";

--Distribution of gender amongst OASIS-1--
WITH "cte1" AS (
SELECT
    COUNT(CASE WHEN("M/F" = 'F') THEN 1 END) AS "female",
    COUNT(CASE WHEN("M/F" = 'M') THEN 1 END) AS "male",
    COUNT(*) AS "all"
FROM "t_cross"
)

SELECT
    ROUND(("female" * 100)/"all", 2) AS "%female",
    ROUND(("male" * 100)/"all", 2) AS "%male"
FROM "cte1";


--statistical analysis of cross sectional brain volume--
SELECT
    ROUND(AVG(CASE WHEN "CDR" = '0' THEN "nWBV" END), 2) AS "noAD_nWBVmean",
    ROUND(STDDEV_SAMP(CASE WHEN "CDR" = '0' THEN "nWBV" END), 2) AS "noAD_stddev",
    COUNT(CASE WHEN "CDR" = '0' THEN "nWBV" END) AS "noAD_n",
    ROUND(AVG(CASE WHEN "CDR" = '0.5' THEN "nWBV" END), 2) AS "mildAD_nWBVmean",
    ROUND(STDDEV_SAMP(CASE WHEN "CDR" = '0.5' THEN "nWBV" END), 2) AS "mildAD_stddev",
    COUNT(CASE WHEN "CDR" = '0.5' THEN "nWBV" END) AS "mildAD_n",
    ROUND(AVG(CASE WHEN "CDR" = '1' THEN "nWBV" END), 2) AS "modAD_nWBVmean",
    ROUND(STDDEV_SAMP(CASE WHEN "CDR" = '1' THEN "nWBV" END), 2) AS "modAD_stddev",
    COUNT(CASE WHEN "CDR" = '1' THEN "nWBV" END) AS "modAD_n",
    ROUND(AVG(CASE WHEN "CDR" = '2' THEN "nWBV" END), 2) AS "sevAD_nWBVmean",
    ROUND(STDDEV_SAMP(CASE WHEN "CDR" = '2' THEN "nWBV" END), 2) AS "sevAD_stddev",
    COUNT(CASE WHEN "CDR" = '2' THEN "nWBV" END) AS "sevAD_n"
FROM "t_cross";

 ----------------------------------------------------------------------------- OASIS-2 LONGITUDINAL ANALYSIS QUERIES -----------------------------------------------------------------------------

-- MMSE score change and early dementia diagnoses in asymptomatic patients --
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

    SELECT
    ROUND(AVG("change of MMSE score"), 2) AS mean,
    ROUND(STDDEV_SAMP("change of MMSE score"), 2) AS stddev,
    ROUND(COUNT(*), 2) AS n
    FROM "change"
    WHERE "latest_CDR" = '0.5';

-- MMSE score change and dementia severity --
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
            ),
    "change" AS (
    SELECT
        f."Subject ID",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

    SELECT
    ROUND(AVG("change of MMSE score"), 2) AS mean,
    ROUND(STDDEV_SAMP("change of MMSE score"), 2) AS stddev,
    ROUND(COUNT(*), 2) AS n
    FROM "change"
    WHERE "latest_CDR" >= '0.5';

--Early AD diagnosis and MMSE change--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

    SELECT
    ROUND(AVG("change of MMSE score"), 2) AS "avg MMSE change",
    ROUND(STDDEV_SAMP("change of MMSE score"), 2) AS "std dev",
    ROUND(COUNT("change of MMSE score"), 2) AS n
    FROM "change";


--New onset latest MMSE score--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

    SELECT
    ROUND(AVG("latest_MMSE"), 2) AS "avg MMSE",
    ROUND(STDDEV_SAMP("latest_MMSE"), 2) AS "std dev",
    ROUND(COUNT("latest_MMSE"), 2) AS n
    FROM "change";

--New onset MMSE avg--
SELECT
    ROUND(AVG("MMSE"), 2)
FROM "t_long"
WHERE "Group" = 'Converted';


--Distribution of CDR amongst OASIS-2--
WITH "cte1" AS (
SELECT
    COUNT(CASE WHEN("CDR" = 0) THEN 1 END) AS "no dementia",
    COUNT(CASE WHEN("CDR" = 0.5) THEN 1 END) AS "mild",
    COUNT(CASE WHEN("CDR" = 1) THEN 1 END) AS "moderate",
    COUNT(CASE WHEN("CDR" = 2) THEN 1 END) AS "severe",
    COUNT(*) AS "all"
FROM "t_long"
WHERE "Visit" = '1'
)

SELECT
    ROUND(("no dementia" * 100)/"all", 2) AS "%no dementia",
    ROUND(("mild" * 100)/"all", 2) AS "%mild",
    ROUND(("moderate" * 100)/"all", 2) AS "%moderate",
    ROUND(("severe" * 100)/"all", 2) AS "%severe"
FROM "cte1";

--Distribution of final cognition using in OASIS-2--
WITH "cte1" AS (
SELECT
    COUNT(CASE WHEN("Group" = 'Nondemented') THEN 1 END) AS "no dementia",
    COUNT(CASE WHEN("Group" = 'Demented') THEN 1 END) AS "demented",
    COUNT(CASE WHEN("Group" = 'Converted') THEN 1 END) AS "converted",
    COUNT(*) AS "all"
FROM "t_long"
WHERE "Visit" = '1')

SELECT
    ROUND(("no dementia") * 100/"all", 2) AS "%no_dementia",
    ROUND(("demented") * 100/"all", 2) AS "%demented",
    ROUND(("converted") * 100/"all", 2) AS "%new_onset"
FROM "cte1";


--Distribution of gender amongst OASIS-2--
WITH "cte1" AS (
SELECT
    COUNT(CASE WHEN("M/F" = 'F') THEN 1 END) AS "female",
    COUNT(CASE WHEN("M/F" = 'M') THEN 1 END) AS "male",
    COUNT(*) AS "all"
FROM "t_long"
WHERE "Visit" = '1'
)

SELECT
    ROUND(("female" * 100)/"all", 2) AS "%female",
    ROUND(("male" * 100)/"all", 2) AS "%male"
FROM "cte1";


--Brain volume of all dementia levels--
SELECT
    ROUND(AVG("nWBV"), 2) AS "avgBV",
    ROUND(STDDEV_SAMP("nWBV"), 2) AS "stddev",
    COUNT("nWBV") as "n"
FROM "t_long"
WHERE "CDR" >= '0.5';

--Avg initial MMSE of newly diagnosed--
SELECT
    ROUND(AVG("MMSE"), 2) AS "avg_first_MMSE",
    ROUND(STDDEV_SAMP("MMSE"), 2) AS "stddev",
    COUNT("MMSE") as "n"
FROM "t_long"
WHERE "Visit" = '1'
    AND "Group" = 'Converted';

--MMSE of all dementia levels--
SELECT
    ROUND(AVG("MMSE"), 2) AS "avgMMSE",
    ROUND(STDDEV_SAMP("MMSE"), 2) AS "stddev",
    COUNT("MMSE") as "n"
FROM "t_long"
WHERE "CDR" >= '0.5';

--Initial brain volume by dementia group--
SELECT
    ROUND(AVG(CASE WHEN "Group" = 'Nondemented' AND "Visit" = '1' THEN "nWBV" END), 2) AS "nondemented initial brain vol",
    ROUND(AVG(CASE WHEN "Group" = 'Converted' AND "Visit" = '1' THEN "nWBV" END), 2) AS "converted initial brain vol",
    ROUND(AVG(CASE WHEN "Group" = 'Demented' AND "Visit" = '1' THEN "nWBV" END), 2) AS "demented initial brain vol"
FROM "t_long";

--Nondemented avg initial brain volume--
SELECT
    ROUND(AVG("nWBV"), 2) AS "avg initial brain volume",
    ROUND(STDDEV_SAMP("nWBV"), 2) AS "std dev",
    ROUND(COUNT("nWBV"), 2) AS n

FROM "t_long"
WHERE "Group" = 'Nondemented'
    AND "Visit" = '1';

--Newly diagnosed avg initial brain volume--
SELECT
    ROUND(AVG("nWBV"), 2) AS "avg initial brain volume",
    ROUND(STDDEV_SAMP("nWBV"), 2) AS "std dev",
    ROUND(COUNT("nWBV"), 2) AS n

FROM "t_long"
WHERE "Group" = 'Converted'
    AND "Visit" = '1';

--Newly diagnosed latest brain volume--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

    SELECT
    ROUND(AVG("latest_nWBV"), 2) AS "avg latest brain volume",
    ROUND(STDDEV_SAMP("latest_nWBV"), 2) AS "std dev",
    ROUND(COUNT("latest_nWBV"), 2) AS n
    FROM "change";

--brain volume change in newly diagnosed--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID" AS "id",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1),

"avg" AS (
    SELECT
        "id",
        ("latest_nWBV" - "first_nWBV") / ("first_nWBV") AS "nWBV change"
    FROM "change"
    GROUP BY "id", "nWBV change")

SELECT
    AVG("nWBV change"),
    ROUND(STDDEV_SAMP("nWBV change"), 2) AS "std dev",
    ROUND(COUNT("nWBV change"), 2) AS n
FROM "avg";

--atrophy rate in newly diagnosed--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
        WHERE "Group" = 'Converted'
            ),
    "change" AS (
    SELECT
        f."Subject ID" AS "id",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        l."MR Delay" AS "latest_mrdelay",
        f."MR Delay" AS "first_mrdelay",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1)

SELECT
    "id",
    "first_age",
    "latest_age",
    "first_nWBV",
    "latest_nWBV",
    ROUND((("latest_nWBV" - "first_nWBV")*100) / ("latest_age" - "first_age"), 4)
        AS "%brain volume change by year"
FROM "change"
GROUP BY "id", "first_age", "latest_age", "first_nWBV", "latest_nWBV"
ORDER BY "id";

--average yearly atrophy by AD stage--
    WITH "rank" AS (
        SELECT
            "Subject ID",
            "Group",
            "Visit",
            "MR Delay",
            "MMSE",
            "CDR",
            "M/F",
            "nWBV",
            "Age",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" ASC
            ) AS "visit_rank_asc",
            ROW_NUMBER() OVER (
                PARTITION BY "Subject ID"
                ORDER BY "Visit" Desc
            ) AS "visit_rank_desc"
        FROM "t_long"
            ),
    "change" AS (
    SELECT
        f."Subject ID" AS "id",
        f."Group" AS "group",
        f."Visit" AS "first_visit",
        l."Visit" AS "latest_visit",
        l."MR Delay" AS "latest_mrdelay",
        f."MR Delay" AS "first_mrdelay",
        f."Age" AS "first_age",
        l."Age" AS "latest_age",
        f."M/F" as "gender",
        f."CDR" AS "first_CDR",
        l."CDR" AS "latest_CDR",
        f."MMSE" AS "first_MMSE",
        l."MMSE" AS "latest_MMSE",
        f."nWBV" AS "first_nWBV",
        l."nWBV" AS "latest_nWBV",
        ROUND(l."MMSE" - f."MMSE", 2) AS "change of MMSE score"
    FROM "rank" f
    JOIN "rank" l
        ON f."Subject ID" = l."Subject ID"
    WHERE f."visit_rank_asc" = 1
        AND l."visit_rank_desc" = 1),

"individual" AS (
    SELECT
        "id",
        "first_age",
        "latest_age",
        "first_nWBV",
        "latest_nWBV",
        ROUND((("latest_nWBV" - "first_nWBV")*100) / ("latest_age" - "first_age"), 4)
            AS "nWBV percent yearly change",
        "group"
    FROM "change"
    GROUP BY "id", "first_age", "latest_age", "first_nWBV", "latest_nWBV", "group"
    ORDER BY "id")

SELECT
    ROUND(AVG(CASE WHEN "group" = 'Nondemented' THEN "nWBV percent yearly change" END), 2) AS "nondemented %atrophy",
    ROUND(AVG(CASE WHEN "group" = 'Converted' THEN "nWBV percent yearly change" END), 2) AS "new onset %atrophy",
    ROUND(AVG(CASE WHEN "group" = 'Demented' THEN "nWBV percent yearly change" END), 2) AS "demented %atrophy"
FROM "individual";
