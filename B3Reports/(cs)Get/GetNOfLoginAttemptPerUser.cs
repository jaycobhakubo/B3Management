//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.SqlTypes;

namespace GameTech.B3Reports
{
    class  GetNOfLoginAttemptPerUser
    {
        public static int nLoginAttempt;

        public int Get(string userName)
        {
            int N = 0;
            
            //Lets ge the LoginID instead 
            GetCurrentIDPerUser x = new GetCurrentIDPerUser();
            int LoginID = x.Get(userName);

            SqlConnection sc = GetSQLConnection.get();
            sc.Open();
            try
            {
                using (SqlCommand cmd = new SqlCommand(@"select [dbo].[B3_fnGetNAttemptLogin](@spLoginID)", sc))           
                {
                    cmd.Parameters.AddWithValue("spLoginID", LoginID);
                    N = (int)cmd.ExecuteScalar();

                    //if its 0 then lets update the db
                    SqlCommand cmd2 = new SqlCommand("Update dbo.B3_Login set NOfLoginAttempt = 0 where LoginID = " + LoginID , sc);
                    cmd2.ExecuteNonQuery();

                    /* --> I dont think this is supported in SQL 2005 
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@spLoginID", LoginID);
                    SqlParameter outPutParameter = new SqlParameter();
                    outPutParameter.ParameterName = "@spNoOfAttempt";
                    outPutParameter.SqlDbType = System.Data.SqlDbType.Int;
                    outPutParameter.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(outPutParameter);
                    cmd.ExecuteNonQuery();
                    string Test = outPutParameter.Value.ToString();
                    */
                   //cmd.Parameters.AddWithValue("UserName", userName);
                   // N = (int)cmd.ExecuteScalar();
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
            nLoginAttempt = N; 
            return N; 
        }

    }
}
