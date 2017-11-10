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
    class SetGameSettingsCrazyBout
    {
        public SetGameSettingsCrazyBout()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"Exec usp_GameSettings_CrazyBout_Set
                                                         @spmaxcards 
                                                        ,@spmaxbetlevel 
                                                        ,@spmaxpatterns 
                                                        ,@spmaxcalls 
                                                        ,@spmaxpatterns_bonus 
                                                        ,@spmaxcalls_bonus 
                                                        ,@spcallspeed_min 
                                                        ,@spcallspeed_max 
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
                                                        ,@spsingleoffer_bonus 
                                                        ,@sphidecardserialnum "
                                                        , sc))
                {

                    cmd.Parameters.AddWithValue("spmaxcards", GetGameSettingsCrazyBout.maxcards);
                    cmd.Parameters.AddWithValue("spmaxbetlevel",GetGameSettingsCrazyBout.maxbetlevel );
                    cmd.Parameters.AddWithValue("spmaxpatterns", GetGameSettingsCrazyBout.maxpatterns);
                    cmd.Parameters.AddWithValue("spmaxcalls", GetGameSettingsCrazyBout.maxcalls );
                    cmd.Parameters.AddWithValue("spmaxpatterns_bonus",GetGameSettingsCrazyBout.maxpatterns_bonus);
                    cmd.Parameters.AddWithValue("spmaxcalls_bonus",GetGameSettingsCrazyBout.maxcalls_bonus);
                    cmd.Parameters.AddWithValue("spcallspeed_min",GetGameSettingsCrazyBout.callspeed_min );
                    cmd.Parameters.AddWithValue("spcallspeed_max",GetGameSettingsCrazyBout.callspeed_max ); 
                    cmd.Parameters.AddWithValue("spautocall",GetGameSettingsCrazyBout.autocall );
                    cmd.Parameters.AddWithValue("spautoplay ",GetGameSettingsCrazyBout.autoplay );
                    cmd.Parameters.AddWithValue("spdenom_1", GetGameSettingsCrazyBout.denom_1);
                    cmd.Parameters.AddWithValue("spdenom_5", GetGameSettingsCrazyBout.denom_5);
                    cmd.Parameters.AddWithValue("spdenom_10", GetGameSettingsCrazyBout.denom_10);
                    cmd.Parameters.AddWithValue("spdenom_25", GetGameSettingsCrazyBout.denom_25);
                    cmd.Parameters.AddWithValue("spdenom_50", GetGameSettingsCrazyBout.denom_50);
                    cmd.Parameters.AddWithValue("spdenom_100", GetGameSettingsCrazyBout.denom_100);
                    cmd.Parameters.AddWithValue("spdenom_200", GetGameSettingsCrazyBout.denom_200);
                    cmd.Parameters.AddWithValue("spdenom_500", GetGameSettingsCrazyBout.denom_500);
                    cmd.Parameters.AddWithValue("spsingleoffer_bonus", GetGameSettingsCrazyBout.singleofferbonus);
                    cmd.Parameters.AddWithValue("sphidecardserialnum", GetGameSettingsCrazyBout.hidecardserialnum);
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
