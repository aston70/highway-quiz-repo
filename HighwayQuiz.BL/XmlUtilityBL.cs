namespace HighwayQuiz.BL
{
    public class XmlUtilityBL
    {

        /// <summary>
        /// Validates string value to be valid XML data
        /// </summary>
        /// <param name="outerXML">Self explainatory</param>
        /// <returns>True/False</returns>
        /// <remarks></remarks>
        public static bool IsValidXML(string outerXML)
        {
            try
            {
                System.Xml.Linq.XDocument.Parse(outerXML);
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}
