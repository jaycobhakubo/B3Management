using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace GameTech.B3Reports
{
    public class GetSQLConnection
    {
        public static SqlConnection get()
        {
            SqlConnection sc = new SqlConnection(Properties.Resources.SQLConnection);
            return sc;
        }
    }
}
