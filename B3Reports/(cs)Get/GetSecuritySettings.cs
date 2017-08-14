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
    class GetSecuritySettings
    {    
        //I use static so you coud access right away without running the access modifiers again
        public static int MinPasswordLength = 1;
        public static int PrevPasswordReuseN = 0;//0 means i can use it again and again and again
        public static int PrevPasswordLockoutAttempts = 1;
        public static int NPasswordsExpireDays = 1;
        public static int MaximumMachineLoginLimit = 0;
        public static bool UsePasswordComplexity = false;
        public static int LogoutInactivity = 0;

  
        //This will get the current setting in the DB
        public GetSecuritySettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_SystemSetting_b3_Security_Get", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        MinPasswordLength = reader.GetInt32(0);
                        PrevPasswordReuseN = reader.GetInt32(1);
                        PrevPasswordLockoutAttempts = reader.GetInt32(2);
                        NPasswordsExpireDays = reader.GetInt32(3);
                        MaximumMachineLoginLimit = reader.GetInt32(4);
                        UsePasswordComplexity = reader.GetBoolean(5);
                        LogoutInactivity = reader.GetInt32(6);
                    }
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
        }
    }
}
