using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace GameTech.B3Reports
{
    class SetActiveGames
    {
        public static void Set(List<string> activeGameList)
        {
            string[] gamesArray = new string[12];

            Array.Copy(activeGameList.ToArray(), 0, gamesArray, 0, activeGameList.Count);

            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SetActiveGames
                                                        @gameicon_1
                                                        ,@gameicon_2
                                                        ,@gameicon_3
                                                        ,@gameicon_4
                                                        ,@gameicon_5
                                                        ,@gameicon_6
                                                        ,@gameicon_7
                                                        ,@gameicon_8
                                                        ,@gameicon_9
                                                        ,@gameicon_10
                                                        ,@gameicon_11
                                                        ,@gameicon_12"
                                                        , sc))
                {
                    cmd.Parameters.AddWithValue("gameicon_1", string.IsNullOrEmpty(gamesArray[0]) ? string.Empty : gamesArray[0]);
                    cmd.Parameters.AddWithValue("gameicon_2", string.IsNullOrEmpty(gamesArray[1]) ? string.Empty : gamesArray[1]);
                    cmd.Parameters.AddWithValue("gameicon_3", string.IsNullOrEmpty(gamesArray[2]) ? string.Empty : gamesArray[2]);
                    cmd.Parameters.AddWithValue("gameicon_4", string.IsNullOrEmpty(gamesArray[3]) ? string.Empty : gamesArray[3]);
                    cmd.Parameters.AddWithValue("gameicon_5", string.IsNullOrEmpty(gamesArray[4]) ? string.Empty : gamesArray[4]);
                    cmd.Parameters.AddWithValue("gameicon_6", string.IsNullOrEmpty(gamesArray[5]) ? string.Empty : gamesArray[5]);
                    cmd.Parameters.AddWithValue("gameicon_7", string.IsNullOrEmpty(gamesArray[6]) ? string.Empty : gamesArray[6]);
                    cmd.Parameters.AddWithValue("gameicon_8", string.IsNullOrEmpty(gamesArray[7]) ? string.Empty : gamesArray[7]);
                    cmd.Parameters.AddWithValue("gameicon_9", string.IsNullOrEmpty(gamesArray[8]) ? string.Empty : gamesArray[8]);
                    cmd.Parameters.AddWithValue("gameicon_10", string.IsNullOrEmpty(gamesArray[9]) ? string.Empty : gamesArray[9]);
                    cmd.Parameters.AddWithValue("gameicon_11", string.IsNullOrEmpty(gamesArray[10]) ? string.Empty : gamesArray[10]);
                    cmd.Parameters.AddWithValue("gameicon_12", string.IsNullOrEmpty(gamesArray[11]) ? string.Empty : gamesArray[11]);
                    cmd.ExecuteNonQuery(); //or you could try this if did not work                 
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
