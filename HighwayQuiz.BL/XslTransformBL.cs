using System;
using System.Xml;
using System.Xml.Xsl;

namespace HighwayQuiz.BL
{

    public class XslTransformBL
    {

        /// =============================================================================
        ///  <summary>
        ///  Transform Xml given an Xml string and an XsltDocument file path.
        ///  </summary>
        ///  ============================================================================
        ///  <param name="xml">Xml</param>
        ///  <param name="xsltPath">Path to an Xslt File</param>
        ///  ----------------------------------------------------------------------------
        ///  <returns>String</returns>
        ///  ----------------------------------------------------------------------------
        ///  <remarks>Typically used to transform Xml into Html, but output depends upon 
        ///  the Xslt Document.</remarks>
        ///  ----------------------------------------------------------------------------
        public static string Transform(string xml, string xsltPath)
        {
            if (!XmlUtilityBL.IsValidXML(xml))
                throw new Exception("Transform failed. Invalid XML data: " + xml);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xml);           

            return Transform(xmlDoc, xsltPath);
        }



        /// =============================================================================
        ///  <summary>
        ///  Transform Xml given an XmlDocument and an XsltDocument file path.
        ///  </summary>
        ///  ============================================================================
        ///  <param name="xml">Xml</param>
        ///  <param name="xsltPath">Path to an Xslt File</param>
        ///  ----------------------------------------------------------------------------
        ///  <returns>String</returns>
        ///  ----------------------------------------------------------------------------
        ///  <remarks>Typically used to transform Xml into Html, but output depends upon 
        ///  the Xslt Document.</remarks>
        ///  ----------------------------------------------------------------------------
        public static string Transform(XmlDocument xmlDoc, string xsltPath)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            System.IO.StringWriter writer = new System.IO.StringWriter();
            XsltArgumentList args = new XsltArgumentList();
            xslt.Load(xsltPath);
            xslt.Transform(xmlDoc, args, writer);
            return writer.ToString();
        }

    }

}