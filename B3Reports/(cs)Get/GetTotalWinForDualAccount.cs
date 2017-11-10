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
    public class GetTotalWinForDualAccount
    {
        public static int TotalWinForDA;

        public static int getTotalWinForDualAccount(int AcctNumber, string B4Games, DateTime? GameNumber)
        {
            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            int result = 0;

            try
            {
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetAmountWinForDoubleAccounting
                                                        @spAcctNumber = @AcctNumber,
                                                        @spB4Games = @B4Games,
                                                        @spGameNumber = @GameNumber", sc))
                {
                    cmd.Parameters.AddWithValue("AcctNumber", AcctNumber);
                    cmd.Parameters.AddWithValue("B4Games", B4Games);
                    cmd.Parameters.AddWithValue("GameNumber", GameNumber);
                    result = (int)cmd.ExecuteScalar();
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


            TotalWinForDA = result;
            return result;

        }
    }
}
