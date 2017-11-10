using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace GameTech.B3Reports
{
    //NOT USE
    class SetNDSettings
    {
        private bool m_SalesMode;
        private int m_PlayerPinLength;

        public bool SalesMode
        {
            get { return m_SalesMode; }
            set { m_SalesMode = value; }
        }

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
                using (SqlCommand cmd = new SqlCommand(@"usp_management_SystemSettings_SetNDSettings
                                                        @SalesMode,
                                                        @PlayerPinLength ", sc))
                {
                    cmd.Parameters.AddWithValue("SalesMode", m_SalesMode);
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
