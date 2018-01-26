using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace GameTech.B3Reports
{
    class RecoverOrphanedAccount
    {
        public static RecoverAccountStatus Recover(int accountNumber)
        {
            var status = RecoverAccountStatus.UnknownError;
            SqlConnection sc = GetSQLConnection.get();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_server_RecoverOrphanedAccount
                                                        @creditAccount"
                                                        , sc))
                {
                    cmd.Parameters.AddWithValue("creditAccount", accountNumber);
                    cmd.ExecuteNonQuery();

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var value = reader.GetInt32(0);
                        
                        if (value >= 0 && value <= 3)
                        {
                            status = (RecoverAccountStatus) value;
                        }
                        else
                        {
                            status = RecoverAccountStatus.UnknownError;
                        }
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

            return status;
        }
    }

    public enum RecoverAccountStatus
    {
        Success = 0,
        NoActiveSession = 1,
        ReceiptHasAlreadyBeenRedeemed = 2,
        UnknownError = 3,
        AccountNotOrphaned = 4
    }
}
