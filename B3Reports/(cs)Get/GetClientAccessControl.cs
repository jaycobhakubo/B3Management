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
using System.Data.SqlTypes;

namespace GameTech.B3Reports
{
    public class ListClientMap
    {
        public static BindingList<ClientMapColumns> ListClientMap_ = new BindingList<ClientMapColumns>();
    }

    public class ClientMapColumns
    {
        public int ClientID {get; set;}
        public string MACAddress { get; set; }
        public string IPAddress { get; set; }
        public string ClientType { get; set; }
        public bool ClientEnabled { get; set; }
        public DateTime FirstSignIn { get; set; }
    }


    public class GetClientAccessControl
    {
        SqlConnection sc = GetSQLConnection.get();
        public BindingList<ClientMapColumns> GetClientAccessControl_()
        {
            ListClientMap.ListClientMap_.Clear();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_GetClientMap", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ClientMapColumns ClientMapColumns_ = new ClientMapColumns();
                        ClientMapColumns_.ClientID = reader.GetInt32(0);
                        ClientMapColumns_.MACAddress = reader.GetString(1);
                        ClientMapColumns_.IPAddress = reader.GetString(2);
                        ClientMapColumns_.ClientType = reader.GetString(3);
                        string TempClientEnable = reader.GetString(4);

                        if (TempClientEnable == "T")
                        {
                            ClientMapColumns_.ClientEnabled = true;

                        }
                        else
                        {
                            ClientMapColumns_.ClientEnabled = false;
                        }
                        ClientMapColumns_.FirstSignIn = reader.GetDateTime(5);
                        ListClientMap.ListClientMap_.Add(ClientMapColumns_);
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
            return ListClientMap.ListClientMap_;
        }

    }

    public class ListClientMapSet
    {
        public static List<ClientMapColumns> ListClientMapSet_ = new List<ClientMapColumns>();
    }


    public class SetClientAccessControl
    {
        SqlConnection sc = GetSQLConnection.get();
        public List<ClientMapColumns> SetClientAccessControl_()
        {
            ListClientMapSet.ListClientMapSet_.Clear();
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_GetClientMap", sc))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ClientMapColumns ClientMapColumns_ = new ClientMapColumns();
                        ClientMapColumns_.ClientID = reader.GetInt32(0);
                        ClientMapColumns_.MACAddress = reader.GetString(1);
                        ClientMapColumns_.IPAddress = reader.GetString(2);
                        ClientMapColumns_.ClientType = reader.GetString(3);
                        string TempClientEnable = reader.GetString(4);
                        if (TempClientEnable == "T")
                        {
                            ClientMapColumns_.ClientEnabled = true;

                        }
                        else
                        {
                            ClientMapColumns_.ClientEnabled = false;
                        }
                        ClientMapColumns_.FirstSignIn = reader.GetDateTime(5);
                        ListClientMapSet.ListClientMapSet_.Add(ClientMapColumns_);
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
            return ListClientMapSet.ListClientMapSet_;
        }

        public void SetClientAccessControl_(int ClientID_, string ClientEnabled_)
        {
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_SetClientAccessState
                                                        @clientId 
                                                        , @clientEnabled"
                                                        , sc))
                {
                    cmd.Parameters.AddWithValue("clientId", ClientID_);
                    cmd.Parameters.AddWithValue("clientEnabled", ClientEnabled_); //GetSecuritySettings.PrevPasswordReuseN);
                    cmd.ExecuteNonQuery(); //or you could try this if did not work                 
                }
            }
            catch(Exception ex)
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
