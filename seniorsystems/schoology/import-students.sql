SELECT
	student.NAME_LAST "Last Name"
	,student.NAME_FIRST "First Name" 
	,student.ENTITY_NO "Entity Number"
	,student.ID "ID"
	,student.EMAIL "Email"
	,student.WEB_USER_ID "Web User ID"
	,'108549427' "School"
	,DECODE (student.SCHOOL_CODE, 
		'L', '111911539', 
		'LQ', '111911937', 
		'MQ', '111911937', 
		'U', '59897859',
		NULL) "Other School"
	,student.CURRENT_GRADE "Current Year"
	,student.CLASS_YR "Class"
FROM
	Z_V_STUDENT_CURRENT student
	
ORDER BY
	student.ENTITY_NO
	;
