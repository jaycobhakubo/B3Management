//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace GameTech.B3Reports
{
    class IsUserCurrentlyLockedDueToLoginAttempt
    {
        /// <summary>
        /// Get the current user's status for lock due to attempt login
        /// </summary>
        /// <returns>True or false if the user is currently locked due to attempt login.</returns>
        public static bool YesNo()
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool IsUserLocked = false;

            using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                    from dbo.B3_Login 
                    where UserName = @UserName and 
                     LockedDueToLoginFailedAttempt = 'T' ", sc))//Password is case sensitive
            {
                cmd.Parameters.AddWithValue("UserName", CurrentUserLogged.LoggedUser);
                IsUserLocked = (int)cmd.ExecuteScalar() == 1;
                //Having issue with case sensitivity 
            }
            sc.Close();
            return IsUserLocked;
        }
    }
}
