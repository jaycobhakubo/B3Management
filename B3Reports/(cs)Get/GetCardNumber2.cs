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
    class GetCardNumber2
    {

        private Byte CardNum1;
        private Byte CardNum2;
        private Byte CardNum3;
        private Byte CardNum4;
        private Byte CardNum5;
        private Byte CardNum6;
        private Byte CardNum7;
        private Byte CardNum8;
        private Byte CardNum9;
        private Byte CardNum10;
        private Byte CardNum11;
        private Byte CardNum12;
        private Byte CardNum13;
        private Byte CardNum14;
        private Byte CardNum15;
        private Byte CardNum16;
        private Byte CardNum17;
        private Byte CardNum18;
        private Byte CardNum19;
        private Byte CardNum20;
        private Byte CardNum21;
        private Byte CardNum22;
        private Byte CardNum23;
        private Byte CardNum24;
        private Byte CardNum25;


        public Byte Card_Num_1 { get { return CardNum1; } }
        public Byte Card_Num_2 { get { return CardNum2; } }
        public Byte Card_Num_3 { get { return CardNum3; } }
        public Byte Card_Num_4 { get { return CardNum4; } }
        public Byte Card_Num_5 { get { return CardNum5; } }
        public Byte Card_Num_6 { get { return CardNum6; } }
        public Byte Card_Num_7 { get { return CardNum7; } }
        public Byte Card_Num_8 { get { return CardNum8; } }
        public Byte Card_Num_9 { get { return CardNum9; } }
        public Byte Card_Num_10 { get { return CardNum10; } }
        public Byte Card_Num_11 { get { return CardNum11; } }
        public Byte Card_Num_12 { get { return CardNum12; } }
        public Byte Card_Num_13 { get { return CardNum13; } }
        public Byte Card_Num_14 { get { return CardNum14; } }
        public Byte Card_Num_15 { get { return CardNum15; } }
        public Byte Card_Num_16 { get { return CardNum16; } }
        public Byte Card_Num_17 { get { return CardNum17; } }
        public Byte Card_Num_18 { get { return CardNum18; } }
        public Byte Card_Num_19 { get { return CardNum19; } }
        public Byte Card_Num_20 { get { return CardNum20; } }
        public Byte Card_Num_21 { get { return CardNum21; } }
        public Byte Card_Num_22 { get { return CardNum22; } }
        public Byte Card_Num_23 { get { return CardNum23; } }
        public Byte Card_Num_24 { get { return CardNum24; } }
        public Byte Card_Num_25 { get { return CardNum25; } }


        public GetCardNumber2(int CardNumber)
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
                        CardNum1 = reader.GetByte(1);
                        CardNum2 = reader.GetByte(2);
                        CardNum3 = reader.GetByte(3);
                        CardNum4 = reader.GetByte(4);
                        CardNum5 = reader.GetByte(5);
                        CardNum6 = reader.GetByte(6);
                        CardNum7 = reader.GetByte(7);
                        CardNum8 = reader.GetByte(8);
                        CardNum9 = reader.GetByte(9);
                        CardNum10 = reader.GetByte(10);
                        CardNum11 = reader.GetByte(11);
                        CardNum12 = reader.GetByte(12);
                        CardNum13 = reader.GetByte(13);
                        CardNum14 = reader.GetByte(14);
                        CardNum15 = reader.GetByte(15);
                        CardNum16 = reader.GetByte(16);
                        CardNum17 = reader.GetByte(17);
                        CardNum18 = reader.GetByte(18);
                        CardNum19 = reader.GetByte(19);
                        CardNum20 = reader.GetByte(20);
                        CardNum21 = reader.GetByte(21);
                        CardNum22 = reader.GetByte(22);
                        CardNum23 = reader.GetByte(23);
                        CardNum24 = reader.GetByte(24);
                        CardNum25 = reader.GetByte(25);
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
