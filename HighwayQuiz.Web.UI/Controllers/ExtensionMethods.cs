using System.Web.Mvc;

namespace HighwayQuiz.Web.UI.Controllers
{
    public static class ExtensionMethods
    {
        /// <summary>
        /// Controller Extension Method for adding a session object.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="cont"></param>
        /// <param name="sessionName"></param>
        /// <param name="obj"></param>
        public static void AddSessionItem(this Controller cont, string sessionName, object obj)
        {
            cont.ControllerContext.HttpContext.Session[sessionName] = obj;
        }

        /// <summary>
        /// Controller Extension Method for returning a session object using Generics.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="cont"></param>
        /// <param name="sessionName"></param>
        /// <returns></returns>
        public static T GetSessionItem<T>(this Controller cont, string sessionName)
        {
            T sessionObject = (T)cont.ControllerContext.HttpContext.Session[sessionName];
            return sessionObject;
        }

    }
}