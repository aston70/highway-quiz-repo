using HighwayQuiz.BL;
using HighwayQuiz.DTO;
using HighwayQuiz.Web.UI.Models;
using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace HighwayQuiz.Web.UI.Controllers
{
    public class QuizController : Controller
    {
        // NLog Logger object
        private ILogger _log = LogManager.GetCurrentClassLogger();

        UserBL userBL;
        QuizBL quizBL;

        public QuizController()
        {
            userBL = new UserBL(_log);
            quizBL = new QuizBL(_log);
        }

        // GET: Quiz
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Take in user information, create a quiz and return to user.
        /// </summary>
        /// <param name="emailAddress"></param>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Quiz(string emailAddress, string firstName, string lastName)
        {

            try
            {
                UserDTO user = new UserDTO()
                {
                    EmailAddress = emailAddress,
                    FirstName = firstName,
                    LastName = lastName
                };
                TempData["User"] = user;

                // If email address is invalid...
                if (!EmailBL.IsValidEmailAddress(emailAddress))
                {
                    TempData["ErrorMessage"] = "Email Address is invalid.";
                    return RedirectToAction("Index", "Home");
                }
                // If name is empty...
                if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName))
                {
                    TempData["ErrorMessage"] = "Enter name";
                    return RedirectToAction("Index", "Home");
                }

                user = userBL.SaveUser(user);

                // Make sure if we've not taken a quiz already... 
                if (quizBL.HasUserTakeQuiz(user)) {
                    TempData["ErrorMessage"] = "You have already taken this quiz. Thank You!";
                    return RedirectToAction("Index", "Home");
                }

                // --------------------------------------------------------------------------
                // Get a new quiz for this user. Put it in the current session and return it 
                // to the view.
                // Note: the object contains the correct answer information. We need to make
                // sure this data does not make it into the form. This is why I'm putting 
                // into the session object.
                // --------------------------------------------------------------------------
                QuizDTO quiz = quizBL.GetQuiz(user);
                this.AddSessionItem("Quiz", quiz);

                ViewBag.Message = new QuizModel(quiz);

                return View();
            }
            catch (Exception ex)
            {
                _log.Log(LogLevel.Error, ex);
                return RedirectToAction("Error", "Home");
            }

        }

        [HttpPost]
        public ActionResult CompleteQuiz(FormCollection form)
        {

            try
            {

                // --------------------------------------------------------------------------
                // Pull the user's quiz back out of session, loop through all the questions
                // and apply the selected responses from the form object.
                // --------------------------------------------------------------------------
                QuizDTO quiz = this.GetSessionItem<QuizDTO>("Quiz");
                quiz.Details = new List<QuizDetail>();
                foreach (QuestionDTO question in quiz.Questions)
                {

                    // Get the Question Number. This is the number of the question as it was
                    // presented to the user. It is not the ID.
                    int questionNumber = Convert.ToInt32(form[$"hdn_questionNumber{question.QuestionId}"]);

                    // Get the correct answer to this question...
                    AnswerDTO correctAnswer = question.Answers.Where(a => a.IsCorrect).FirstOrDefault();

                    // Get the selected answer to this question...
                    AnswerDTO selectedAnswer =
                        question.Answers.Where(
                            a => a.AnswerId == Convert.ToInt32(form[$"opt_answer_for_question{question.QuestionId}"])
                        ).FirstOrDefault();

                    // Save these details to the object...
                    quiz.Details.Add(
                        new QuizDetail(question, questionNumber, correctAnswer, selectedAnswer));
                }

                // --------------------------------------------------------------------------
                // Score the Quiz.
                // --------------------------------------------------------------------------
                quiz = quizBL.ScoreQuiz(quiz);

                // --------------------------------------------------------------------------
                // Save the Quiz.
                // --------------------------------------------------------------------------
                quiz = quizBL.SaveQuiz(quiz);

                // --------------------------------------------------------------------------
                // Email the Quiz.
                // --------------------------------------------------------------------------
                quiz = quizBL.EmailQuiz(quiz);

                ViewBag.Message = new QuizModel(quiz);
                return View();

            }
            catch (Exception ex)
            {
                _log.Log(LogLevel.Error, ex);
                return RedirectToAction("Error", "Home");
            }

        }

    }
}