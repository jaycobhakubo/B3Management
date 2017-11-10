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
    public class GetDualAccountSettings
    {
        public static bool DualAccountSettings;

        public  static bool getDualAccountSettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            string result = "";

            try
            {
                using (SqlCommand cmd = new SqlCommand(@"select doubleaccount from [dbo].[B3_SystemConfig]", sc))
                {
                    result = (string)cmd.ExecuteScalar();
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

            bool returnValue;

            if (result == "T")
            {
                returnValue = true;
            }
            else { returnValue = false; }
            DualAccountSettings = returnValue;
            return returnValue;

        }
    }
}
