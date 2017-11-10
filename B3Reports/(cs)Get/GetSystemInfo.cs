using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace GameTech.B3Reports._cs_Get
{
    class GetSystemInfo
    {
        //Get Sql User 
        //Hash sql password


        SqlConnection sc;
        public GetSystemInfo()
        {
              sc = new SqlConnection(Properties.Resources.SQLConnection);
              ServerName = GetServerName();
        }

         private string GetServerName()
        {
            string serverName = "";
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"SELECT SERVERPROPERTY('ServerName') AS [ServerInstanceName]", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        User usersingledata = new User();
                        serverName = reader.GetString(0);                      
                    }
                }
                sc.Close();
              
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return serverName;

        }

        public string ServerName { get; set; }
    }
}


