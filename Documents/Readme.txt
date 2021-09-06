This HighwayQuiz solution is a collection of .net projects designed to fullfill the requirements
listed in the Software Developer Coding Exercise v1.0.docx document.

Some things to note:

The solution requires a database to be installed. Instructions for the database setup are included in 
the Readme.txt file located in the HighwayQuiz.DL project - Database Setup folder. There are two options
for database setup; 1. Using the supplied mdf file or 2. Executing the supplied script files

Solution Logging uses (nuget package) NLog: https://nlog-project.org/
	A logger object is typically created at the UI level and passed to dependencies.

There are multiple projects in the solution - each having their own purpose. They separate the solution
into the following layers: UI, Business Logic, Data Access, Data Objects, and Unit Tests. Most are in 
C# and some are in VB.Net to show use of both.

* HighwayQuiz.Web.UI - This is the Web Application project and should be set as the startup project. It
	is a C# MVC application. It also has a HighwayQuizWebService.asmx that is called from jquery
	for the purpose of form validation. Form validation is performed in javascript, but also in code
	behind to show the use of both.

	CSS media queries are used to size the radio buttons larger for tablet and mobile phone screens.

	Each question must select an answer before the next button is enabled.

* HighwayQuiz.UnitTest - Provides unit tests for the solution. Currently, there is only one that validates
	email address validation.

* HighwayQuiz.DTO - Contains Data Objects for the solution. Also in use is an extension method using
	generics to convert serializable DTOs to xml. This is used in the BL along with an xslt template to
	transform the QuizDTO into an email body.

* HighwayQuiz.DL - Database access layer. This is where the application calls the database to get quiz
	information and to save users and quizzes that are completed.

* HighwayQuiz.BL - Business Logic Layer. This layer handles creating user and quiz objects, scoring and
	emailing quizzes, as well as any validation that requires logic such as email address validation.

	Emails are sent using gmail as the smtp host and is currently configured with a supplied account. Nothing
	should need to be changed in order to send email. However, in the <HighwayQuiz.BL.Properties.Settings> 
	section of the Web.config file, the account settings and host settings can be modified. Sending Emails
	can be turned off entirely by setting the SendEmailOn setting value to False. Note: when Emails
	are sent successfully, the completed quiz results page indicate to the user that an email was sent.

* HighwayQuiz.Batch.UI - This is only a simple console project used to test a few things when building out
	the solution.