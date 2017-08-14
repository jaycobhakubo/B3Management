using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameTech.B3Reports
{
     class CurrentUserLogged
    {
         /// <summary>
         /// Hold value for LoggedUser.
         /// </summary>
        public static string LoggedUser;//lets try static to call directly

         /// <summary>
         /// Assign value to LoggedUser
         /// </summary>
         /// <param name="userlog"> The may or may not exists</param>
        public CurrentUserLogged(string userlog)
        {
            LoggedUser = userlog;
        }

    }
}
