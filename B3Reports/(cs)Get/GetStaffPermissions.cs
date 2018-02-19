using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace GameTech.B3Reports
{
    public class StaffPermissionsList//DataSource in DataGrid view.
    {
        public static List<StaffPermissions> PermissionList = new List<StaffPermissions>();
    }

    //public class OrigStaffPermissionList //Will compared whenever a field in the datagridview is change.
    //{
    //    public static List<StaffPermissions> PermissionList = new List<StaffPermissions>();
    //}

    public class StaffPermissions
    {
        public string Permissions  { get; set; }
        public bool Allow  { get; set; } //Should we assign it as a bool or string?
    }

    public class StaffManagementPermisions
    {
        public bool MgmtSecurity;
        public bool MgmtSystemSettings;
        public bool MgmtDisputeResolution;
        public bool MgmtReports;
        public bool AccountRecovery;

    }

    public class GetStaffMgmtPermissions
    {
        SqlConnection sc = GetSQLConnection.get();



        //public static bool NDSettingsPermission(int LoginID)
        //{
        //    SqlConnection sc2 = GetSQLConnection.get();
        //    string sqlResult = "F";
        //    try
        //    {
        //        sc2.Open();//a select command that will return char or string
        //        using (SqlCommand cmd = new SqlCommand("select [ND Settings] from [dbo].[B3_Login] where LoginID =  @LoginID", sc2))
        //        {
        //            cmd.Parameters.AddWithValue("@LoginID", LoginID);
        //            sqlResult = cmd.ExecuteScalar().ToString();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show(ex.Message);
        //    }
        //    finally
        //    {
        //        sc2.Close();
        //    }

        //    bool result = false;
        //    if (sqlResult == "T")
        //    {
        //        result = true;
        //    }
        //    else
        //    {
        //        result = false;
        //    }

        //    return result;
        //}

        public static bool UserAccessPermission(int LoginID)
        {
            SqlConnection sc2 = GetSQLConnection.get();
            string sqlResult = "F";
            try
            {
                sc2.Open();//a select command that will return char or string
                using (SqlCommand cmd = new SqlCommand("select PermitClientAccessControl from [dbo].[B3_Login] where LoginID =  @LoginID", sc2))
                {
                    cmd.Parameters.AddWithValue("@LoginID", LoginID);
                    sqlResult = cmd.ExecuteScalar().ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sc2.Close();
            }

            bool result = false;
            if (sqlResult == "T")
            {
                result = true;
            }
            else
            {
                result = false;
            }

            return result;
        }


        public StaffManagementPermisions GetMgmtStaffPermissions(int LoginID)
        {
            StaffManagementPermisions Smp = new StaffManagementPermisions();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SecuritySettings_GetMgmtPermissions @LoginId_sp =  @LoginID", sc))
                {
                    cmd.Parameters.AddWithValue("LoginID", LoginID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {


                        string tempPermission = reader.GetString(0);
                        if (tempPermission == "T")
                        {
                            Smp.MgmtSecurity = true;
                        }
                        else
                        {
                            Smp.MgmtSecurity = false;
                        }

                        tempPermission = reader.GetString(1);
                        if (tempPermission == "T")
                        {
                            Smp.MgmtSystemSettings = true;
                        }
                        else
                        {
                            Smp.MgmtSystemSettings = false;
                        }

                        tempPermission = reader.GetString(2);
                        if (tempPermission == "T")
                        {
                            Smp.MgmtDisputeResolution = true;
                        }
                        else
                        {
                            Smp.MgmtDisputeResolution = false;
                        }

                        tempPermission = reader.GetString(3);
                        if (tempPermission == "T")
                        {
                            Smp.MgmtReports = true;
                        }
                        else
                        {
                            Smp.MgmtReports = false;
                        }

                        tempPermission = reader.GetString(4);
                        if (tempPermission == "T")
                        {
                            Smp.AccountRecovery = true;
                        }
                        else
                        {
                            Smp.AccountRecovery = false;
                        }

                    }
                }
                sc.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return Smp;
        }
    }


    public class GetStaffPermissions
    {
        SqlConnection sc = GetSQLConnection.get();

        public  List<StaffPermissions> GetStaffPermissions_(int LoginID)
        {

            StaffPermissionsList.PermissionList.Clear();

            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SecuritySettings_GetStaffPermissions @LoginId_sp =  @LoginID", sc))
                {
                    cmd.Parameters.AddWithValue("LoginID", LoginID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        StaffPermissions StaffPermissions_ = new StaffPermissions();
                        StaffPermissions_.Permissions = reader.GetString(0);
                        string tempAllow = reader.GetString(1);
                        if (tempAllow == "T")
                        {
                            StaffPermissions_.Allow = true;
                        }
                        else
                        {
                            StaffPermissions_.Allow = false;
                        }
                        StaffPermissionsList.PermissionList.Add(StaffPermissions_);
                        //OrigStaffPermissionList.PermissionList.Add(StaffPermissions_);
                    }
                }
                sc.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return StaffPermissionsList.PermissionList;
        }
    }

    //===========================================


    public class StaffPermissionsList2//DataSource in DataGrid view.
    {
        public static List<StaffPermissions> PermissionList2 = new List<StaffPermissions>();
    }

    public class GetStaffPermissions2
    {
        SqlConnection sc = GetSQLConnection.get();

        public List<StaffPermissions> GetStaffPermissions2_(int LoginID)
        {

            StaffPermissionsList2.PermissionList2.Clear();

            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SecuritySettings_GetStaffPermissions @LoginId_sp =  @LoginID", sc))
                {
                    cmd.Parameters.AddWithValue("LoginID", LoginID);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        StaffPermissions StaffPermissions_ = new StaffPermissions();
                        StaffPermissions_.Permissions = reader.GetString(0);
                        string tempAllow = reader.GetString(1);
                        if (tempAllow == "T")
                        {
                            StaffPermissions_.Allow = true;
                        }
                        else
                        {
                            StaffPermissions_.Allow = false;
                        }
                        StaffPermissionsList2.PermissionList2.Add(StaffPermissions_);
                        //OrigStaffPermissionList.PermissionList.Add(StaffPermissions_);
                    }
                }
                sc.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return StaffPermissionsList2.PermissionList2;
        }
    }

}
