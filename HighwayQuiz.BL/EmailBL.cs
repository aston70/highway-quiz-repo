using NLog;
using System;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace HighwayQuiz.BL
{
    public class EmailBL
    {
        // NLog Logger object
        private static ILogger _log;

        public EmailBL(ILogger logService) {
            _log = logService;
        }

        public static bool IsValidEmailAddress(string emailAddress)
        {
            try
            {
                Regex regex = new Regex(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$",
                RegexOptions.CultureInvariant | RegexOptions.Singleline);
                return regex.IsMatch(emailAddress);
            }
            catch
            {
                return false;
            }
        }


        /// <summary>
        /// Sends email.
        /// </summary>
        /// <param name="toAddress"></param>
        /// <param name="subject"></param>
        /// <param name="emailBody"></param>
        /// <param name="isBodyHtml"></param>
        /// <returns>true if email sent</returns>
        /// <remarks>
        /// https://stackoverflow.com/questions/18503333/the-smtp-server-requires-a-secure-connection-or-the-client-was-not-authenticated
        /// 
        /// Google may block sign in attempts from some apps or devices that do not use modern security standards.
        /// Since these apps and devices are easier to break into, blocking them helps keep your account safer.
        /// Some examples of apps that do not support the latest security standards include:
        /// The Mail app on your iPhone or iPad with iOS 6 or below
        /// The Mail app on your Windows phone preceding the 8.1 release
        /// Some Desktop mail clients like Microsoft Outlook and Mozilla Thunderbird
        /// Therefore, you have to enable Less Secure Sign-In(or Less secure app access) in your google account.
        /// After sign into google account, go to:
        /// https://www.google.com/settings/security/lesssecureapps
        /// or
        /// https://myaccount.google.com/lesssecureapps
        /// </remarks>
        public bool SendEmail(string toAddress, string subject, string emailBody, bool isBodyHtml = false)
        {
            bool sendEmailOn = Properties.Settings.Default.SendEmailOn;
            string fromEmail = Properties.Settings.Default.EmailFrom;
            string fromEmailPswd = Properties.Settings.Default.EmailPassword;
            string smtpHost = Properties.Settings.Default.SmtpHost;
            int smtpPort = Properties.Settings.Default.SmtpPort;

            // Sending email is turned off. Do nothing, just return false.
            if (!sendEmailOn) {
                _log.Log(LogLevel.Info, "Send Email is OFF.");
                return false;
            }

            if (string.IsNullOrEmpty(fromEmail) || string.IsNullOrEmpty(fromEmailPswd)) {
                throw new Exception("Email smtp service account not set up.");
            }
            if (string.IsNullOrEmpty(smtpHost) || smtpPort == 0)
            {
                throw new Exception("Email smtp host not set up.");
            }

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(fromEmail);
                mail.To.Add(toAddress);
                mail.Subject = subject;
                mail.Body = emailBody;
                mail.IsBodyHtml = isBodyHtml;

                using (SmtpClient smtp = new SmtpClient(smtpHost, smtpPort))
                {
                    smtp.Credentials = new NetworkCredential(fromEmail, fromEmailPswd);
                    smtp.EnableSsl = true;
                    try
                    {
                        smtp.Send(mail);
                    }
                    catch (Exception ex)
                    {
                        //Error
                        _log.Log(LogLevel.Error, ex);
                        return false;
                    }

                }

                return true;

            }

        }

    }
}