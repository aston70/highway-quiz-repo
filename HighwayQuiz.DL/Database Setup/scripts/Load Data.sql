USE HighQuiz
GO

SET ANSI_WARNINGS OFF
GO

-- ======================================================================================
-- Author:		Danny Smith
-- Create date: 2020-08-30
-- Description: Load Question and Answer data.
-- ======================================================================================

declare @questionId int;

declare @active bit = 1;
declare @questionTable varchar(100) = 'dbo.Question';


begin try

	begin transaction LoadQuestionData;

	--truncate table UserQuizResult
	--truncate table dbo.Answer;
	--truncate table dbo.Question;

	delete from dbo.UserQuiz;
	delete from dbo.QuizDetail;
	delete from dbo.Quiz;
	DBCC CHECKIDENT ('dbo.Quiz',RESEED, 0)
	delete from dbo.Answer;
	DBCC CHECKIDENT ('dbo.Answer',RESEED, 0)
	delete from dbo.Question;
	DBCC CHECKIDENT ('dbo.Question',RESEED, 0)

	print 'Question and Answer tables truncated.';

	-- Begin inserting questions:

		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('How many soccer players should each team have on the field at the start of each match?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, '7', 0, @active),
					(@questionId, '8', 0, @active),
					(@questionId, '11', 1, @active),
					(@questionId, '14', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What sport was Jesse Owens involved in?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Boxing', 0, @active),
					(@questionId, 'Diving', 0, @active),
					(@questionId, 'Gymnastics', 0, @active),
					(@questionId, 'Track and field', 1, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('Who is often called the father of the computer?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Alan Turing', 0, @active),
					(@questionId, 'Blaise Pascal', 0, @active),
					(@questionId, 'Charles Babbage', 1, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What was Twitter’s original name?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Haikuu', 0, @active),
					(@questionId, 'Hashtag', 0, @active),
					(@questionId, 'twitter', 1, @active),
					(@questionId, 'Twitosphere', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What part of the atom has no electric charge?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);

			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Core', 0, @active),
					(@questionId, 'Electron', 0, @active),
					(@questionId, 'Neutron', 1, @active),
					(@questionId, 'Proton', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('Which natural disaster is measured with a Richter scale?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Earthquakes', 1, @active),
					(@questionId, 'ELE', 0, @active),
					(@questionId, 'Hurricanes', 0, @active),
					(@questionId, 'Tsunami', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('How many molecules of oxygen does ozone have?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, '1', 0, @active),
					(@questionId, '2', 0, @active),
					(@questionId, '3', 1, @active),
					(@questionId, '5', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('Who is often credited with creating the world’s first car?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Carroll Shelby', 0, @active),
					(@questionId, 'Henry Ford', 0, @active),
					(@questionId, 'Karl Benz', 1, @active),
					(@questionId, 'Mario Bros', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What or who is the Ford Mustang named after?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'A fighter plane from WWII', 1, @active),
					(@questionId, 'Henry Ford’s daughter', 0, @active),
					(@questionId, 'Wild horses in the Carolinas', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('In what year was the Corvette introduced?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, '1919', 0, @active),
					(@questionId, '1949', 0, @active),
					(@questionId, '1953', 1, @active),
					(@questionId, '1967', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What is the common name for dried plums?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Anjeer', 0, @active),
					(@questionId, 'Cashew', 0, @active),
					(@questionId, 'Prunes', 1, @active),
					(@questionId, 'Raisins', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What’s the primary ingredient in hummus?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Avocados', 0, @active),
					(@questionId, 'Chickpeas', 1, @active),
					(@questionId, 'Olive Oil', 0, @active),
					(@questionId, 'Salt', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What is your body’s largest organ?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Kidney', 0, @active),
					(@questionId, 'Lungs', 0, @active),
					(@questionId, 'Skin', 1, @active),
					(@questionId, 'Stomach', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('Which bone are babies born without?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Kneecap', 1, @active),
					(@questionId, 'Skull cap', 0, @active),
					(@questionId, 'Sternum', 0, @active),
					(@questionId, 'Tail bone', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('About how many taste buds does the average human tongue have?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, '500', 0, @active),
					(@questionId, '10,000', 1, @active),
					(@questionId, '150,000', 0, @active),
					(@questionId, '600,000', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('How many times does the heartbeat per day?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, '1,000', 0, @active),
					(@questionId, '25,000', 0, @active),
					(@questionId, '40,000', 0, @active),
					(@questionId, 'More than 100,000', 1, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What is the smallest country in the world?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Monaco', 0, @active),
					(@questionId, 'Nauru', 0, @active),
					(@questionId, 'Pandora', 0, @active),
					(@questionId, 'Vatican City', 1, @active);
		print 'inserted question ' + cast(@questionId as varchar);

		--
		insert into HighQuiz.dbo.Question (QuestionDescr, Active)
			values ('What is the name of the world’s longest river?', @active);

			select @questionId = IDENT_CURRENT(@questionTable);
			insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
				values 
					(@questionId, 'Amazon River', 0, @active),
					(@questionId, 'Mississippi River', 0, @active),
					(@questionId, 'Nile', 1, @active),
					(@questionId, 'Niagara Falls', 0, @active);
		print 'inserted question ' + cast(@questionId as varchar);


		-- Bogus Question with no answers... Just for testing error handling.
		-- insert into HighQuiz.dbo.Question (QuestionDescr, Active)
		-- values ('phoney', @active);

		-- ------------------------------------------------------------------------------
		-- Make sure there are no active questions without answers...
		-- ------------------------------------------------------------------------------
		declare @noAnswerQuestionsCount int;
		select @noAnswerQuestionsCount = count(*)
		from HighQuiz.dbo.Question q
			left outer join HighQuiz.dbo.Answer a
				on q.QuestionId = a.QuestionId
		where q.Active = 1
		group by q.QuestionId
		having count(a.AnswerId) = 0

		print cast(@noAnswerQuestionsCount as varchar) + ' qweqwe';
		if @noAnswerQuestionsCount > 0
		begin;
			select q.questionid, q.QuestionDescr, 'Missing Answers'
			from HighQuiz.dbo.Question q
				left outer join HighQuiz.dbo.Answer a
					on q.QuestionId = a.QuestionId
			where q.Active = 1
			group by q.QuestionId,  q.QuestionDescr
			having count(a.AnswerId) = 0;		
			throw 50001, 'There are questions with no answers', 1;
		end;

		-- ------------------------------------------------------------------------------
		-- Make sure there are no active questions without at least one correct answer...
		-- ------------------------------------------------------------------------------
		declare @correctAnswerQuestionsCount int;
		select @correctAnswerQuestionsCount = count(*)
		from HighQuiz.dbo.Question q
				left outer join HighQuiz.dbo.Answer a
					on q.QuestionId = a.QuestionId
					and a.IsCorrect = 1
			where q.Active = 1
			group by q.QuestionId
			having count(a.AnswerId) = 0;

		if @correctAnswerQuestionsCount > 0
		begin;
			select q.questionid, q.QuestionDescr, 'Missing a Correct Answer'
			from HighQuiz.dbo.Question q
				left outer join HighQuiz.dbo.Answer a
					on q.QuestionId = a.QuestionId
					and a.IsCorrect = 1
			where q.Active = 1
			group by q.QuestionId, q.QuestionDescr
			having count(a.AnswerId) = 0;
			throw 51000, 'There are questions missing a correct answer', 1;
		end;

		commit transaction LoadQuestionData;

		print 'Data Loaded successfully.'

end try
begin catch
  if (@@trancount > 0)
   begin
      rollback transaction LoadQuestionData;
      print 'Error detected, all changes reversed.'
   end 
    select
        error_number()		as ErrorNumber,
        error_severity()	as ErrorSeverity,
        error_state()		as ErrorState,
        error_procedure()	as ErrorProcedure,
        error_line()		as ErrorLine,
        error_message()		as ErrorMessage;
end catch

--select * from HighQuiz.dbo.Question 

/*
	-- Blank code if we need to insert more...

	insert into HighQuiz.dbo.Question (QuestionDescr, Active)
		values ('', @active);

		select @questionId = IDENT_CURRENT(@questionTable);
		insert into HighQuiz.dbo.Answer(QuestionId, AnswerDescr, IsCorrect, Active)
			values 
				(@questionId, '', 0, @active),
				(@questionId, '', 0, @active),
				(@questionId, '', 0, @active),
				(@questionId, '', 0, @active);
	print 'inserted question ' + cast(@questionId as varchar);

*/
