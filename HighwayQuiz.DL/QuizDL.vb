Imports System.Data.SqlClient
Imports HighwayQuiz.DTO

Public Class QuizDL
    Inherits BaseDL

    Public Function GetNewQuiz(user As UserDTO) As QuizDTO

        Dim quiz As New QuizDTO(user)

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()

            ' Get 10 random questions from the question pool.
            Dim sql_q = <string><![CDATA[
                select top 10 
	                QuestionId, QuestionDescr, Active
                from dbo.Question
                where Active = 1
                order by newid()
            ]]></string>.Value

            Using cmd As New SqlCommand(sql_q, conn)
                cmd.CommandType = CommandType.Text
                Using dr As IDataReader = cmd.ExecuteReader()
                    While dr.Read
                        quiz.Questions.Add(ReadQuestion(dr))
                    End While
                End Using
            End Using

            ' Get the answers for each question
            For Each question In quiz.Questions
                Dim sql_a = <string><![CDATA[
                  select AnswerId, QuestionId, AnswerDescr, IsCorrect, Active
                  from dbo.Answer
                  where QuestionId = @QuestionId and Active=1
                  order by newid()
                ]]></string>.Value

                Using cmd As New SqlCommand(sql_a, conn)
                    cmd.CommandType = CommandType.Text
                    cmd.Parameters.Add(New SqlParameter("@QuestionId", question.QuestionId))
                    Using dr As IDataReader = cmd.ExecuteReader()
                        While dr.Read
                            question.Answers.Add(ReadAnswer(dr))
                        End While
                    End Using
                End Using

            Next

        End Using

        Return quiz

    End Function

    Public Function SaveQuiz(quiz As QuizDTO) As QuizDTO

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()

            Dim trans = conn.BeginTransaction("StoreForceTransaction")

            Try
                ' Save Quiz record...
                Using cmd As New SqlCommand("dbo.hq_saveQuiz", conn, trans)
                    cmd.CommandType = CommandType.StoredProcedure

                    With cmd.Parameters
                        .AddWithValue("@userId", quiz.User.UserId)
                        .AddWithValue("@score", quiz.Score)
                        .AddWithValue("@grade", quiz.Grade)
                        .AddWithValue("@dateStarted", quiz.DateStarted)
                        .AddWithValue("@dateCompleted", quiz.DateCompleted)
                        .Add(New SqlParameter("@quizId", 0))
                    End With
                    cmd.Parameters("@quizId").Direction = ParameterDirection.Output

                    cmd.ExecuteNonQuery()
                    quiz.QuizId = Convert.ToInt32(cmd.Parameters("@quizId").Value)
                End Using

                ' Save Quiz Detail records...
                For Each detail In quiz.Details
                    Using cmd As New SqlCommand("dbo.hq_saveQuizDetail", conn, trans)
                        cmd.CommandType = CommandType.StoredProcedure

                        With cmd.Parameters
                            .AddWithValue("@quizId", quiz.QuizId)
                            .AddWithValue("@questionNumber", detail.QuestionNumber)
                            .AddWithValue("@origQuestionId", detail.OrigQuestionId)
                            .AddWithValue("@origQuestionDescr", detail.OrigQuestionDescr)
                            .AddWithValue("@selectedAnswerId", detail.SelectedAnswerId)
                            .AddWithValue("@selectedAnswerDescr", detail.SelectedAnswerDescr)
                            .AddWithValue("@correctAnswerId", detail.CorrectAnswerId)
                            .AddWithValue("@correctAnswerDescr", detail.CorrectAnswerDescr)
                            .Add(New SqlParameter("@quizDetailId", 0))
                        End With
                        cmd.Parameters("@quizDetailId").Direction = ParameterDirection.Output

                        cmd.ExecuteNonQuery()
                        detail.QuizDetailId = Convert.ToInt32(cmd.Parameters("@quizDetailId").Value)
                    End Using
                Next

                trans.Commit()

            Catch ex As Exception
                trans.Rollback()
                Throw ex
            End Try

        End Using

        Return quiz

    End Function

    ''' <summary>
    ''' Return true if user has taken a quiz.
    ''' </summary>
    ''' <param name="user"></param>
    ''' <returns></returns>
    Public Function HasUserTakeQuiz(user As UserDTO) As Boolean

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()

            Dim sql_q = <string><![CDATA[
                select count(*) as quizCount
                from dbo.UserQuiz uq
	                inner join dbo.[User] u
		                on uq.UserId = u.UserId
                where u.EmailAddress = @emailAddress
            ]]></string>.Value

            Using cmd As New SqlCommand(sql_q, conn)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@emailAddress", user.EmailAddress)
                Return Convert.ToInt32(cmd.ExecuteScalar()) > 0
            End Using

        End Using
        Return True

    End Function

#Region "DataReader"

    ''' <summary>
    ''' Reads Question from DataReader
    ''' </summary>
    ''' <param name="dr"></param>
    ''' <returns></returns>
    Private Function ReadQuestion(dr As IDataReader) As QuestionDTO

        Dim question As New QuestionDTO() With {
            .QuestionId = dr("QuestionId"),
            .QuestionDescr = dr("QuestionDescr"),
            .Active = dr("Active")
        }

        Return question

    End Function

    ''' <summary>
    ''' Reads Answer from DataReader
    ''' </summary>
    ''' <param name="dr"></param>
    ''' <returns></returns>
    Private Function ReadAnswer(dr As IDataReader) As AnswerDTO

        Dim answer As New AnswerDTO() With {
            .AnswerId = dr("AnswerId"),
            .QuestionId = dr("QuestionId"),
            .AnswerDescr = dr("AnswerDescr"),
            .IsCorrect = dr("IsCorrect"),
            .Active = dr("Active")
        }

        Return answer

    End Function

#End Region

End Class
