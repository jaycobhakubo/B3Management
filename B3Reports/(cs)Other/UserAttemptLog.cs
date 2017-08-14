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

    public class Userlog
    {
        public string username;
        public int NlogAttempt;
        public int TimeInterval;
        public bool IsLockedDueToFailedAttempt;
        public int TTimeInterval;
        public int Rank;
    }

    /// <summary>
    /// Store information for users attempting to logged in.
    /// </summary>
    public class UserLogList
    {
        public static List<Userlog> useloglist = new List<Userlog>();
    }

    public class GetPendingUserUnlock //UserAttemptLog
    {
        
        SqlConnection sc = GetSQLConnection.get();
        public List<Userlog> GetPendingUserUnlockNow()
        {
            UserLogList.useloglist.Clear();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select UserName, from [dbo].[B3_Login] where LockedDueToLoginFailedAttempt  = 'T' order by LockedDueToAttemptTime asc", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Userlog usersingledata = new Userlog();
                        usersingledata.username = reader.GetString(0);
                        usersingledata.TimeInterval = Convert.ToInt32(reader.GetDateTime(1).Subtract(DateTime.Now).TotalSeconds);//Well investigate this one

                        //let us get the first timeinterval

                        //UserLogList.useloglist.Add(usersingledata);


                    }
                }
                sc.Close();

                // return userList.Userlist;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return UserLogList.useloglist;
        }
    }
}
