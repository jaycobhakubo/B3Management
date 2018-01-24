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
    class GetAvailableGames
    {
        public static List<B3GamesInfo> GamesList
        {
            get
            {
                var b3GameInfo = new List<B3GamesInfo>();
                SqlConnection sc = GetSQLConnection.get();
                try
                {
                    sc.Open();
                    using (SqlCommand cmd = new SqlCommand(@"exec usp_management_GetAvailableGames", sc))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var game = new B3GamesInfo
                            {
                                Id = reader.GetInt32(0),
                                GameIconName = (GameIconNameEnum)Enum.Parse(typeof(GameIconNameEnum), reader.GetString(1), true),
                                DisplayName = reader.GetString(2)
                            };

                            b3GameInfo.Add(game);
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

                return b3GameInfo;
            }
        }

        public static bool IsCrazyBoutEnabled { get; set; }
        public static bool IsJailBreakEnabled { get; set; }
        public static bool IsMayaMoneyEnabled { get; set; }
        public static bool IsWildBallEnabled { get; set; }
        public static bool IsSpirit76Enabled { get; set; }
        public static bool IsTimeBombEnabled { get; set; }
    }
}
