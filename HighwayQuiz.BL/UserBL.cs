using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HighwayQuiz.DL;
using HighwayQuiz.DTO;
using NLog;

namespace HighwayQuiz.BL
{
    public class UserBL
    {
        // NLog Logger object
        private static ILogger _log;

        // database access object
        UserDL dl;

        public UserBL(ILogger logService) {
            _log = logService;
            dl = new UserDL();
        }

        public UserDTO SaveUser(UserDTO user)
        {
            if (!EmailBL.IsValidEmailAddress(user.EmailAddress)) {
                throw new Exception("Can not save user. Email Address is not valid.");
            }
            else if (UserExists(user.EmailAddress))
            {
                //throw new Exception($"Can not save user. Email Address {user.EmailAddress} already exists");
                return GetUSerByEmailAddress(user.EmailAddress);
            }

            return dl.SaveUser(user);
        }

        public UserDTO GetUSerByUserId(int userId)
        {
            return dl.GetUSerByUserId(userId);
        }

        public UserDTO GetUSerByEmailAddress(string emailAddress)
        {
            return dl.GetUSerByEmailAddress(emailAddress);
        }

        public bool UserExists(string emailAddress)
        {
            return GetUSerByEmailAddress(emailAddress) != null;
        }

    }


}
