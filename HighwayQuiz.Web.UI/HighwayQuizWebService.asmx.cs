using HighwayQuiz.BL;
using Newtonsoft.Json;
using System.Web.Services;

namespace HighwayQuiz.Web.UI
{
    /// <summary>
    /// Summary description for HighwayQuizWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]

    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]

    public class HighwayQuizWebService : System.Web.Services.WebService
    {

        [WebMethod]
        public void IsValidEmailAddress(string emailAddress)
        {
            var response = EmailBL.IsValidEmailAddress(emailAddress);
            Context.Response.Write(JsonConvert.SerializeObject(response));
        }

    }

}
