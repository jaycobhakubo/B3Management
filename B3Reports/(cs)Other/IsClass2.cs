
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
    class IsClass2
    {
        public static bool GetStatus(string B4Games, int GameNumber, DateTime? PlayTime)
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool isClass2 = false;

            using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckClass2(@B4Games, @GameNumber, @PlayTime)", sc))//Password is case sensitive
            {
                cmd.Parameters.AddWithValue("@B4Games", B4Games);//this is the currentSelectedUserLoginID
                cmd.Parameters.AddWithValue("@GameNumber", GameNumber);
                cmd.Parameters.AddWithValue("@PlayTime", PlayTime);
                isClass2 = Convert.ToBoolean(cmd.ExecuteScalar()); //(bool)cmd.ExecuteScalar();
            }

            sc.Close();
            return isClass2;
        }
    }
}
