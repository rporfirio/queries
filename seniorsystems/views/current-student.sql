SELECT 
	sr.ID
	,sm.ENTITY_NO
	,sr.FAMILY_ID
	,TRIM(sm.LAST_NAME) "NAME_LAST"
	,TRIM(sm.FIRST_NAME) "NAME_FIRST"
	,TRIM(sm.PREFERRED_NAME) "NAME_PREFERRED"
	,sm.SEX_CODE "GENDER"
	,sr.CLASS_YR
	,sr.CURRENT_GRADE
  ,DECODE(UPPER(TRIM(sr.CURRENT_GRADE)),
    'PK','PK',
    'JA','K',
    'J1','1',
    'J2','2',
    'J3','3',
    'J4','4',
    'M1','5',
    'M2','6',
    'M3','7',
    'M4','8',
    'T1','9',
    'T2','10',
    'T3','11',
    'T4','12'
    ) "CURRENT_GRADE_STANDARD"
  ,DECODE(UPPER(TRIM(sr.CURRENT_GRADE)),
    'PK',10,
    'JA',20,
    'J1',30,
    'J2',40,
    'J3',50,
    'J4',60,
    'M1',70,
    'M2',80,
    'M3',90,
    'M4',100,
    'T1',110,
    'T2',120,
    'T3',130,
    'T4',140
    ) "CURRENT_GRADE_SEQUENCE"
  ,sr.HOMEROOM
  ,sr.HRTEACHER_ID "HOMEROOM_TEACHER_ID"
	,sm.BIRTH_DATE "DATE_BIRTH"
	,sr.STUDENT_GROUP
	,sr.ENROLL_STATUS
	,LOWER(TRIM(sm.EMAIL)) "EMAIL"
  ,UPPER(TRIM(wu.USER_ID)) "WEB_USER_ID"
  ,UPPER(TRIM(sr.SCHOOL_CODE)) "SCHOOL_CODE"
  ,CASE
    WHEN sr.SCHOOL_CODE IN ('L','U') THEN 'Manhattan'
    ELSE 'Queens' END "CAMPUS"
	,CASE
		WHEN sr.SCHOOL_CODE IN ('L','LQ') THEN 'Junior School'
		WHEN sr.CURRENT_GRADE LIKE 'M%' THEN 'Middle School'
		WHEN sr.CURRENT_GRADE LIKE 'T%' THEN 'Tutorial House'
		ELSE NULL END "SCHOOL_NAME"
	,CASE
		WHEN sr.SCHOOL_CODE IN ('L','LQ') THEN 'JS'
		WHEN sr.CURRENT_GRADE LIKE 'M%' THEN 'MS'
		WHEN sr.CURRENT_GRADE LIKE 'T%' THEN 'TH'
		ELSE NULL END "SCHOOL_NAME_CODE"
  ,CASE
    WHEN sr.SCHOOL_CODE IN ('L','U') THEN 'M'
    ELSE 'Q' END "CAMPUS_CODE"
	,TRIM(sm.FIRST_NAME)||' '|| TRIM(sm.LAST_NAME) "NAME_FULL"
	,TRIM(sm.PREFERRED_NAME)||' '|| TRIM(sm.LAST_NAME) "NAME_FULL_PREFERRED"
	,TRIM(sm.LAST_NAME)||', '|| TRIM(sm.FIRST_NAME) "NAME_FULL_SORT"
	,UPPER(TRIM(sm.LAST_NAME)||' '||TRIM(sm.FIRST_NAME)) "NAME_SEQUENCE"
    
FROM 
  STUDENT sr
  ,STUDENT_MASTER sm
		LEFT OUTER JOIN WEB_USERS wu
		ON wu.ENTITY_NO = sm.ENTITY_NO

WHERE
	sr.STU_RECORD_NO = sm.STU_RECORD_NO
  AND sr.STUDENT_GROUP = 'Student'
	AND sr.ENROLL_STATUS <> 'Withdrawn'
	AND sr.SCHOOL_CODE IN ('L','LQ','MQ','U')
