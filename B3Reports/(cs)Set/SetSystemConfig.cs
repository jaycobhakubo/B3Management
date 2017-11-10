using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace GameTech.B3Reports
{
    class SetSystemConfig
    {

        private int m_PlayerPinLength;

        public int PlayerPinLength
        {
            get { return m_PlayerPinLength; }
            set { m_PlayerPinLength = value; }
        }

        public void RunSQL()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                //usp_management_SetSystemConfigSettings
                using (SqlCommand cmd = new SqlCommand(@"usp_management_SetSystemConfigSettings                                         
                                                        @PlayerPinLength ", sc))
                {
                    cmd.Parameters.AddWithValue("PlayerPinLength", m_PlayerPinLength);

                    cmd.ExecuteNonQuery();
                }

            }
            catch (Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
            finally
            {
                sc.Close();
            }
        }
    }
}
