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
using GameTech.B3Reports._cs_Other;


namespace GameTech.B3Reports
{
    class GetActiveGames
    {
        public static List<string> B3ActiveGamesList
        {
            get
            {
                var b3ActiveGames = new List<string>();

                SqlConnection sc = GetSQLConnection.get();
                try
                {
                    sc.Open();
                    using (SqlCommand cmd = new SqlCommand(@"exec usp_management_GetActiveGames", sc))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            for (int i = 0; i < 12; i++)
                            {
                                var gameIconName = reader.GetString(i);

                                if (string.IsNullOrEmpty(gameIconName))
                                {
                                    continue;
                                }
                                b3ActiveGames.Add(gameIconName);
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

                return b3ActiveGames;
            }
        }
    }
}
