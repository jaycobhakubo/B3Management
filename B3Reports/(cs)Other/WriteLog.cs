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
    public class WriteLog
    {
               //WriteLog.WriteLog_("", userName, "Login successfull");

        public static void WriteLog_( string userName, string CurrentUserLogIn, string action, string MacAddress, string settings)
        {
            SqlConnection sc = GetSQLConnection.get();
            //Lets record this on auditlog table
            sc.Open();

            if (string.IsNullOrEmpty(CurrentUserLogIn) == false)
            {
                SqlCommand cmd = new SqlCommand("exec usp_config_b3_security_writeLog  @CurrentUserLogin = @CurrentUserLogin_ , @Action = '" + action + "', @MacAddress = '" + MacAddress + "',  @UserName = @User_Name", sc);
                cmd.Parameters.AddWithValue("CurrentUserLogin_", CurrentUserLogIn);
                cmd.Parameters.AddWithValue("User_Name", userName);
                cmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("exec usp_config_b3_security_writeLog  @CurrentUserLogin = @CurrentUserLogin_ , @Action = '" + action + "', @MacAddress = '" + MacAddress + "'", sc);
                cmd.Parameters.AddWithValue("CurrentUserLogin_", CurrentUserLogIn);
                cmd.ExecuteNonQuery();
            }
      
            

            
            sc.Close();

        }

        public static void WriteLogUpdate(string userName, string CurrentUserLogIn, string action, string MacAddress, string settings, string OldValue, string NewValue)
        {
            SqlConnection sc = GetSQLConnection.get();
            //Lets record this on auditlog table
            sc.Open();


            if (string.IsNullOrEmpty(CurrentUserLogIn) == false)
            {
                SqlCommand cmd = new SqlCommand
                (@"exec usp_config_b3_security_writeLog  
                    @CurrentUserLogin = @CurrentUserLogin_ , @Action = '" + action +  "', @OldPassword = '" + OldValue + "', @NewPassword = '" + NewValue + "', @MacAddress = '" + MacAddress + "', @Settings = '" + settings + "'" , sc);
                cmd.Parameters.AddWithValue("CurrentUserLogin_", CurrentUserLogIn);
                //cmd.Parameters.AddWithValue("User_Name", userName);
                cmd.ExecuteNonQuery();
            }
            sc.Close();

        }

        public static void WriteLogWithUserName(string userName, string CurrentUserLogIn, string action, string MacAddress, string settings, string OldValue, string NewValue)
        {
            SqlConnection sc = GetSQLConnection.get();
            //Lets record this on auditlog table
            sc.Open();


            if (string.IsNullOrEmpty(CurrentUserLogIn) == false)
            {
                SqlCommand cmd = new SqlCommand
                (@"exec usp_config_b3_security_writeLog  
                    @CurrentUserLogin = @CurrentUserLogin_ , @Action = '" + action + "', @OldPassword = '" + OldValue + "', @NewPassword = '" + NewValue + "', @MacAddress = '" + MacAddress + "', @UserName = @User_Name , @Settings = '" + settings + "'", sc);
                cmd.Parameters.AddWithValue("CurrentUserLogin_", CurrentUserLogIn);
                cmd.Parameters.AddWithValue("User_Name", userName);
                cmd.ExecuteNonQuery();
            }
            sc.Close();

        }

        public static void WriteLogWithUMacAddress(string MacAddressChanged, string CurrentUserLogIn, string action, string MacAddress, string settings, string OldValue, string NewValue)
        {
            SqlConnection sc = GetSQLConnection.get();
            //Lets record this on auditlog table
            sc.Open();


            if (string.IsNullOrEmpty(CurrentUserLogIn) == false)
            {
                SqlCommand cmd = new SqlCommand
                (@"exec usp_config_b3_security_writeLog  
                    @CurrentUserLogin = @CurrentUserLogin_ , @Action = '" + action + "', @OldPassword = '" + OldValue + "', @NewPassword = '" + NewValue + "', @MacAddress = '" + MacAddress + "', @UserName = @User_Name , @Settings = '" + settings + "'", sc);
                cmd.Parameters.AddWithValue("CurrentUserLogin_", CurrentUserLogIn);
                cmd.Parameters.AddWithValue("User_Name", MacAddressChanged);
                cmd.ExecuteNonQuery();
            }
            sc.Close();

        }

    }
}
