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
    class SetGameSettingsMayaMoney
    {
        public SetGameSettingsMayaMoney()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"Exec usp_GameSettings_MayaMoney_Set
                                                         @spmaxcards 
                                                        ,@spmaxbetlevel 
                                                        ,@spmaxpatterns 
                                                        ,@spmaxcalls 
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
                                                        ,@sphidecardserialnum "
                                                        , sc))
                {
                    //GetGameSettingsMayaMoney
                    cmd.Parameters.AddWithValue("spmaxcards", GetGameSettingsMayaMoney.maxcards);
                    cmd.Parameters.AddWithValue("spmaxbetlevel", GetGameSettingsMayaMoney.maxbetlevel);
                    cmd.Parameters.AddWithValue("spmaxpatterns", GetGameSettingsMayaMoney.maxpatterns);
                    cmd.Parameters.AddWithValue("spmaxcalls", GetGameSettingsMayaMoney.maxcalls);
                    cmd.Parameters.AddWithValue("spcallspeed_min", GetGameSettingsMayaMoney.callspeed_min);
                    cmd.Parameters.AddWithValue("spcallspeed_max", GetGameSettingsMayaMoney.callspeed_max);
                    cmd.Parameters.AddWithValue("spautocall", GetGameSettingsMayaMoney.autocall);
                    cmd.Parameters.AddWithValue("spautoplay ", GetGameSettingsMayaMoney.autoplay);
                    cmd.Parameters.AddWithValue("spdenom_1", GetGameSettingsMayaMoney.denom_1);
                    cmd.Parameters.AddWithValue("spdenom_5", GetGameSettingsMayaMoney.denom_5);
                    cmd.Parameters.AddWithValue("spdenom_10", GetGameSettingsMayaMoney.denom_10);
                    cmd.Parameters.AddWithValue("spdenom_25", GetGameSettingsMayaMoney.denom_25);
                    cmd.Parameters.AddWithValue("spdenom_50", GetGameSettingsMayaMoney.denom_50);
                    cmd.Parameters.AddWithValue("spdenom_100", GetGameSettingsMayaMoney.denom_100);
                    cmd.Parameters.AddWithValue("spdenom_200", GetGameSettingsMayaMoney.denom_200);
                    cmd.Parameters.AddWithValue("spdenom_500", GetGameSettingsMayaMoney.denom_500);
                    cmd.Parameters.AddWithValue("sphidecardserialnum", GetGameSettingsMayaMoney.hidecardserialnum);
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
