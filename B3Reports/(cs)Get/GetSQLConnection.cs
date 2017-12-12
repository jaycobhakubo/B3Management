using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports
{
    public class GetSQLConnection
    {
        public static SqlConnection get()
        {
            //SqlConnection sc = new SqlConnection(Properties.Resources.SQLConnection);
            SqlConnection sc = new SqlConnection(B3DatabaseConnection.GetConnectionString);
            return sc;
        }
    }
}
