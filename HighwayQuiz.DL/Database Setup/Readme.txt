Two methods below can be used to create an instance of the required HighwayQuiz database.

Once the database is created, make sure the connection string setting in the <HighwayQuiz.DL.My.MySettings>
section of the WEB.CONFIG file is set correctly. Only change settings in the web.config file in the 
Web Application UI project. Any other changes are unnecessary. 


Method 1. MDF file:

	Copy the following 2 files in the mdf directory:
		* HighQuiz.mdf
		* HighQuiz_log.ldf

	And put them in the sql server data folder typically located here:
	C:\Program Files\Microsoft SQL Server\{Sql Server Version}\MSSQL\DATA

	Then follow the procedures at this reference for: 
	Using SQL Server Management Studio - To Attach a Database
	https://docs.microsoft.com/en-us/sql/relational-databases/databases/attach-a-database?view=sql-server-ver15


Method 2. Database Scripts

	To setup the database, execute the included db scripts in the following order:

	Create Database.sql
	Create User.sql
	Load Data.sql
