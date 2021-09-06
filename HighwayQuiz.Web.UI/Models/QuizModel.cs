using HighwayQuiz.DTO;

namespace HighwayQuiz.Web.UI.Models
{
    public class QuizModel
    {
        public QuizModel(QuizDTO quiz) {
            Quiz = quiz;
        }

        public QuizDTO Quiz { get; set; }
    }
}