using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace GameTech.B3Reports.Forms
{
    public partial class ClientAccessControl : SettingsControl
    {
        bool result_;
        BindingList<ClientMapColumns> lcp;

        public ClientAccessControl()
        {
            InitializeComponent();
            LoadSettings();

   

            //dgClientAccess.AutoGenerateColumns = false;
            //dgClientAccess.AllowUserToAddRows = false;

            DataGridViewTextBoxColumn column1 = new DataGridViewTextBoxColumn();
            //column1.Name = "ClientID";
            //column1.HeaderText = "ClientID";
            //column1.DataPropertyName = "ClientID";
            //column1.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            ////column1.DefaultCellStyle.BackColor = Color.Black;
            //column1.SortMode = DataGridViewColumnSortMode.NotSortable;
            //column1.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.Width = 200;
            //column1.ReadOnly = true;
            //dgClientAccess.Columns.Add(column1);

            column1 = new DataGridViewTextBoxColumn();
            column1.Name = "MACAddress";
            column1.HeaderText = "MAC Address";
            column1.DataPropertyName = "MACAddress";
            column1.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.DefaultCellStyle.BackColor = Color.Black;
            column1.SortMode = DataGridViewColumnSortMode.NotSortable;
            column1.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            column1.Width = 200;
            column1.ReadOnly = true;
            dgClientAccess.Columns.Add(column1);

            DataGridViewTextBoxColumn column2 = new DataGridViewTextBoxColumn();
            column2.Name = "IPAddress";
            column2.HeaderText = "IP Address";
            column2.DataPropertyName = "IPAddress";
            column2.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.DefaultCellStyle.BackColor = Color.Black;
            column2.SortMode = DataGridViewColumnSortMode.NotSortable;
            column2.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            column2.Width = 200;
            column2.ReadOnly = true;
            dgClientAccess.Columns.Add(column2);

            column2 = new DataGridViewTextBoxColumn();
            column2.Name = "ClientType";
            column2.HeaderText = "Client Type";
            column2.DataPropertyName = "ClientType";
            column2.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.DefaultCellStyle.BackColor = Color.Black;
            column2.SortMode = DataGridViewColumnSortMode.NotSortable;
            column2.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            column2.Width = 200;
            column2.ReadOnly = true;
            dgClientAccess.Columns.Add(column2);


            DataGridViewCheckBoxColumn chk = new DataGridViewCheckBoxColumn();
            chk.HeaderText = "Client Enabled";
            chk.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleCenter;
            chk.Name = "ClientEnabled";
            chk.Width = 145;
            chk.DataPropertyName = "ClientEnabled";
            dgClientAccess.Columns.Add(chk);

            //column1 = new DataGridViewTextBoxColumn();
            //column1.Name = "FirstSignIn";
            //column1.HeaderText = "SignIn";
            //column1.DataPropertyName = "FirstSignIn";
            //column1.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            ////column1.DefaultCellStyle.BackColor = Color.Black;
            //column1.SortMode = DataGridViewColumnSortMode.NotSortable;
            //column1.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.Width = 200;
            //column1.ReadOnly = true;
            //dgClientAccess.Columns.Add(column1);
            
            
            dgClientAccess.ClearSelection();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            //errorProvider1.Clear();
            bool bResult = LoadClientAccessControl();
            this.ResumeLayout(true);
            IsModified = false;
            return bResult;
        }

        private bool LoadClientAccessControl()
        {
            
            GetClientAccessControl gcac = new GetClientAccessControl();
            lcp = gcac.GetClientAccessControl_();
            dgClientAccess.DataSource = null;
            dgClientAccess.Rows.Clear();
            dgClientAccess.AutoGenerateColumns = false;
            dgClientAccess.AllowUserToAddRows = false;
            dgClientAccess.DataSource = lcp;
            dgClientAccess.ClearSelection();      
            return true;
        }

        public void LoadClientAccessControl_(DataGridView dgAccess_control)
        {
            dgClientAccess = dgAccess_control;

            this.SuspendLayout();
          //  dgClientAccess.CurrentCell = null;
            dgClientAccess.Update();
            dgClientAccess.Refresh();
          
            GetClientAccessControl gcac = new GetClientAccessControl();
            lcp = gcac.GetClientAccessControl_();
           
           
            dgClientAccess.DataSource = null;
            dgClientAccess.Refresh();
            dgClientAccess.Rows.Clear();
            //dgClientAccess.AutoGenerateColumns = false;
            //dgClientAccess.AllowUserToAddRows = false;
     
            dgClientAccess.DataSource = lcp;
            dgClientAccess.CurrentCell = null;
            dgClientAccess.Update();
            dgClientAccess.Refresh();
            //dgClientAccess.ClearSelection();                   
       
            this.ResumeLayout(true);


        }

        //public override bool SaveSettings(DataGridView dgAccess_control)
        //{
        //    Cursor x = Cursors.WaitCursor;
        //    SaveClientAccessControl(dgAccess_control);
        //    x = Cursors.Default;
        //    return result_;
        //}

        public bool SaveClientAccessControl(DataGridView dgAccess_control)
        {
            IsModified = false;

            //dataGridView1.CurrentCell = null;
            dgClientAccess = dgAccess_control;

            int count = 0;
            List<ClientMapColumns> Lcmc;
            SetClientAccessControl scac = new SetClientAccessControl();//This one still gets the value from the DB.
            Lcmc = scac.SetClientAccessControl_();

            dgClientAccess.CurrentCell = null;
            foreach (DataGridViewRow item in dgClientAccess.Rows)
            {
                bool y = Convert.ToBoolean(item.Cells[3].Value);
                string sqlBooVal;
                string OldValue;
                if (y == true) { sqlBooVal = "T"; OldValue = "F";} else { sqlBooVal = "F"; OldValue = "T"; }
                try
                {
                    if (ListClientMap.ListClientMap_[count].ClientEnabled != ListClientMapSet.ListClientMapSet_[count].ClientEnabled)
                    {
                        scac.SetClientAccessControl_(Lcmc[count].ClientID, sqlBooVal);
                        WriteLog.WriteLogWithUMacAddress(ListClientMapSet.ListClientMapSet_[count].MACAddress.ToString(), CurrentUserLoggedIn.username, "UPDATE"/* CLIENTMAC:" + ListClientMapSet.ListClientMapSet_[count].MACAddress.ToString()*/, GetCurrentMacID.MacAddress, "Client Access Control" /*(" + ListClientMapSet.ListClientMapSet_[count].IPAddress.ToString() +")"*/, OldValue, sqlBooVal);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                finally
                {

                }
                count = count + 1;

            }
            dgClientAccess.Update();
            dgClientAccess.Refresh();
            return true;

        }
        private void dgClientAccess_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            IsModified = true;
        }
      
    }
}
