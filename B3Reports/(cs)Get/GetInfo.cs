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
    class GetInfo
    {
        #region VARIABLES(static)

        public static DateTime? DateTimePlay;
        public static string B4Games;
        public static int StartingCrdAmnt;
        public static int EndingCrdAmnt;
        public static int WinAmount;
        public static int BonusWinAmount;
        public static int BetAmount;
        public static int BetLevel;
        public static int BetDenom;
        public static int BallCount;
        public static int GameNumber;
        public static int FirstCardNumber;
        public static int LastCardNumber;
        public static int FirstBonusCardNumber;
        public static int LastBonusCardNumber;
        public static int BonusBallCount;
        public static int BonusOfferAccepted;
        public static int ServerGameNumber;

        #endregion

        #region PROPERTIES

        public int serverGameNumber
        {
            get { return ServerGameNumber; }
            set { ServerGameNumber = value; }
        }

        public DateTime? datetimeplay
        {
            get { return DateTimePlay;}
            set { DateTimePlay = value; }
        }

        public string b4games
        {
            get { return B4Games; }
            set { B4Games = value; }
        }

        public int startingcrdamnt
        {
            get { return StartingCrdAmnt; }
            set { StartingCrdAmnt = value; }
        }

        public int endingcrdamnt
        {
            get { return EndingCrdAmnt; }
            set { EndingCrdAmnt = value; }
        }

        public int winamount
        {
            get { return WinAmount; }
            set { WinAmount = value; }
        }

        public int bonuswinamount
        {
            get { return BonusWinAmount; }
            set { BonusWinAmount = value; }
        }

        public int betamount
        {
            get { return BetAmount; }
            set { BetAmount = value; }
        }

        public int betlevel
        {
            get { return BetLevel; }
            set { BetLevel = value; }
        }

        public int betdenom
        {
            get { return BetDenom; }
            set { BetDenom = value; }
        }

        public int ballcount
        {
            get { return BallCount; }
            set { BallCount = value; }
        }

        public int gamenumber
        {
            get { return GameNumber; }
            set { GameNumber = value; }
        }

        public int firstcardnumber
        {
            get { return FirstCardNumber; }
            set { FirstCardNumber = value; }
        }

        public int lastcardnumber
        {
            get { return LastCardNumber; }
            set { LastCardNumber = value; }
        }

        public int firstbonuscardnumber
        {
            get { return FirstBonusCardNumber; }
            set { FirstBonusCardNumber = value; }
        }

        public int lastbonuscardnumber
        {
            get { return LastBonusCardNumber; }
            set { LastBonusCardNumber = value; }
        }

        public int bonusballcount
        {
            get { return BonusBallCount; }
            set { BonusBallCount = value; }
        }

        public int bonusofferaccepted
        {
            get { return BonusOfferAccepted; }
            set { BonusOfferAccepted = value; }
        }

        #endregion

        #region METHODS

        public GetInfo
            (int AccountNumber 
            ,DateTime? PlayTime 
            ,int Status
            ,string B4_Games
            ,int GameStartNum
            ,int GameEndNum
            ,string IsGameNumber)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetInfo 
                                                        @spAcctNumber = @AccountNumber
                                                        ,@spPlayTime = @PlayTime 
                                                        ,@spStatus = @Status 
                                                        ,@spB4Games = @B4Games  
                                                        ,@spGameStartNum =  @GameStartNum        
                                                        ,@spGameEndNum = @GameEndNum
                                                        ,@spIsGameNumber = @IsGameNumber
                                                        ", sc))
                {
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                    if (PlayTime == null)
                    {
                        SqlDateTime PlayTime2 = SqlDateTime.Null;
                        cmd.Parameters.AddWithValue("Playtime", PlayTime2);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("Playtime", PlayTime);
                    }
                    cmd.Parameters.AddWithValue("Status", Status);
                    if (B4_Games == string.Empty)
                    {
                        SqlString B4Games2 = SqlString.Null;
                        cmd.Parameters.AddWithValue("B4Games", B4Games2);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("B4Games", B4_Games);
                    }
                    cmd.Parameters.AddWithValue("GameStartNum", GameStartNum);
                    cmd.Parameters.AddWithValue("GameEndNum", GameEndNum);
                    cmd.Parameters.AddWithValue("IsGameNumber", IsGameNumber);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        DateTimePlay = reader.GetDateTime(0);
                        B4Games = reader.GetString(1);
                        StartingCrdAmnt = reader.GetInt32(2);
                        EndingCrdAmnt = reader.GetInt32(3);
                        WinAmount = reader.GetInt32(4);
                        BonusWinAmount = reader.GetInt32(5);
                        BetAmount = reader.GetInt32(6);
                        BetLevel = reader.GetInt32(7);
                        BetDenom = reader.GetInt32(8);
                        BallCount = reader.GetInt32(9);
                        GameNumber = reader.GetInt32(10);
                        FirstCardNumber = reader.GetInt32(11);
                        LastCardNumber = reader.GetInt32(12);
                        FirstBonusCardNumber = reader.GetInt32(13);
                        LastBonusCardNumber = reader.GetInt32(14);
                        BonusBallCount = reader.GetInt32(15);
                        BonusOfferAccepted = reader.GetInt32(16);
                        if (!reader.IsDBNull(17))
                        {
                            ServerGameNumber = reader.GetInt32(17);
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

        #endregion
    }


}
