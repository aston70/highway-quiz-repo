Imports System.Data.SqlClient
Imports HighwayQuiz.DTO

Public Class UserDL
    Inherits BaseDL

    Public Function SaveUser(user As UserDTO) As UserDTO

        Dim sql = <string><![CDATA[
            insert into dbo.[User]
               (EmailAddress, FirstName, LastName, DateCreated)
             values
                   (@EmailAddress, @FirstName, @LastName, @DateCreated);
             select scope_identity();
        ]]></string>.Value

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()
            Using cmd As New SqlCommand(sql, conn)
                cmd.CommandType = CommandType.Text
                With cmd.Parameters
                    .AddWithValue("@EmailAddress", user.EmailAddress)
                    .AddWithValue("@FirstName", user.FirstName)
                    .AddWithValue("@LastName", user.LastName)
                    .AddWithValue("@DateCreated", Now)
                End With

                ' Get the inserted query
                user.UserId = Convert.ToInt32(cmd.ExecuteScalar())
                'cmd.ExecuteNonQuery()
            End Using
        End Using

        Return user

    End Function

    Public Function GetUSerByUserId(userId As Integer) As UserDTO

        Dim user As UserDTO = Nothing
        Dim sql = "select * from dbo.[User] where userId = @UserId;"

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()
            Using cmd As New SqlCommand(sql, conn)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@UserId", userId)

                Using dr As IDataReader = cmd.ExecuteReader()
                    If dr.Read Then
                        user = ReadUser(dr)
                    End If
                End Using

            End Using
        End Using

        Return user

    End Function

    Public Function GetUSerByEmailAddress(emailAddress As String) As UserDTO

        Dim user As UserDTO = Nothing
        Dim sql = "select * from dbo.[User] where EmailAddress = @EmailAddress"

        Using conn As New SqlConnection(GetConnectionString)
            conn.Open()
            Using cmd As New SqlCommand(sql, conn)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.Add(New SqlParameter("@EmailAddress", emailAddress))

                Using dr As IDataReader = cmd.ExecuteReader()
                    If dr.Read Then
                        user = ReadUser(dr)
                    End If
                End Using

            End Using
        End Using

        Return user

    End Function

    Private Function ReadUser(dr As IDataReader) As UserDTO

        Dim user As New UserDTO() With {
            .UserId = dr("UserId"),
            .EmailAddress = dr("EmailAddress"),
            .FirstName = dr("FirstName"),
            .LastName = dr("LastName")
        }

        Return user

    End Function

End Class
