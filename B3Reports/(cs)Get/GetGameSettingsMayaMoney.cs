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
    class GetGameSettingsMayaMoney
    {
        public static int maxcards = 6;
        public static int maxbetlevel = 1;
        public static int maxpatterns = 10;
        public static int maxcalls = 24;
        public static int callspeed_min = 200;
        public static int callspeed_max = 3000;
        public static string autocall = "F"; //since it uses stringacter from DB lets use string
        public static string autoplay = "F";
        public static string denom_1 = "T";
        public static string denom_5 = "T";
        public static string denom_10 = "T";
        public static string denom_25 = "T";
        public static string denom_50 = "T";
        public static string denom_100 = "T";
        public static string denom_200 = "T";
        public static string denom_500 = "T";
        public static string hidecardserialnum = "T";

        public int MaxCards
        {
            get { return maxcards; }
            set { maxcards = value; }
        }

        public int MaxBetLevel
        {
            get { return maxbetlevel; }
            set { maxbetlevel = value; }
        }

        public int MaxPatterns
        {
            get { return maxpatterns; }
            set { maxpatterns = value; }
        }

        public int MaxCalls
        {
            get { return maxcalls; }
            set { maxcalls = value; }
        }


        public int CallSpeed_Min
        {
            get { return callspeed_min; }
            set { callspeed_min = value; }
        }

        public int CallSpeed_Max
        {
            get { return callspeed_max; }
            set { callspeed_max = value; }
        }

        public string AutoCall
        {
            get { return autocall; }
            set { autocall = value; }
        }

        public string AutoPlay
        {
            get { return autoplay; }
            set { autoplay = value; }
        }

        public string Denom_1
        {
            get { return denom_1; }
            set { denom_1 = value; }
        }

        public string Denom_5
        {
            get { return denom_5; }
            set {denom_5 = value; }
        }

        public string Denom_10
        {
            get { return denom_10; }
            set { denom_10 = value; }
        }

        public string Denom_25
        {
            get { return denom_25; }
            set { denom_25 = value; }
        }

        public string Denom_50
        {
            get { return denom_50; }
            set { denom_50 = value; }
        }

        public string Denom_100
        {
            get { return denom_100; }
            set { denom_100 = value; }
        }

        public string Denom_200
        {
            get { return denom_200; }
            set { denom_200 = value; }
        }

        public string Denom_500
        {
            get { return denom_500; }
            set { denom_500 = value; }
        }

        public string HideCardSerialNum
        {
            get { return hidecardserialnum; }
            set { hidecardserialnum = value; }
        }

        //Lets get the current CrazyBout Setting in DB
        public GetGameSettingsMayaMoney()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_GameSettings_MayaMoney_Get", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                              maxcards = reader.GetInt32(0);
                              maxbetlevel = reader.GetInt32(1);
                              maxpatterns = reader.GetInt32(2);
                              maxcalls = reader.GetInt32(3);
                              callspeed_min = reader.GetInt32(4);
                              callspeed_max = reader.GetInt32(5);
                              autocall = reader.GetString(6);
                              autoplay = reader.GetString(7);
                              denom_1 = reader.GetString(8);
                              denom_5 = reader.GetString(9);
                              denom_10 = reader.GetString(10);
                              denom_25 = reader.GetString(11);
                              denom_50 = reader.GetString(12);
                              denom_100 = reader.GetString(13);
                              denom_200 = reader.GetString(14);
                              denom_500 = reader.GetString(15);
                              hidecardserialnum = reader.GetString(16);                        
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

   