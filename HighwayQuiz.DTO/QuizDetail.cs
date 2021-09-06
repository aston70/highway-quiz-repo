using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HighwayQuiz.DTO
{
    public class QuizDetail
    {
		public QuizDetail() { }

		public QuizDetail(QuestionDTO question, int questionNumber, AnswerDTO correctAnswer, AnswerDTO selectedAnswer) {
			this.OrigQuestionId = question.QuestionId;
			this.OrigQuestionDescr = question.QuestionDescr;
			this.QuestionNumber = questionNumber;
			this.CorrectAnswerId = correctAnswer.AnswerId;
			this.CorrectAnswerDescr = correctAnswer.AnswerDescr;
			this.SelectedAnswerId = selectedAnswer.AnswerId;
			this.SelectedAnswerDescr = selectedAnswer.AnswerDescr;
		}

		public int QuizDetailId { get; set; }

		public int QuizId { get; set; }

		public int QuestionNumber { get; set; }
		public int OrigQuestionId { get; set; }
		public string OrigQuestionDescr { get; set; }
		public int SelectedAnswerId { get; set; }
		public string SelectedAnswerDescr { get; set; }
		public int CorrectAnswerId { get; set; }
		public string CorrectAnswerDescr { get; set; }

	}
}
