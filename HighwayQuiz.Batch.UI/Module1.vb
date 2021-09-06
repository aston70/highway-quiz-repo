Imports HighwayQuiz.DTO
Imports HighwayQuiz.BL
Imports NLog
Imports System.Reflection

Module Module1

    ' NLog Logger object
    Private _log As ILogger = LogManager.GetCurrentClassLogger()

    Sub Main()

        ' This is just a console app for testing the back end.

        Try

            _log.Trace(vbCrLf &
                "-----------------------------------------------------------------------------" & vbCrLf &
                "Starting App... " & vbCrLf &
                Assembly.GetExecutingAssembly().FullName & vbCrLf &
                "-----------------------------------------------------------------------------")

            ' CreateUser()
            ' GetQuiz()
            ' SendEmail()
            ' CheckEmailAddresses()
            HasUserTakeQuiz()

        Catch ex As Exception
            _log.Log(LogLevel.Error, ex)
        End Try

    End Sub

    Private Sub CreateUser()

        Dim user As New UserDTO() With {
            .FirstName = "Danny",
            .LastName = "Smith",
            .EmailAddress = "kf4gdn@gmail.com"
        }

        Dim result = New UserBL(_log).SaveUser(user)

    End Sub

    Private Sub GetQuiz()

        Dim user = New UserBL(_log).GetUSerByEmailAddress("kf4gdn@gmail.com")

        Dim quiz = New QuizBL(_log).GetQuiz(user)

    End Sub

    Private Sub SendEmail()

        Dim bl As New EmailBL(_log)

        bl.SendEmail("kf4gdn@gmail.com", "This is a test", "This is only a test...")

    End Sub

    Private Sub CheckEmailAddresses()

        Dim blCheck As Boolean

        blCheck = EmailBL.IsValidEmailAddress("kf4gdn@gmail.com")
        blCheck = EmailBL.IsValidEmailAddress("kf4gdn@gmail")
        blCheck = EmailBL.IsValidEmailAddress("kf4gdn.com")

    End Sub

    Private Sub HasUserTakeQuiz()

        Dim userBl = New UserBL(_log)
        Dim quizBl = New QuizBL(_log)

        Dim check = quizBl.HasUserTakeQuiz(
            userBl.GetUSerByEmailAddress("kf4gdn@gmail.com"))

    End Sub

End Module
