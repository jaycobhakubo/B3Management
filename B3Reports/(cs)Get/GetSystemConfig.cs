using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace GameTech.B3Reports
{
    class GetSystemConfig
    {
        private bool m_IsND;
        private int m_PinPlayerLen;

        public int PinPlayerLen
        {
            get { return m_PinPlayerLen; }
            set { m_PinPlayerLen = value; }
        }

        public bool IsND
        {
            get { return m_IsND; }
            set { m_IsND = value; }
        }

        public GetSystemConfig()
        {
            m_IsND = false;
            m_PinPlayerLen = 0;

            //US4393 Disable the PIN length setting 
            
            //SqlConnection sc = GetSQLConnection.get();
            //try
            //{
            //    sc.Open();
            //    using (SqlCommand cmd = new SqlCommand(@"exec usp_management_GetSystemConfigSettings", sc))
            //    {
            //        SqlDataReader reader = cmd.ExecuteReader();
            //        while (reader.Read())
            //        {
            //            if (reader.GetString(0) == "T")
            //            {
            //                m_IsND = true;
            //            }
            //            else
            //            {
            //                m_IsND = false;
            //            }

            //            m_PinPlayerLen = reader.GetInt32(1);
            //        }

                   

            //    }
            //}
            //catch
            //{

            //}
            //finally
            //{
            //    sc.Close();
            //}

        }
    }
}
