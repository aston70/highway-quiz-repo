using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HighwayQuiz.DL;
using HighwayQuiz.DTO;
using NLog;
using System.IO;

namespace HighwayQuiz.BL
{
    public class QuizBL
    {
        // NLog Logger object
        private static ILogger _log;

        // database access object
        QuizDL dl;

        public QuizBL(ILogger logService)
        {
            _log = logService;
            dl = new QuizDL();
        }

        /// <summary>
        /// Get a new quiz object for user.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public QuizDTO GetQuiz(UserDTO user) {

            // --------------------------------------------------------------------------
            // Get the quiz data from the database.
            // Set start date and time.
            // --------------------------------------------------------------------------
            QuizDTO quiz = dl.GetNewQuiz(user);
            quiz.DateStarted = DateTime.Now;
            
            return quiz;
        }

        /// <summary>
        /// Score the quiz. Returned quiz should now have a Score and a Grade.
        /// </summary>
        /// <param name="quiz"></param>
        /// <returns></returns>
        public QuizDTO ScoreQuiz(QuizDTO quiz) {

            // --------------------------------------------------------------------------
            // Set stop date and time.
            // --------------------------------------------------------------------------
            quiz.DateCompleted = DateTime.Now;

            // --------------------------------------------------------------------------
            // Count the number of correctly answered questions and divide that by the 
            // total number of questions.
            // Result will be the quiz score.
            // --------------------------------------------------------------------------
            int correctCount = quiz.Details.
                Where(x => x.SelectedAnswerId == x.CorrectAnswerId).Count();
            int questionCount = quiz.Details.Count();
            quiz.Score = (decimal)((decimal)correctCount / (decimal)questionCount) * 100;

            // --------------------------------------------------------------------------
            // Assign a grade based on score.
            // --------------------------------------------------------------------------
            quiz.Grade = GetLetterGrade(quiz.Score);
 
            return quiz;

        }

        /// <summary>
        /// Save the quiz to the database. Returned quiz should now have a QuizId.
        /// </summary>
        /// <param name="quiz"></param>
        /// <returns></returns>
        public QuizDTO SaveQuiz(QuizDTO quiz)
        {
            return dl.SaveQuiz(quiz);
        }

        public QuizDTO EmailQuiz(QuizDTO quiz) {

            EmailBL emailBL = new EmailBL(_log);

            string emailSubject = $"Highway Quiz results for {quiz.User.FirstName} {quiz.User.LastName}";
            string emailBody = XslTransformBL.Transform(quiz.SerializedXml(),
                                    Path.Combine(UtilityBL.BasePath, @"xslt\QuizEmailBody.xslt"));

            // For debugging, Write out the email body...
            //File.WriteAllText(@"C:\temp\quizEmailBody.html", emailBody);

            // Send the email
            quiz.EmailSent = emailBL.SendEmail(quiz.User.EmailAddress, emailSubject, emailBody, isBodyHtml:true);

            return quiz;
        }

        public bool HasUserTakeQuiz(UserDTO user) {
            return dl.HasUserTakeQuiz(user);        
        }

        private char GetLetterGrade(decimal score)
        {
            if (score >= 90.0m)
            {
                return 'A';
            }
            else if (score >= 80.0m)
            {
                return 'B';
            }
            else if (score >= 70.0m)
            {
                return 'C';
            }
            else if (score >= 60.0m)
            {
                return 'D';
            }
            else
            {
                return 'F';
            }
        }

    }

}
