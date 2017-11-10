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
    class SetGameSettings
    {
        public SetGameSettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_SystemSetting_b3_Game_Set
                                                        @spMinPlayer ,
                                                        @spConsolationPrize ,
                                                        @spCountdownTimer
                                                        ,@spGamePasswordRecall
                                                        ,@spWaitCountdownTimerForOtherPlayers"
                                                        , sc))
                {
                    cmd.Parameters.AddWithValue("spMinPlayer", GetGameSettings.MinNumberOfPlayers); 
                    cmd.Parameters.AddWithValue("spConsolationPrize", GetGameSettings.ConsolationPrize); //GetSecuritySettings.PrevPasswordReuseN);
                    cmd.Parameters.AddWithValue("spCountdownTimer", GetGameSettings.CountDownTimer); //GetSecuritySettings.PrevPasswordLockoutAttempts);
                    cmd.Parameters.AddWithValue("spGamePasswordRecall", GetGameSettings.GameRecalPasswords);
                    cmd.Parameters.AddWithValue("spWaitCountdownTimerForOtherPlayers", GetGameSettings.WaitCountDownForOtherPLayers);
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
