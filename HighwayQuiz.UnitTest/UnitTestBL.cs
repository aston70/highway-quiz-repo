using HighwayQuiz.BL;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace HighwayQuiz.UnitTest
{

    /// <summary>
    /// Verify email address validation.
    /// </summary>
    [TestClass]
    public class UnitTestBL
    {

        [TestMethod]
        public void EmailValidation()
        {

            // Arrange
            string emailAddressGood1 = "test@gmail.com";
            string emailAddressBad1 = "";
            string emailAddressBad2 = "@gmail.com";
            string emailAddressBad3 = "test@gmail";

            // Act
            bool goodEmailCheck1 = EmailBL.IsValidEmailAddress(emailAddressGood1);
            bool badEmailCheck1 = EmailBL.IsValidEmailAddress(emailAddressBad1);
            bool badEmailCheck2 = EmailBL.IsValidEmailAddress(emailAddressBad2);
            bool badEmailCheck3 = EmailBL.IsValidEmailAddress(emailAddressBad3);

            // Assert
            Assert.IsTrue(goodEmailCheck1);
            Assert.IsFalse(badEmailCheck1);
            Assert.IsFalse(badEmailCheck2);
            Assert.IsFalse(badEmailCheck3);

        }

    }
}
