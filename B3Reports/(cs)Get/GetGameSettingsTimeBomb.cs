﻿using System;
using System.Data.SqlClient;
using System.Windows.Forms;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports._cs_Get
{
    public class GetGameSettingsTimeBomb
    {
        public static void GetSettings(GameSettings gameSettings)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_GameSettings_TimeBomb_Get", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        gameSettings.MaxCards = reader.GetInt32(0);
                        gameSettings.MaxBetLevel = reader.GetInt32(1);
                        gameSettings.MaxPatterns = reader.GetInt32(2);
                        gameSettings.MaxCalls = reader.GetInt32(3);
                        gameSettings.CallSpeed = reader.GetInt32(4);
                        gameSettings.AutoCall = reader.GetString(5);
                        gameSettings.AutoPlay = reader.GetString(6);
                        gameSettings.Denom1 = reader.GetString(7);
                        gameSettings.Denom5 = reader.GetString(8);
                        gameSettings.Denom10 = reader.GetString(9);
                        gameSettings.Denom25 = reader.GetString(10);
                        gameSettings.Denom50 = reader.GetString(11);
                        gameSettings.Denom100 = reader.GetString(12);
                        gameSettings.Denom200 = reader.GetString(13);
                        gameSettings.Denom500 = reader.GetString(14);
                        gameSettings.HideCardSerialNumber = reader.GetString(15);
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
