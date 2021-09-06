using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Xml.Serialization;

namespace HighwayQuiz.DTO
{
    public class QuizDTO
    {

        public QuizDTO() { }

        public QuizDTO(UserDTO user) {
            User = user;
        }

        public UserDTO User { get; set; }

        const string DATE_FMT = "MM/dd/yyyy hh:mm tt";

        // Quiz Header Data
        public int QuizId { get; set; }
        public Decimal Score { get; set; }

        [XmlIgnore] 
        public char Grade { get; set; }

        [XmlElement("Grade"), Browsable(false)]
        public string GradeString
        {
            get { return Grade.ToString(); }
            set { Grade = value.Single(); }
        }

        [XmlIgnore]
        public DateTime DateStarted { get; set; }

        [XmlElement("DateStarted"), Browsable(false)]
        public string DateStartedFormatted
        { 
            get { return DateStarted.ToString(DATE_FMT); }
            set { } 
        }

        [XmlIgnore]
        public DateTime DateCompleted { get; set; }

        [XmlElement("DateCompleted"), Browsable(false)]
        public string DateCompletedFormatted
        {
            get { return DateCompleted.ToString(DATE_FMT); }
            set { }
        }

        public List<QuestionDTO> Questions { get; set; } = new List<QuestionDTO>();

        public List<QuizDetail> Details { get; set; } = new List<QuizDetail>();
        public bool EmailSent { get; set; }
    }
}