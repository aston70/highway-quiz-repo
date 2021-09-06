using System.IO;
using System.Xml.Serialization;

namespace HighwayQuiz.DTO
{
    public static class ExtensionMethods
    {

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Serialize a DTO or a List(Of DTO) to an XML string.
        /// </summary>
        /// -----------------------------------------------------------------------------
        /// <typeparam name="T">Type of Class to Serialize</typeparam>
        /// <param name="obj">DTO or List(Of DTO) to Serialize to XML</param>
        /// -----------------------------------------------------------------------------
        /// <returns>String - XML</returns>
        /// -----------------------------------------------------------------------------
        /// <remarks>Works with any Serializable DTO or List(Of Serializable DTO)</remarks>
        /// -----------------------------------------------------------------------------
        public static string SerializedXml<T>(this T obj)
        {
            StringWriter writer = new StringWriter();
            XmlSerializer serializer = new XmlSerializer(obj.GetType());

            try
            {
                if (obj != null)
                {
                    using ((writer))
                    {
                        serializer.Serialize(writer, obj);
                        return writer.ToString();
                    }
                }
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }

    }
}
