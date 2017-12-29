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


    class GetNWinningPattern
    {
        public static int Pattern_Num_1;
        public static int Pattern_Num_2;
        public static int Pattern_Num_3;
        public static int Pattern_Num_4;
        public static int Pattern_Num_5;
        public static int Pattern_Num_6;
        public static int Pattern_Num_7;
        public static int Pattern_Num_8;
        public static int Pattern_Num_9;
        public static int Pattern_Num_10;
        public static int Pattern_Num_11;
        public static int Pattern_Num_12;
        public static int Pattern_Num_13;

        public static void GetNBonusWinningPattern(int AccountNumber, DateTime? recdatetime, string gameName)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select 
                                                        numofwins_bonuspatt_1
                                                        ,numofwins_bonuspatt_2 
                                                        ,numofwins_bonuspatt_3 
                                                        ,numofwins_bonuspatt_4 
                                                        ,numofwins_bonuspatt_5 
                                                        ,numofwins_bonuspatt_6 
                                                        ,numofwins_bonuspatt_7 
                                                        ,numofwins_bonuspatt_8 
                                                        ,numofwins_bonuspatt_9 
                                                        ,numofwins_bonuspatt_10 
                                                        ,numofwins_bonuspatt_11 
                                                        ,numofwins_bonuspatt_12 
                                                        from dbo." + gameName + @"_GameJournal where creditacctnum = @creditacctnum and recdatetime = @recdatetime", sc))
                {
                    cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                    cmd.Parameters.AddWithValue("recdatetime", recdatetime);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        //Pattern_Num_1 = reader.GetInt32(0);
                        //Pattern_Num_2 = reader.GetInt32(1);
                        //Pattern_Num_3 = reader.GetInt32(2);
                        //Pattern_Num_4 = reader.GetInt32(3);
                        //Pattern_Num_5 = reader.GetInt32(4);
                        //Pattern_Num_6 = reader.GetInt32(5);
                        //Pattern_Num_7 = reader.GetInt32(6);
                        //Pattern_Num_8 = reader.GetInt32(7);
                        //Pattern_Num_9 = reader.GetInt32(8);
                        //Pattern_Num_10 = reader.GetInt32(9);
                        //Pattern_Num_11 = reader.GetInt32(10);
                        //Pattern_Num_12 = reader.GetInt32(11);

                        Pattern_Num_1 = reader.GetInt32(11);
                        Pattern_Num_2 = reader.GetInt32(10);
                        Pattern_Num_3 = reader.GetInt32(9);
                        Pattern_Num_4 = reader.GetInt32(8);
                        Pattern_Num_5 = reader.GetInt32(7);
                        Pattern_Num_6 = reader.GetInt32(6);
                        Pattern_Num_7 = reader.GetInt32(5);
                        Pattern_Num_8 = reader.GetInt32(4);
                        Pattern_Num_9 = reader.GetInt32(3);
                        Pattern_Num_10 = reader.GetInt32(2);
                        Pattern_Num_11 = reader.GetInt32(1);
                        Pattern_Num_12 = reader.GetInt32(0);
                        
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
  

        public GetNWinningPattern(int AccountNumber, DateTime? recdatetime, string gameName)
        {
          
            SqlConnection sc = GetSQLConnection.get();
            if (gameName != "TimeBomb")
            {
                try
                {
                    sc.Open();

                    using (SqlCommand cmd = new SqlCommand(@"select 
                                                        numofwins_patt_1
                                                        ,numofwins_patt_2 
                                                        ,numofwins_patt_3 
                                                        ,numofwins_patt_4 
                                                        ,numofwins_patt_5 
                                                        ,numofwins_patt_6 
                                                        ,numofwins_patt_7 
                                                        ,numofwins_patt_8 
                                                        ,numofwins_patt_9 
                                                        ,numofwins_patt_10 
                                                        ,numofwins_patt_11 
                                                        ,numofwins_patt_12 
                                                        from dbo." + gameName + @"_GameJournal where creditacctnum = @creditacctnum and recdatetime = @recdatetime", sc))
                    {
                        cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                        cmd.Parameters.AddWithValue("recdatetime", recdatetime);

                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            Pattern_Num_1 = reader.GetInt32(11);
                            Pattern_Num_2 = reader.GetInt32(10);
                            Pattern_Num_3 = reader.GetInt32(9);
                            Pattern_Num_4 = reader.GetInt32(8);
                            Pattern_Num_5 = reader.GetInt32(7);
                            Pattern_Num_6 = reader.GetInt32(6);
                            Pattern_Num_7 = reader.GetInt32(5);
                            Pattern_Num_8 = reader.GetInt32(4);
                            Pattern_Num_9 = reader.GetInt32(3);
                            Pattern_Num_10 = reader.GetInt32(2);
                            Pattern_Num_11 = reader.GetInt32(1);
                            Pattern_Num_12 = reader.GetInt32(0);
                            if (GetGameSettings.MinNumberOfPlayers > 1)
                            {
                                Pattern_Num_13 = GetInfo.WinAmount / GetGameSettings.ConsolationPrize;
                            }
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
            else
            {
                try
                {
                    sc.Open();

                    using (SqlCommand cmd = new SqlCommand(@"select 
                                                        numofwins_patt_1
                                                        ,numofwins_patt_2 
                                                        ,numofwins_patt_3 
                                                        ,numofwins_patt_4 
                                                        ,numofwins_patt_5 
                                                        ,numofwins_patt_6 
                                                        from dbo." + gameName + @"_GameJournal where creditacctnum = @creditacctnum and recdatetime = @recdatetime", sc))
                    {
                        cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                        cmd.Parameters.AddWithValue("recdatetime", recdatetime);

                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {

                            Pattern_Num_7 = reader.GetInt32(5);
                            Pattern_Num_8 = reader.GetInt32(4);
                            Pattern_Num_9 = reader.GetInt32(3);
                            Pattern_Num_10 = reader.GetInt32(2);
                            Pattern_Num_11 = reader.GetInt32(1);
                            Pattern_Num_12 = reader.GetInt32(0);
                            if (GetGameSettings.MinNumberOfPlayers > 1)
                            {
                                Pattern_Num_13 = GetInfo.WinAmount / GetGameSettings.ConsolationPrize;
                            }
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
}
