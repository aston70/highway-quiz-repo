Use HighQuiz
GO

-- kill logged in user session if exists.
declare @spid smallint, @sql varchar(max);
select @spid=session_id
from sys.dm_exec_sessions
where login_name = 'testyuser2'

if @spid>0 
begin
	set @sql = 'kill ' + cast(@spid as varchar(4));
	exec (@sql);
end
GO

-- Drop the user/login if it already exists.
sp_dropuser 'testyuser2'
GO
drop login testyuser2
GO

-- Create a database user and login.
CREATE LOGIN testyuser2  
    WITH PASSWORD = '$#istesty_2RT';  
GO  
CREATE USER testyuser2 FOR LOGIN testyuser2;
exec sp_addrolemember 'db_owner', 'testyuser2';
GO  
sp_change_users_login 'AUTO_FIX', 'testyuser2'

select * from sys.server_principals
where name = 'testyuser2';
GO