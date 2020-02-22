SELECT left_title, right_title
from (
select null left_title,
title right_title, page_no pn
from recipes r3
where page_no % 2 <> 0 
and isnull((SELECT r7.title from recipes r7 where r7.page_no=r3.page_no-1),'n') = 'n'

union all

SELECT 
case when page_no % 2 = 0 then title else null end left_title,
(select title from recipes r2 where page_no = r1.page_no+1) right_title, page_no pn
from recipes r1

where page_no % 2 = 0
) as x order by pn asc

--but first...

--CREATE TABLE [dbo].[recipes] (
--    [page_no] INT          NOT NULL,
--    [title]   VARCHAR (30) NOT NULL,
--    UNIQUE NONCLUSTERED ([page_no] ASC)
--);