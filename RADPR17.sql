--select 
--	EXAM_TYPE_UID,
--	--DATEDIFF(yy, DOB, CONVERT(date, getdate())) [age],
--	COUNT(DOB) [test]
--FROM RPTV_STUDYDETAIL
--GROUP BY EXAM_TYPE_UID

--select
--	distinct exam [ประเภทการตรวจ],
--	sum(case when age < 15 then 1 else 0 end) [เด็ก],
--	sum(case when age >= 15 then 1 else 0 end) [ผู้ใหญ่]
--from (
--	select 
--	EXAM_TYPE_UID [exam],
--	DATEDIFF(yy, DOB, CONVERT(date, getdate())) [age]
--	FROM RPTV_STUDYDETAIL
--) as t

select
	XLOCATE.XLOCATE_NAME,
	RPTV_STUDYDETAIL.EXAM_TYPE_UID [ประเภทการตรวจ],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) < 15) AND (RPTV_STUDYDETAIL.AN IS NULL) then 1 else 0 end) [เด็กนอก],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) >= 15) AND (RPTV_STUDYDETAIL.AN IS NULL) then 1 else 0 end) [ผู้ใหญ่นอก],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) < 15) AND (RPTV_STUDYDETAIL.AN IS NOT NULL) then 1 else 0 end) [เด็กใน],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) >= 15) AND (RPTV_STUDYDETAIL.AN IS NOT NULL) then 1 else 0 end) [ผู้ใหญ่ใน],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) < 15) then 1 else 0 end) [เด็กรวม],
	sum(case when (DATEDIFF(yy, RPTV_STUDYDETAIL.DOB, CONVERT(date, getdate())) >= 15) then 1 else 0 end) [ผู้ใหญ่รวม]
from RPTV_STUDYDETAIL
	inner join XLOCATE
	on RPTV_STUDYDETAIL.XLOCATE = XLOCATE.XLOCATE_UID 
WHERE (RPTV_STUDYDETAIL.ORDER_DT BETWEEN '2016-10-01' AND '2017-01-30') AND (XLOCATE.XLOCATE_NAME IN ('Day Care ว่องวานิชชั้น 6')) 
GROUP BY XLOCATE.XLOCATE_NAME, RPTV_STUDYDETAIL.EXAM_TYPE_UID
ORDER BY XLOCATE.XLOCATE_NAME, RPTV_STUDYDETAIL.EXAM_TYPE_UID

--select
--	EXAM_TYPE_UID [ประเภทการตรวจ],
--	DATEDIFF(yy, DOB, CONVERT(date, getdate())) [age],
--	XLOCATE.XLOCATE_NAME
--from RPTV_STUDYDETAIL
--	inner join XLOCATE
--	on RPTV_STUDYDETAIL.XLOCATE = XLOCATE.XLOCATE_UID

select 
	distinct XLOCATE_NAME
from XLOCATE