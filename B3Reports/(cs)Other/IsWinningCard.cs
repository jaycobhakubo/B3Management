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

    class Pyramid_
    {
        public Pyramid_()
        {
            List<int> x = new List<int>();
            x.Add(3);
            x.Add(7);
            x.Add(8);
            x.Add(11);
            x.Add(12);
            x.Add(13);
            x.Add(17);
            x.Add(18);
            x.Add(23);

            int count = 1;
            while (count != 3 + 1)
            {
                string y = "";
                foreach(int z  in x)
                {
                    y = y + z.ToString() + ",";
                }

                IWC.Pyramid.Add(y);

                x[0] = x[0] + 1;
                x[1] = x[1] + 1;
                x[2] = x[2] + 1;
                x[3] = x[3] + 1;
                x[4] = x[4] + 1;
                x[5] = x[5] + 1;
                x[6] = x[6] + 1;
                x[7] = x[7] + 1;
                x[8] = x[8] + 1;

                count = count + 1;
            }
        }

    }


      class ASP
        {

          public ASP()
          {
            List<int> x = new List<int>();
            x.Add(1);
            x.Add(2);
            x.Add(6);
            x.Add(7);
            x.Add(11);
            x.Add(12);

            int count = 1;

            while (count != 4 + 1)
            {
                int count2 = 1;
                while (count2 != 3 + 1 ) //1 != 4 (1); 2 != 4 (2) ; 3 != 4 (3); 4 != 4 X
                {
                    string y = "";
                    foreach (int z in x)
                    { 
                        y = y + z.ToString() + ",";
                    }
                    IWC.AnySixPack.Add(","+y);
 
                    x[0] = x[0] + 5;
                    x[1] = x[1] + 5;
                    x[2] = x[2] + 5;
                    x[3] = x[3] + 5;
                    x[4] = x[4] + 5;
                    x[5] = x[5] + 5;

                    count2 = count2 + 1;
                }
                x[0] = x[0] - 15 + 1;
                x[1] = x[1] - 15 + 1;
                x[2] = x[2] - 15 + 1;
                x[3] = x[3] - 15 + 1;
                x[4] = x[4] - 15 + 1;
                x[5] = x[5] - 15  + 1;  

                count = count + 1;
            }


            x[0] = 1;
            x[1] = 2;
            x[2] = 3;
            x[3] = 6;
            x[4] = 7;
            x[5] = 8;

            count = 1;
            while (count != 3 + 1)
            {
                int count2 = 1;
                while (count2 != 4 + 1) //1 != 4 (1); 2 != 4 (2) ; 3 != 4 (3); 4 != 4 X
                {
                    string y = "";
                    foreach (int z in x)
                    {
                        y = y + z.ToString() + ",";
                    }
                    IWC.AnySixPack.Add(","+y);

                    x[0] = x[0] + 5;
                    x[1] = x[1] + 5;
                    x[2] = x[2] + 5;
                    x[3] = x[3] + 5;
                    x[4] = x[4] + 5;
                    x[5] = x[5] + 5;

                    count2 = count2 + 1;
                }
                x[0] = x[0] - 20 + 1;
                x[1] = x[1] - 20 + 1;
                x[2] = x[2] - 20 + 1;
                x[3] = x[3] - 20 + 1;
                x[4] = x[4] - 20 + 1;
                x[5] = x[5] - 20 + 1;

                count = count + 1;
            }
          }
        }
        

    class IWC
    {
        public static string WinPattern = "";
        public static bool Result;

        public static string[] TinyPyramid = new string[]//3 mask
        {
            ",3,7,8,13,",
            ",8,12,13,18,",
            ",13,17,18,23,"
        };

        public static string[] AnyLines = new string[]//12 mask
        {
            ",1,2,3,4,5,",//anyLine_pattern1
            ",6,7,8,9,10,",//anyLine_pattern2
            ",11,12,13,14,15,",//anyLine_pattern3
            ",16,17,18,19,20,",//anyLine_pattern4
            ",21,22,23,24,25,",//anyLine_pattern5
            ",1,6,11,16,21,",//anyLine_pattern6
            ",2,7,12,17,22,",//anyLine_pattern7
            ",3,8,13,18,23,",//anyLine_pattern8
            ",4,9,14,19,24,",//anyLine_pattern9
            ",5,10,15,20,25,",//anyLine_pattern10
            ",1,7,13,19,25,",//11
            ",5,9,13,17,21,"//12
        };

        public static string[] CrazyStamps = new string[]//3 mask
        {
            ",1,2,6,7,",
            ",16,17,21,22,",
            ",4,5,9,10,",
            ",19,20,24,25,"
        };

        public static List<string> AnySixPack = new List<string>();


        public static string[] FourCorners = new string[]
        {
            ",1,5,21,25,"
        };

        public static string[] SmallX = new string[]
        {
            ",7,9,13,17,19,"
        };

        public static string[] Flower = new string[]
        {
            ",8,12,13,14,18,"
        };

        public static string[] Star = new string[]
        {
            ",3,11,13,15,23,"
        };

        public static List<string> Pyramid = new List<string>();

        public static string[] Steps = new string[]
        {
            ",1,2,7,8,13,14,19,20,25,",
            ",5,9,10,13,14,17,18,21,22,"
        };

        public static string[] Sun = new string[]
        {
            ",2,4,6,7,9,10,13,16,17,19,20,22,24,"
        };

        public static string[] GreatPyramid = new string[]
        {
            ",5,8,9,10,11,12,13,14,15,18,19,20,25,"
        };

        public static bool IWC_(string NDubbed)
        {


            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            bool result = false;
            bool _result;


                if (result == false)
                {
                    foreach (string patterns in TinyPyramid)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {
                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Tiny Pyramid";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Tiny Pyramid";
                            }
                            result = _result;
                           // break;
                        }
                    }
                }


                if (result == false)
                {
                    foreach (string patterns in AnyLines)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }
                        if (_result == true)
                        {
                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Any Line";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Any Line";
                            }
                            result = _result;
                          //  break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in CrazyStamps)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Crazy Stamp";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Crazy Stamp";
                            }
                            result = _result;
                         //   break;
                        }
                    }
                }

                if (result == false)
                {
                    ASP asp = new ASP();
                    foreach (string patterns in AnySixPack)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Any Six Pack";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Any Sick Pack";
                            }
                            result = _result;
                           // break;
                        }
                    }
                }


                if (result == false)
                {
                    foreach (string patterns in FourCorners)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Four Corners";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Four Corners";
                            }
                            result = _result;
                         //   break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in SmallX)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {
                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Small X";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Small X";
                            }
                            result = _result;
                          //  break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in Flower)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Flower";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Flower";
                            }
                            result = _result;
                       //     break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in Star)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Star";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Star";
                            }
                            result = _result;
                          //  break;
                        }
                    }
                }

                if (result == false)
                {
                    Pyramid_ p = new Pyramid_();
                    foreach (string patterns in Pyramid)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Pyramid";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Pyramid";
                            }
                            result = _result;
                         //   break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in Steps)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Steps";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Steps";
                            }
                            result = _result;
                        //    break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in Sun)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Sun";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Sun";
                            }
                            result = _result;
                           // break;
                        }
                    }
                }

                if (result == false)
                {
                    foreach (string patterns in GreatPyramid)
                    {
                        _result = false;
                        using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckCardIfWin(@DubbedN, @Pattern)", sc))
                        {
                            cmd.Parameters.AddWithValue("DubbedN", NDubbed);
                            cmd.Parameters.AddWithValue("Pattern", patterns);
                            _result = Convert.ToBoolean(cmd.ExecuteScalar());
                        }

                        if (_result == true)
                        {

                            if (WinPattern.Length > 1)
                            {
                                WinPattern = WinPattern + " ,Great Pyramid";
                            }
                            else
                            {
                                WinPattern = WinPattern + "Great Pyramid";
                            }
                            result = _result;
                         //   break;
                        }
                    }
                }
            

            Result = result;
            return result;
        }
    }
}
