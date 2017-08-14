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

    public class PatternPayTable
    {
        public string PatterName;
        public int Pay;
        public int NH;
    }

    public class ListPatternPayTable
    {
        public static List<PatternPayTable> listpatternpaytable = new List<PatternPayTable>();
    }

    public class GetPatternBonusPayTable
    {
        SqlConnection sc = GetSQLConnection.get();

        public GetPatternBonusPayTable(int Denom, string GameName)
        {
            ListPatternPayTable.listpatternpaytable.Clear();

            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(
                    @"exec usp_management_DisputeResolution_GetPatternBonusPayTable
                    @spDenom = @Denom,
                    @spGameName = @GameName        
                    ",sc))
                {
                    cmd.Parameters.AddWithValue("Denom", Denom);
                    cmd.Parameters.AddWithValue("GameName", GameName);

                    int count = 1;

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        PatternPayTable ppt = new PatternPayTable();
                        ppt.PatterName = reader.GetString(0);
                        ppt.Pay = reader.GetInt32(1);

                        if (count == 1)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_1;
                        }
                        else if (count == 2)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_2;
                        }
                        else if (count == 3)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_3;
                        }
                        else if (count == 4)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_4;
                        }
                        else if (count == 5)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_5;
                        }
                        else if (count == 6)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_6;
                        }
                        else if (count == 7)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_7;
                        }
                        else if (count == 8)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_8;
                        }
                        else if (count == 9)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_9;
                        }
                        else if (count == 10)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_10;
                        }
                        else if (count == 11)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_11;
                        }
                        else if (count == 12)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_12;
                        }

                        count = count + 1;
                        ListPatternPayTable.listpatternpaytable.Add(ppt);
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


    public class GetPatternPayTable
    {
        SqlConnection sc = GetSQLConnection.get();
       
        public GetPatternPayTable(int Denom, string GameName)
        {
            ListPatternPayTable.listpatternpaytable.Clear();

            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(
                    @"exec usp_management_DisputeResolution_GetPatternPayTable
                    @spDenom = @Denom,
                    @spGameName = @GameName        
                    ",sc))
                {
                    cmd.Parameters.AddWithValue("Denom", Denom);
                    cmd.Parameters.AddWithValue("GameName", GameName);

                    int count = 1;

                    SqlDataReader reader = cmd.ExecuteReader();
                    bool IsCoverAll = true;
                    while (reader.Read())
                    {
                        PatternPayTable ppt = new PatternPayTable();
                        ppt.PatterName = reader.GetString(0);
                        ppt.Pay = reader.GetInt32(1);

                        if (count == 1)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_1;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 2)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_2;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 3)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_3;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 4)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_4;
                             if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 5)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_5;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 6)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_6;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 7)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_7;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 8)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_8;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 9)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_9;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 10)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_10;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 11)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_11;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 12)
                        {
                            ppt.NH = GetNWinningPattern.Pattern_Num_12;
                            if (ppt.NH != 0) { IsCoverAll = false; }
                        }
                        else if (count == 13)
                        {
                            if (IsCoverAll == true)
                            {
                                ppt.NH = GetNWinningPattern.Pattern_Num_13;
                            }
                            else
                            {
                                ppt.NH = 0;
                            }
                        }

                        count = count + 1;

                        ListPatternPayTable.listpatternpaytable.Add(ppt);
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
