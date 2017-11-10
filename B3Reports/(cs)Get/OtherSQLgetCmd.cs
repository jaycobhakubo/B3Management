using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Windows.Forms;


namespace GameTech.B3Reports._cs_Get
{
    public class OtherSQLgetCmd
    {
       private static SqlConnection sc = GetSQLConnection.get();
       private static bool result;
       private static bool success;

        public static bool ServerOk()
        {
            using (SqlConnection scon = GetSQLConnection.get())
            {             
                try
                {
                    scon.Open();
                    result = true;
                }
                catch
                {
                    result = false;
                }
                finally
                {
                    scon.Close();
                }
                return result;
            }
        }

        public static void UnlockUser(int UserLoginID)
        {
            try
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand("Update b3_Login set lockedDueToLoginFailedAttempt = 'F', Locked = 'F'  where loginID = " + UserLoginID, sc);
                cmd.ExecuteNonQuery();
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

        public static bool LockUserForTooManyLoginAttempts(string userName)
        {
            success = false;
            
                                try
                                {
                                    sc.Open();
                                    SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]
                                                                                set Locked = 'T'
                                                                                ,NofLoginAttempt = 0
                                                                                ,LockedDueToLoginFailedAttempt = 'T'
                                                                                , LockedDueToAttemptTime = '" + DateTime.Now + @"' " + @"
                                                                                where LoginID = " + CurrentLoginID.LoginID, sc);
                                    cmd.ExecuteNonQuery();
                                    WriteLog.WriteLog_("", userName, "Account is locked", GetCurrentMacID.MacAddress, "");

                                    success = true;
                               
                                }
                                catch (Exception ex)
                                {
                                    MessageBox.Show(ex.Message);
                                }
                                finally
                                {
                                    sc.Close();
                                }
                                return success;
        }


        public static void AddNAttemptLogin(int nOfAttemptLogin, string userName)
        {
            try
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]
                                                                          set NofLoginAttempt = " + nOfAttemptLogin + " ,LockedDueToAttemptTime = getdate() where UserName = '" + userName + "'", sc);
                cmd.ExecuteNonQuery();
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

        public static bool AddNAttemptLoginV2()
        {
            success = false;
            try
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]
                                                                          set NofLoginAttempt = ISnull(NofLoginAttempt + " + 1 + @", 1)  
                                                                          ,LockedDueToAttemptTime = getdate()
                                                                          where LoginID = " + CurrentLoginID.LoginID, sc);
                cmd.ExecuteNonQuery();
                success = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sc.Close();
            }

            return success;
        }



        public static void UpdateUserForAutoUnlocking()
        {
            try
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand("exec usp_b3Login_UpdateUserForAutoUnlocking", sc);
                cmd.ExecuteNonQuery();
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

        public static bool UserExists(string UserName)
        {
            
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand("select count(*) from dbo.B3_Login where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", UserName);
                    result = (int)cmd.ExecuteScalar() > 0;
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                sc.Close();
            }
            return result;
        }

        public static bool PasswordOk(bool IsUserAlreadyExists, string UserName, string PassWord)
        {
            sc.Open();
            result = false;
            if (IsUserAlreadyExists == true)//This will always be false
            {

                using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                    from dbo.B3_Login 
                    where UserName = @UserName and 
                    [UserPassword] COLLATE SQL_Latin1_General_CP1_CS_AS = @UserPassword", sc))//Password is case sensitive
                {
                    cmd.Parameters.AddWithValue("UserName", UserName);
                    cmd.Parameters.AddWithValue("UserPassword", PassWord);
                    result = (int)cmd.ExecuteScalar() == 1;
                }

            }
            sc.Close();
            return result;
        }

        public static bool IsTheUserlocked(string userName)
        {

            //Get the status of the is user if its locked or unlocked
            result = true;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*)
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName  and Locked = 'T'", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    result = (int)cmd.ExecuteScalar() > 0;
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
            return result;
        }

        public static bool IsTheUserActive(string userName)
        {
           result = false;
         
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*)
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName  and EnableUser = 'T'", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    result = (int)cmd.ExecuteScalar() > 0;//changing the variable to IsUserActive
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

            return result;
        }

        public static bool PasswordExpired(string userName)
        {
            result = false;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckPassordExpDate(@UserName)", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    result = Convert.ToBoolean(cmd.ExecuteScalar());
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
            return result;
        }

        public static void ResetLoginAttempt(int UserLoginID)
        {

            try
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]                                                                               
                                                 set NofLoginAttempt = 0 where LoginID = " + UserLoginID, sc);
                cmd.ExecuteNonQuery();
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
