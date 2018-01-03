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

        private DateTime? mDateTimePlay;
        private string mB4Games;
        private int mStartingCrdAmnt;
        private int mEndingCrdAmnt;
        private int mWinAmount;
        private int mBonusWinAmount;
        private int mBetAmount;
        private int mBetLevel;
        private int mBetDenom;
        private int mBallCount;
        private int mGameNumber;
        private int mFirstCardNumber;
        private int mLastCardNumber;
        private int mFirstBonusCardNumber;
        private int mLastBonusCardNumber;
        private int mBonusBallCount;
        private int mBonusOfferAccepted;
        private int mServerGameNumber;

        #endregion

        #region PROPERTIES

        public int ServerGameNumber
        {
            get { return mServerGameNumber; }
            set { mServerGameNumber = value; }
        }

        public DateTime? DateTimePlay
        {
            get { return mDateTimePlay;}
            set { mDateTimePlay = value; }
        }

        public string B4Games
        {
            get { return mB4Games; }
            set { mB4Games = value; }
        }

        public int StartingCrdAmnt
        {
            get { return mStartingCrdAmnt; }
            set { mStartingCrdAmnt = value; }
        }

        public int EndingCrdAmnt
        {
            get { return mEndingCrdAmnt; }
            set { mEndingCrdAmnt = value; }
        }

        public int WinAmount
        {
            get { return mWinAmount; }
            set { mWinAmount = value; }
        }

        public int BonusWinAmount
        {
            get { return mBonusWinAmount; }
            set { mBonusWinAmount = value; }
        }

        public int BetAmount
        {
            get { return mBetAmount; }
            set { mBetAmount = value; }
        }

        public int BetLevel
        {
            get { return mBetLevel; }
            set { mBetLevel = value; }
        }

        public int BetDenom
        {
            get { return mBetDenom; }
            set { mBetDenom = value; }
        }

        public int BallCount
        {
            get { return mBallCount; }
            set { mBallCount = value; }
        }

        public int GameNumber
        {
            get { return mGameNumber; }
            set { mGameNumber = value; }
        }

        public int FirstCardNumber
        {
            get { return mFirstCardNumber; }
            set { mFirstCardNumber = value; }
        }

        public int LastCardNumber
        {
            get { return mLastCardNumber; }
            set { mLastCardNumber = value; }
        }

        public int FirstBonusCardNumber
        {
            get { return mFirstBonusCardNumber; }
            set { mFirstBonusCardNumber = value; }
        }

        public int LastBonusCardNumber
        {
            get { return mLastBonusCardNumber; }
            set { mLastBonusCardNumber = value; }
        }

        public int BonusBallCount
        {
            get { return mBonusBallCount; }
            set { mBonusBallCount = value; }
        }

        public int BonusOfferAccepted
        {
            get { return mBonusOfferAccepted; }
            set { mBonusOfferAccepted = value; }
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
                        mDateTimePlay = reader.GetDateTime(0);
                        mB4Games = reader.GetString(1);
                        mStartingCrdAmnt = reader.GetInt32(2);
                        mEndingCrdAmnt = reader.GetInt32(3);
                        mWinAmount = reader.GetInt32(4);
                        mBonusWinAmount = reader.GetInt32(5);
                        mBetAmount = reader.GetInt32(6);
                        mBetLevel = reader.GetInt32(7);
                        mBetDenom = reader.GetInt32(8);
                        mBallCount = reader.GetInt32(9);
                        mGameNumber = reader.GetInt32(10);
                        mFirstCardNumber = reader.GetInt32(11);
                        mLastCardNumber = reader.GetInt32(12);
                        mFirstBonusCardNumber = reader.GetInt32(13);
                        mLastBonusCardNumber = reader.GetInt32(14);
                        mBonusBallCount = reader.GetInt32(15);
                        mBonusOfferAccepted = reader.GetInt32(16);
                        if (!reader.IsDBNull(17))
                        {
                            mServerGameNumber = reader.GetInt32(17);
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
