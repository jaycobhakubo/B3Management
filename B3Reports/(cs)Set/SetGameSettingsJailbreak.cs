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
    class SetGameSettingsJailbreak
    {


        public SetGameSettingsJailbreak()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"Exec usp_GameSettings_JailBreak_Set
                                                         @spmaxcards 
                                                        ,@spmaxbetlevel 
                                                        ,@spmaxpatterns 
                                                        ,@spmaxcalls 
                                                        ,@spmaxpatterns_bonus 
                                                        ,@spmaxcalls_bonus 
                                                        ,@spcallspeed
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
                                                        ,@spsingleoffer_bonus  "
                                                        , sc))
                {

                    cmd.Parameters.AddWithValue("spmaxcards", GetGameSettingJailbreak.maxcards);
                    cmd.Parameters.AddWithValue("spmaxbetlevel",GetGameSettingJailbreak.maxbetlevel );
                    cmd.Parameters.AddWithValue("spmaxpatterns", GetGameSettingJailbreak.maxpatterns);
                    cmd.Parameters.AddWithValue("spmaxcalls", GetGameSettingJailbreak.maxcalls );
                    cmd.Parameters.AddWithValue("spmaxpatterns_bonus",GetGameSettingJailbreak.maxpatterns_bonus);
                    cmd.Parameters.AddWithValue("spmaxcalls_bonus",GetGameSettingJailbreak.maxcalls_bonus);
                    cmd.Parameters.AddWithValue("spcallspeed",GetGameSettingJailbreak.callspeed );
                    cmd.Parameters.AddWithValue("spautocall",GetGameSettingJailbreak.autocall );
                    cmd.Parameters.AddWithValue("spautoplay ",GetGameSettingJailbreak.autoplay );
                    cmd.Parameters.AddWithValue("spdenom_1", GetGameSettingJailbreak.denom_1);
                    cmd.Parameters.AddWithValue("spdenom_5", GetGameSettingJailbreak.denom_5);
                    cmd.Parameters.AddWithValue("spdenom_10", GetGameSettingJailbreak.denom_10);
                    cmd.Parameters.AddWithValue("spdenom_25", GetGameSettingJailbreak.denom_25);
                    cmd.Parameters.AddWithValue("spdenom_50", GetGameSettingJailbreak.denom_50);
                    cmd.Parameters.AddWithValue("spdenom_100", GetGameSettingJailbreak.denom_100);
                    cmd.Parameters.AddWithValue("spdenom_200", GetGameSettingJailbreak.denom_200);
                    cmd.Parameters.AddWithValue("spdenom_500", GetGameSettingJailbreak.denom_500);
                    cmd.Parameters.AddWithValue("sphidecardserialnum", GetGameSettingJailbreak.hidecardserialnum);
                    cmd.Parameters.AddWithValue("spsingleoffer_bonus", GetGameSettingJailbreak.singleofferbonus);
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
