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
    class GetGameSettings
    {
    //Set the default
        public static int MinNumberOfPlayers = 2;
        public static int ConsolationPrize = 1; 
        public static int CountDownTimer = 10; //In Sec
        public static string GameRecalPasswords = "";
        public static int WaitCountDownForOtherPLayers = 11;

        public GetGameSettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_SystemSetting_b3_Games_Get", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        MinNumberOfPlayers = reader.GetInt32(0);
                        CountDownTimer = reader.GetInt32(1);
                        ConsolationPrize = (Int32)reader.GetInt64(2);
                        GameRecalPasswords = reader.GetString(3);
                        WaitCountDownForOtherPLayers = reader.GetInt32(4);
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
