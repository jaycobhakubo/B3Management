using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports._cs_Set
{
    public class SetGameSettingsSpirit76
    {
        public static void SetSettings(GameSettings gameSettings)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"Exec usp_GameSettings_Spirit76_Set
                                                         @spmaxcards 
                                                        ,@spmaxbetlevel 
                                                        ,@spmaxpatterns 
                                                        ,@spmaxcalls 
                                                        ,@spmaxpatterns_bonus 
                                                        ,@spmaxcalls_bonus 
                                                        ,@spcallspeed
                                                        ,@spcallspeed_bonus
                                                        ,@spautocall 
                                                        ,@spautoplay 
                                                        ,@spdenom_1 
                                                        ,@spdenom_5 
                                                        ,@spdenom_10 
                                                        ,@spdenom_25 
                                                        ,@spdenom_50 
                                                        ,@spdenom_100 
                                                        ,@spdenom_200 
                                                        ,@spdenom_500
                                                        ,@sphidecardserialnum
                                                        ,@spsingleoffer_bonus"
                                                        , sc))
                {
                    cmd.Parameters.AddWithValue("spmaxcards", gameSettings.MaxCards);
                    cmd.Parameters.AddWithValue("spmaxbetlevel", gameSettings.MaxBetLevel);
                    cmd.Parameters.AddWithValue("spmaxpatterns", gameSettings.MaxPatterns);
                    cmd.Parameters.AddWithValue("spmaxcalls", gameSettings.MaxCalls);
                    cmd.Parameters.AddWithValue("spmaxpatterns_bonus", gameSettings.MaxPatternsBonus);
                    cmd.Parameters.AddWithValue("spmaxcalls_bonus", gameSettings.MaxCallsBonus);
                    cmd.Parameters.AddWithValue("spcallspeed", gameSettings.CallSpeed);
                    cmd.Parameters.AddWithValue("spcallspeed_bonus", gameSettings.CallSpeedBonus);
                    cmd.Parameters.AddWithValue("spautocall", gameSettings.AutoCall);
                    cmd.Parameters.AddWithValue("spautoplay ", gameSettings.AutoPlay);
                    cmd.Parameters.AddWithValue("spdenom_1", gameSettings.Denom1);
                    cmd.Parameters.AddWithValue("spdenom_5", gameSettings.Denom5);
                    cmd.Parameters.AddWithValue("spdenom_10", gameSettings.Denom10);
                    cmd.Parameters.AddWithValue("spdenom_25", gameSettings.Denom25);
                    cmd.Parameters.AddWithValue("spdenom_50", gameSettings.Denom50);
                    cmd.Parameters.AddWithValue("spdenom_100", gameSettings.Denom100);
                    cmd.Parameters.AddWithValue("spdenom_200", gameSettings.Denom200);
                    cmd.Parameters.AddWithValue("spdenom_500", gameSettings.Denom500);
                    cmd.Parameters.AddWithValue("sphidecardserialnum", gameSettings.HideCardSerialNumber);
                    cmd.Parameters.AddWithValue("spsingleoffer_bonus", gameSettings.SingleOfferBonus);
                    cmd.ExecuteNonQuery();
                    //cmd.ExecuteNonQuery(); //or you could try this if did not work                 
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
