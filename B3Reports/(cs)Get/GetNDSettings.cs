using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace GameTech.B3Reports
{
    //NOT USE
    class GetNDSettings
    {
        private bool m_SalesMode;
        private int m_PayerPinLength;

        public bool SalesMode
        {
            get { return m_SalesMode; }
            set { m_SalesMode = value; }
        }

        public int PlayerPinLength
        {
            get { return m_PayerPinLength; }
            set { m_PayerPinLength = value; }
        }

        public GetNDSettings()
        {
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                //The SP will be deleted.  Do not use this SP. 
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SystemSettings_GetNDSettings", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        m_SalesMode = reader.GetBoolean(0);
                        m_PayerPinLength = reader.GetInt32(1);                       
                    }
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
