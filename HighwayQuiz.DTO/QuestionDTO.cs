using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HighwayQuiz.DTO
{
    public class QuestionDTO
    {
        public int QuestionId { get; set; }
        public string QuestionDescr { get; set; }
        public bool Active { get; set; }

        public List<AnswerDTO> Answers { get; set; } = new List<AnswerDTO>();
    }
}