
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
    class IsPasswordCorrect
    {
        public static bool IsPasswordCorrect_(string password)
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool IsPasswordCorrect = false;
   
                using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                    from dbo.B3_Login 
                    where UserName = @UserName and 
                    [UserPassword] COLLATE SQL_Latin1_General_CP1_CS_AS = @UserPassword", sc))//Password is case sensitive
                {
                    cmd.Parameters.AddWithValue("UserName", CurrentUserLogged.LoggedUser );
                    cmd.Parameters.AddWithValue("UserPassword", password);
                    IsPasswordCorrect = (int)cmd.ExecuteScalar() == 1;
                    //Having issue with case sensitivity 
                }

          


            sc.Close();
            return IsPasswordCorrect;
        }

    }
}
