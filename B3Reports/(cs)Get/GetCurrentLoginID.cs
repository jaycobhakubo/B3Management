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
    
    public class CurrentLoginID
    {
        /// <summary>
        /// Hold value for current loginID.
        /// </summary>
        public static int LoginID;

        /// <summary>
        /// Get the current user's loginID
        /// Assign value for LoginID
        /// </summary>
        /// <returns>LoginID</returns>
        public int Get()
        {
            int loginID = 0;
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            try
            {
                using (SqlCommand cmd = new SqlCommand(@"select LoginID from dbo.B3_Login where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", CurrentUserLogged.LoggedUser);
                    loginID = (int)cmd.ExecuteScalar();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sc.Close();
            }

            LoginID = loginID; //OR 
            
            return loginID; //OR 
        }

    }

    public class GetCurrentIDPerUser
    {    /// <summary>
        /// Hold value for current loginID.
        /// </summary>
        public static int LoginID;

        /// <summary>
        /// Get the current user's loginID
        /// Assign value for LoginID
        /// </summary>
        /// <returns>LoginID</returns>
        public int Get(string username)
        {
            int loginID = 0;
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            try
            {
                using (SqlCommand cmd = new SqlCommand(@"select LoginID from dbo.B3_Login where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", username);
                    loginID = (int)cmd.ExecuteScalar();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sc.Close();
            }
            LoginID = loginID; //OR 
            return loginID; //OR 
        }
    }


}
