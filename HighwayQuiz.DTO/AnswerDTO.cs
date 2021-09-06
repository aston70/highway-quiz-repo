using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HighwayQuiz.DTO
{
    public class AnswerDTO
    {
        public int AnswerId { get; set; }
        public int QuestionId { get; set; }
        public string AnswerDescr { get; set; }
        public bool IsCorrect { get; set; }
        public bool Active { get; set; }
    }
}
