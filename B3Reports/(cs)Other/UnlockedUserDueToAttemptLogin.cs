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
    class UnlockedUserDueToAttemptLogin
    {
        /// <summary>
        /// Unlock this user's if it is already passed 30 minutesfrom the time he was locked out.
        /// The time for how long the user is unlock is hardcoded on the sqlSP script.
        /// </summary>
        /// <param name="LoginID">User's LoginID</param>
        /// <returns>Returns true if the time from being locked is equal or greater than 30 min else return false</returns>
        public static bool YesNo(int LoginID)
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool IsUserUnlock = false;

            using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnAutoUnlockUser(@LoginID)", sc))
                {
                    cmd.Parameters.AddWithValue("LoginID", LoginID);//this is the currentSelectedUserLoginID
                    IsUserUnlock = Convert.ToBoolean(cmd.ExecuteScalar()); //(bool)cmd.ExecuteScalar();
                }

            sc.Close();
            return IsUserUnlock;
        }
    }
}
