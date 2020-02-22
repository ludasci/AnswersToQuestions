SELECT p.id, p.title,

isnull(sum(number_of_tickets),0) reserved_tickets

from plays p left join 
reservations r on p.id = r.play_id
group by p.id, p.title
order by sum(number_of_tickets) desc

--but first...

--CREATE TABLE [dbo].[plays] (
--    [id]     INT          NOT NULL,
--    [title]  VARCHAR (40) NOT NULL,
--    [writer] VARCHAR (40) NOT NULL,
--    UNIQUE NONCLUSTERED ([id] ASC)
--);
--CREATE TABLE [dbo].[reservations] (
--    [id]                INT          NOT NULL,
--    [play_id]           INT          NOT NULL,
--    [number_of_tickets] INT          NOT NULL,
--    [theater]           VARCHAR (40) NOT NULL,
--    UNIQUE NONCLUSTERED ([id] ASC)
--);
