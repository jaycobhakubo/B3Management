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
    class GetBallCall
    {
        public static string BallCall;
        public string ballcall
        {
            get { return BallCall; }
            set { BallCall = value; }
        }

        public static string BonusBallCall;
        public string bonusballcall
        {
            get { return BonusBallCall; }
            set { BonusBallCall = value; }
        }

        public static int HotBall;
        public int hotball
        {
            get { return HotBall;}
            set { HotBall = value; }
        }

        public static string BallFreq;
        public string ballfreq
        {
            get { return BallFreq; }
            set { BallFreq = value; }
        }

        public static int BonusPatterNJailBreak;
        public int bonusPatterNJailBreak
        {
            get { return BonusPatterNJailBreak; }
            set { BonusPatterNJailBreak = value;  }
        }

        public static int GetBonusPatternNForJailBreak(DateTime? PlayTime, int AccountNumber)
        {

            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select BonusTrigger from [dbo].[JailBreak_GameJournal] 
                                                            where recdatetime = @PlayTime
                                                            and creditacctnum = @AccountNumber
                                                            ", sc))
                {
                    cmd.Parameters.AddWithValue("PlayTime", PlayTime);
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                    BonusPatterNJailBreak = (int)cmd.ExecuteScalar();               
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

            return BonusPatterNJailBreak;
        }


        public static string GetBallFreqFor76Games(DateTime? PlayTime, int AccountNumber)
        {
       
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetSpiritBallFreq
                                                        @spPlayTime = @PlayTime
                                                        ,@spAcctNumber = @AccountNumber 
                                                        ", sc))
                {
                    cmd.Parameters.AddWithValue("PlayTime", PlayTime);
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        BallFreq = reader.GetString(0);
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

            return BallFreq;
        }

        public static void GetHotBall (DateTime? PlayTime, int AccountNumber)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetHotBall
                                                        @spPlayTime = @PlayTime
                                                        ,@spAcctNumber = @AccountNumber 
                                                        ", sc))
                {
                    cmd.Parameters.AddWithValue("PlayTime", PlayTime);
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        HotBall = Convert.ToInt32(reader.GetByte(0));
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


        public static void GetBonusBallCall_(DateTime? PlayTime, string B4_Games, int AccountNumber, int BallCallCount)
        {
            BonusBallCall = string.Empty;
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetBonusBallCall 
                                                        @spPlayTime = @PlayTime
                                                        ,@spB4Games = @B4_Games
                                                        ,@spAcctNumber = @AccountNumber 
                                                        ,@spBallCallCount = @BallCallCount
                                                        ", sc))
                {
                    cmd.Parameters.AddWithValue("PlayTime", PlayTime);
                    cmd.Parameters.AddWithValue("B4_Games", B4_Games);
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                    cmd.Parameters.AddWithValue("BallCallCount", BallCallCount);


                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        BonusBallCall = reader.GetString(0);
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


            if (B4_Games == "WildBall")
            {
                //Lets get the first number 
                BonusBallCall = BonusBallCallWildBall(BonusBallCall);
            }
            
        }


        public GetBallCall(DateTime? PlayTime, string B4_Games, int AccountNumber, int BallCallCount ,int GameNumber)
        {
            BallCall = string.Empty;
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetBallCall 
                                                        @spPlayTime = @PlayTime
                                                        ,@spB4Games = @B4_Games
                                                        ,@spAcctNumber = @AccountNumber 
                                                        ,@spBallCallCount = @BallCallCount
                                                      ,@spGameNumber = @GameNumber
                                                        ", sc))
                  
                {
                    cmd.Parameters.AddWithValue("PlayTime", PlayTime);
                    cmd.Parameters.AddWithValue("B4_Games", B4_Games);
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                    cmd.Parameters.AddWithValue("BallCallCount", BallCallCount);
                    cmd.Parameters.AddWithValue("GameNumber", GameNumber);        

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        BallCall = reader.GetString(0);
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

        public static string BonusBallCallWildBall(string InitialBonusBallCall)
        {
            string ibc = "," + InitialBonusBallCall; //InitialBonusBallCall.Substring(1);//remove the first comma
            int IndexOfibc = InitialBonusBallCall.IndexOf(',');
            string FirstNum = InitialBonusBallCall.Substring(0, IndexOfibc);
            //Get the last digit of the number
            if (FirstNum.Length == 2)
            {
                FirstNum = FirstNum.Substring(1);
            }

            int fn = Convert.ToInt32(FirstNum);//convert the first digit number to numeric
            while (fn <= 75)
            {
                string x =  "," + fn.ToString() + ",";
                bool check =  ibc.Contains(x);
                if (check == false)
                {
                    ibc = ibc + fn.ToString() + ",";
                }
                fn = fn + 10;
            }

            return ibc.Substring(1);
        }


    }
}
