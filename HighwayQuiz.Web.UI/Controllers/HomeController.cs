using HighwayQuiz.BL;
using NLog;
using System.Web.Mvc;

namespace HighwayQuiz.Web.UI.Controllers
{
    public class HomeController : Controller
    {
        // NLog Logger object
        private ILogger _log = LogManager.GetCurrentClassLogger();

        UserBL userBL;
        QuizBL quizBL;

        public HomeController() {
            userBL = new UserBL(_log);
            quizBL = new QuizBL(_log);
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Error(string message)
        {
            ViewBag.Message = message;
            return View();
        }

    }
}