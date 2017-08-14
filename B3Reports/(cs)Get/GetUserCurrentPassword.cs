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
    class UserCurrentPassword
    {
        public static string UserPassword = ""; 
        public string Get()
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            try
            {
                using (SqlCommand cmd = new SqlCommand(@"select UserPassword from dbo.B3_Login where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", CurrentUserLogged.LoggedUser);
                    UserPassword = cmd.ExecuteScalar().ToString(); 
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

            return UserPassword;
        }
    }
}
