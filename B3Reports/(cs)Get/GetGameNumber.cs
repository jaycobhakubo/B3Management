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
    public class gamenumber
    {
        public int gamenum;
        public int sgamenum;
    }

    public class listgamenumber
    {
       public static List<gamenumber> lgamenumber = new List<gamenumber>(); 
    }

   public  class GetGameNumber
    {
         SqlConnection sc = GetSQLConnection.get();
         public GetGameNumber(int AccountNumber, string B4GamesSelected)
         {
             listgamenumber.lgamenumber.Clear();
             try
             {
                 sc.Open();
                 using (SqlCommand cmd = new SqlCommand(
                     @"exec usp_management_DisputeResolution_GetGameNumStart @spCreditAccountNumber  = @AccountNumber,
                                                           @spB4Games = @SelectedB4Game ", sc))
                 {
                     cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                     cmd.Parameters.AddWithValue("SelectedB4Game", B4GamesSelected);
                     SqlDataReader reader = cmd.ExecuteReader();
                     while (reader.Read())
                     {
                         gamenumber gn = new gamenumber();
                         gn.gamenum = reader.GetInt32(0);
                         gn.sgamenum = reader.GetInt32(1);
                         listgamenumber.lgamenumber.Add(gn);
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
