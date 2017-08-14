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
    class SetSecuritySettings
    {

        public SetSecuritySettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_SystemSetting_b3_Security_Set 
                                                        @MinPassword ,
                                                        @PrevPasswordReuse ,
                                                        @PasswordLockedAttmp,
                                                        @NPasswordDaysExp ,
                                                        @MaximumMachineLoginLimit ,
                                                        @UsePasswordComplexity ,
                                                        @LogoutInactivity", sc))
                {
                    cmd.Parameters.AddWithValue("MinPassword", GetSecuritySettings.MinPasswordLength);
                    cmd.Parameters.AddWithValue("PrevPasswordReuse", GetSecuritySettings.PrevPasswordReuseN);
                    cmd.Parameters.AddWithValue("PasswordLockedAttmp", GetSecuritySettings.PrevPasswordLockoutAttempts);
                    cmd.Parameters.AddWithValue("NPasswordDaysExp", GetSecuritySettings.NPasswordsExpireDays);
                    cmd.Parameters.AddWithValue("MaximumMachineLoginLimit", GetSecuritySettings.MaximumMachineLoginLimit);
                    cmd.Parameters.AddWithValue("UsePasswordComplexity", GetSecuritySettings.UsePasswordComplexity);
                    cmd.Parameters.AddWithValue("LogoutInactivity", GetSecuritySettings.LogoutInactivity);
                    cmd.ExecuteNonQuery(); //or you could try this if did not work                 
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
