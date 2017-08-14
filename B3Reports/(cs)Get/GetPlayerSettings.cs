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
    class GetPlayerSettings
    {
        public static string ScreenCursor;
        public static string CalibrateTouch;
        public static string Disclaimer;
        public static string AnnounceCall;
        public static string PressToCollect;
        public static int TimeToCollect;
        public static int MainVolume;

        //We only have 8 games available
        //public static string GameNum1;//Or should we name it as games
        //public static string GameNum2;
        //public static string GameNum3;
        //public static string GameNum4;
        //public static string GameNum5;
        //public static string GameNum6;
        //public static string GameNum7;
        //public static string GameNum8;

        public string screencursor
        {
            get { return ScreenCursor; }
            set { ScreenCursor = value; }
        }

        public string calibratetouch
        {
            get { return CalibrateTouch; }
            set { CalibrateTouch = value; }
        }

        public string disclaimer
        {
            get { return Disclaimer; }
            set { Disclaimer = value; }
        }

        public string announcecall
        {
            get { return AnnounceCall; }
            set { AnnounceCall = value; }
        }

        public string presstocollect
        {
            get { return PressToCollect; }
            set { PressToCollect = value; }
        }

        public int timetocollect
        {
            get { return TimeToCollect; }
            set { TimeToCollect = value; }
        }

        public int mainvolume
        {
            get { return MainVolume; }
            set { MainVolume = value; }
        }

        //public string gamenum1
        //{
        //    get { return GameNum1; }
        //    set { GameNum1 = value; }
        //}

        //public string gamenum2
        //{
        //    get { return GameNum2; }
        //    set { GameNum2 = value; }
        //}

        //public string gamenum3
        //{
        //    get { return GameNum3; }
        //    set { GameNum3 = value; }
        //}

        //public string gamenum4
        //{
        //    get { return GameNum4; }
        //    set { GameNum4 = value; }
        //}

        //public string gamenum5
        //{
        //    get { return GameNum5; }
        //    set { GameNum5 = value; }
        //}

        //public string gamenum6
        //{
        //    get { return GameNum6; }
        //    set { GameNum6 = value; }
        //}

        //public string gamenum7
        //{
        //    get { return GameNum7; }
        //    set { GameNum7 = value; }
        //}

        //public string gamenum8
        //{
        //    get { return GameNum8; }
        //    set { GameNum8 = value; }
        //}

        public GetPlayerSettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SystemSettings_GetPlayerSettings", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                      ScreenCursor = reader.GetString(0);
                      CalibrateTouch = reader.GetString(1);
                      Disclaimer = reader.GetString(2);
                      AnnounceCall = reader.GetString(3);
                      PressToCollect = reader.GetString(4);
                      TimeToCollect = reader.GetInt32(5);
                      MainVolume = reader.GetInt32(6);
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
