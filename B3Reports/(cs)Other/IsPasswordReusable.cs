
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
    class IsPasswordReusable
    {
        public static bool IsPasswordReusable_(int LoginID, string password)
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool IsPasswordReusable = false;

            using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckReusepassword(@LoginID, @Password)", sc))//Password is case sensitive
            {            
                cmd.Parameters.AddWithValue("LoginID",  LoginID );//this is the currentSelectedUserLoginID
                cmd.Parameters.AddWithValue("Password", password);
                IsPasswordReusable = Convert.ToBoolean(cmd.ExecuteScalar()); //(bool)cmd.ExecuteScalar();
                //Having issue with case sensitivity 
            }




            sc.Close();
            return IsPasswordReusable;
        }

    }
}
