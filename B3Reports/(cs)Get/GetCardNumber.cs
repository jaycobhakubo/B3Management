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
    class GetCardNumber
    {
        public static Byte Card_Num_1;
        public static Byte Card_Num_2;
        public static Byte Card_Num_3;
        public static Byte Card_Num_4;
        public static Byte Card_Num_5;
        public static Byte Card_Num_6;
        public static Byte Card_Num_7;
        public static Byte Card_Num_8;
        public static Byte Card_Num_9;
        public static Byte Card_Num_10;
        public static Byte Card_Num_11;
        public static Byte Card_Num_12;
        public static Byte Card_Num_13;
        public static Byte Card_Num_14;
        public static Byte Card_Num_15;
        public static Byte Card_Num_16;
        public static Byte Card_Num_17;
        public static Byte Card_Num_18;
        public static Byte Card_Num_19;
        public static Byte Card_Num_20;
        public static Byte Card_Num_21;
        public static Byte Card_Num_22;
        public static Byte Card_Num_23;
        public static Byte Card_Num_24;
        public static Byte Card_Num_25;

        public GetCardNumber(int CardNumber)
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec rptCardImages 
                                                        @startid = @startid_
                                                        ,@endid = @endid_                                         
                                                        ", sc))
                {
                    cmd.Parameters.AddWithValue("startid_", CardNumber);
                    cmd.Parameters.AddWithValue("endid_", CardNumber);
           
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Card_Num_1 = reader.GetByte(1);
                        Card_Num_2 = reader.GetByte(2);
                        Card_Num_3 = reader.GetByte(3);
                        Card_Num_4 = reader.GetByte(4);
                        Card_Num_5 = reader.GetByte(5);
                        Card_Num_6 = reader.GetByte(6);
                        Card_Num_7 = reader.GetByte(7);
                        Card_Num_8 = reader.GetByte(8);
                        Card_Num_9 = reader.GetByte(9);
                        Card_Num_10 = reader.GetByte(10);
                        Card_Num_11 = reader.GetByte(11);
                        Card_Num_12 = reader.GetByte(12);
                        Card_Num_13 = reader.GetByte(13);
                        Card_Num_14 = reader.GetByte(14);
                        Card_Num_15 = reader.GetByte(15);
                        Card_Num_16 = reader.GetByte(16);
                        Card_Num_17 = reader.GetByte(17);
                        Card_Num_18 = reader.GetByte(18);
                        Card_Num_19 = reader.GetByte(19);
                        Card_Num_20 = reader.GetByte(20);
                        Card_Num_21 = reader.GetByte(21);
                        Card_Num_22 = reader.GetByte(22);
                        Card_Num_23 = reader.GetByte(23);
                        Card_Num_24 = reader.GetByte(24);
                        Card_Num_25 = reader.GetByte(25);
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
