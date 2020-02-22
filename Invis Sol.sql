select  cn.contest_id, cn.hacker_id, cn.[name]
, sum(d.total_submissions), sum(d.total_accepted_submissions)
, sum(d.total_views), sum(d.total_unique_views)
from [dbo].[contests] cn
	left join [dbo].[colleges] cl on cn.contest_id = cl.contest_id
	left join [dbo].[challenges] ca on ca.[college_id] = cl.college_id

	left join (
	
		select challenege_id, 
		sum(total_accepted_submissions) total_accepted_submissions, 
		sum(total_submissions) total_submissions, 
		sum(total_unique_views) total_unique_views, 
		sum(total_views) total_views from 
		(
		select challenege_id, total_accepted_submissions, total_submissions, 
		0 as total_unique_views, 0 as total_views from [dbo].[submission_stats] 
		union all
		select challenge_id, 0, 0, total_unique_views, total_views from [dbo].[view_stats] ) as x

		group by challenege_id
	) as d on d.challenege_id = ca.challenge_id

	group by cn.[name], cn.contest_id, cn.hacker_id;

--	But first....

--	CREATE TABLE [dbo].[challenges] (
--    [challenge_id] INT NOT NULL,
--    [college_id]   INT NULL,
--    PRIMARY KEY CLUSTERED ([challenge_id] ASC)
--);
--CREATE TABLE [dbo].[colleges] (
--    [college_id] INT NOT NULL,
--    [contest_id] INT NULL,
--    PRIMARY KEY CLUSTERED ([college_id] ASC)
--);
--CREATE TABLE [dbo].[contests] (
--    [contest_id] INT           NOT NULL,
--    [hacker_id]  INT           NULL,
--    [name]       NVARCHAR (50) NULL,
--    PRIMARY KEY CLUSTERED ([contest_id] ASC)
--);
--CREATE TABLE [dbo].[submission_stats] (
--    [challenege_id]              INT NOT NULL,
--    [total_submissions]          INT NULL,
--    [total_accepted_submissions] INT NULL
--);
--CREATE TABLE [dbo].[view_stats] (
--    [challenge_id]       INT NOT NULL,
--    [total_views]        INT NULL,
--    [total_unique_views] INT NULL
--);