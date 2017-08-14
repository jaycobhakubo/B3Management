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



namespace GameTech.B3Reports.Forms
{
    public partial class SecurityForm : GradientForm//Form
    {
        string userName = "";
        string passWord = "";
        string selecteduserNameInList = "";
        //string Npassword = "";
        bool IsUserName = false;
        bool IsPassword = false;
        bool IsConfirm = false;
        bool IsDelete = false;
        //bool IsAdd = false;
        bool IsEdit = false;
        bool IsNew = false;
        string ConfirmPaswrd = "";
        int LogInID = 0;
        int cType = 1;
        SqlConnection sc = GetSQLConnection.get();

       
        public SecurityForm()
        {
            InitializeComponent();
            AdjustWindowSize.adjust(this);
        }



        private void SecurityForm_Load(object sender, EventArgs e)
        {
            LoadCurrentUser(1);
            selectFirstRowInListUsername();
            pictureBox1.Visible = true;
            ClearErrorProvider();
            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);

            DataGridViewTextBoxColumn column1 = new DataGridViewTextBoxColumn();
            column1.Name = "Permissions";
            column1.HeaderText = "Permissions";
            column1.DataPropertyName = "Permissions";
            column1.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            //column1.DefaultCellStyle.BackColor = Color.Black;
            column1.SortMode = DataGridViewColumnSortMode.NotSortable;
            column1.HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleLeft;
            column1.Width = 200;
            column1.ReadOnly = true;
            dataGridView1.Columns.Add(column1);

            DataGridViewCheckBoxColumn chk = new DataGridViewCheckBoxColumn();
            chk.HeaderText = "Allow";
            chk.Name = "Allow";
            chk.Width = 100;
            chk.DataPropertyName = "Allow";
            
            dataGridView1.Columns.Add(chk);
            dataGridView1.ClearSelection();

        }

        private void selectFirstRowInListUsername()
        {
            if (lstViewUserLogIn.Items.Count > 0)
            {
                lstViewUserLogIn.Items[0].Selected = true;
                lstViewUserLogIn.Items[0].Focused = true;
                txtBxUserName.Text = lstViewUserLogIn.Items[0].Text;
            }
        }

        private void LoadCurrentUser(int type)
        {
            lstViewUserLogIn.Items.Clear();
              GetCurrentUser Currentuser = new GetCurrentUser();
              List<User> Listuser = new List<User>();
              if (type == 1)//active
              {
                  Listuser = Currentuser.GetCurrentUserActive();
              }
              else
                  if (type == 2)//inactive
                  {
                      Listuser = Currentuser.GetCurrentUserInActive();
                  }
                  else if (type == 3)
                  {
                      Listuser = Currentuser.GetCurrentUserAll();
                  }


            foreach(User user in  Listuser)
            {
                ListViewItem lvi = new ListViewItem(user.username);
                lstViewUserLogIn.Items.Add(lvi);
               
              
            }
    }

        private void imgButtonUserNameNormal(object sender, EventArgs e)
        {
            ClearErrorProvider();

            IsPassword = false;
            IsUserName = true;
           
        }

        private void UserName(string username)
        {
            if (username == "{BACKSPACE}")
            {

                if ( txtBxUserName.Text.Count() > 0)
                {
                    txtBxUserName.Text = txtBxUserName.Text.Remove(txtBxUserName.Text.Length - 1);
                }
            }

            else
            {
                txtBxUserName.Text = txtBxUserName.Text + username;

            }
         
            userName = txtBxUserName.Text;
        }

        private void Password(string username)
        {
            if (username == "{BACKSPACE}")
            {
                //
                if (txtBxPasswrd.Text.Count() > 0)
                {
                    txtBxPasswrd.Text = txtBxPasswrd.Text.Remove(txtBxPasswrd.Text.Length - 1);
                }
            }
            else
            {
                txtBxPasswrd.Text = txtBxPasswrd.Text + username;

            }


            passWord = txtBxPasswrd.Text;
        }

        private void ConfirmPassword(string username)
        {
            if (username == "{BACKSPACE}")
            {
                //
                if (txtBxConfirmPaswrd.Text.Count() > 0)
                {
                    txtBxConfirmPaswrd.Text = txtBxConfirmPaswrd.Text.Remove(txtBxPasswrd.Text.Length - 1);
                }
            }
            else
            {
                txtBxConfirmPaswrd.Text = txtBxConfirmPaswrd.Text + username;

            }


            ConfirmPaswrd = txtBxConfirmPaswrd.Text;
        }


        private void imgBtnPasswordNormal(object sender, EventArgs e)
        {
            ClearErrorProvider();

            IsPassword = true;
            IsUserName = false;
        }

      

        private void virtualKeyboard1_KeyPressed(object sender, KeyboardEventArgs e)
        {
            if (pictureBox1.Visible == true)
            {
                pictureBox1.Visible = false;
            }
                VirtualKeyboard KeyBoard = (VirtualKeyboard)sender;

            ClearErrorProvider();
            if (KeyBoard.m_keys != "{ENTER}")
            {
                if (IsUserName == true)
                {
                    while (IsUserName == true)
                    {
                        txtBxUserName.BackColor = Color.SkyBlue;
                        break;
                    }
                    UserName(KeyBoard.m_keys);
                }
                else if (IsPassword == true)
                {
                    Password(KeyBoard.m_keys);
                }
                else if (IsConfirm == true)
                {
                    ConfirmPassword(KeyBoard.m_keys);
                }
            }
            else
            {
                imgBtnSave.PerformClick();
            }


        }



        private void btnClear_Click(object sender, EventArgs e)
        {

        }

        private void ClearUserName()
        {
            txtBxUserName.Text = string.Empty;
            userName = txtBxUserName.Text;
        }

        private void ClearPassword()
        {
            txtBxPasswrd.Text = string.Empty;
            passWord = txtBxPasswrd.Text;
        }

        private void ClearConfirmnPassword()
        {
            txtBxConfirmPaswrd.Text = string.Empty;
            ConfirmPaswrd = txtBxPasswrd.Text;
        }

        private void btnClearAll_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();
            ClearAll();
        }

        private void ClearAll()
        {
            ClearUserName();
            ClearPassword();
            ClearConfirmnPassword();
            chkIsLock.Checked = false;
            chkIsActive.Checked = true;

            txtbxFirstName.Text = string.Empty;
            txtbxLastName.Text = string.Empty;

            if (IsEdit == true)
            {
                dataGridView1.DataSource = null;
                dataGridView1.Rows.Clear();
            }
        }

        private void setToDefault()
        {
            IsUserName = false;
            IsPassword = false;
            //pictureBox1.Visible = false;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {

        }

        private void btnMouseUp(object sender, MouseEventArgs e)
        {
            Button btn = (Button)sender;
            if (Convert.ToInt32(btn.Tag) == 1)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.SaveNorm;
            }
            else
                if (Convert.ToInt32(btn.Tag) == 2)
                {
                    btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.CancelNorm;
                }
                else

                    if (Convert.ToInt32(btn.Tag) == 3)
                    {
                        btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.ClearAll;
                    }
                    else
                        if (Convert.ToInt32(btn.Tag) == 4)
                        {
                            btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.ClearNormal;
                        }                    
        }

    
        private void btnMouseDown(object sender, MouseEventArgs e)
        {

            Button btn = (Button)sender;
            if (Convert.ToInt32(btn.Tag) == 1)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.SavePressed;
            }
            else
                if (Convert.ToInt32(btn.Tag) == 2)
                {
                    btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.CancelPressed;
                }
                else

                    if (Convert.ToInt32(btn.Tag) == 3)
                    {
                        btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.ClearAllPressed;
                    }else
                        if (Convert.ToInt32(btn.Tag) == 4)
                        {
                            btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.ClearPressed;
                        }                    
        }

    

        private void ClearErrorProvider()
        {
            errorProvider1.Clear();
            pictureBox1.Visible = false;
        //    errorProvider1.SetError(txtBxUserName, string.Empty);
        //    errorProvider1.SetError(txtBxPasswrd, string.Empty);
        //    errorProvider1.SetError(txtBxConfirmPaswrd, string.Empty);
        }

        private void txtBxClick(object sender, EventArgs e)
        {
            pictureBox1.Visible = false;
            ClearErrorProvider();
            setAllToSlateGray();

            TextBox CtxtBx = (TextBox)sender;
            //CtxtBx.BackColor = Color.SkyBlue;

            setallToF();

            if ( Convert.ToInt32(CtxtBx.Tag)== 1)
            {
                IsUserName = true;
            }
            else if (Convert.ToInt32(CtxtBx.Tag) == 2)
            {
                IsPassword = true;
            }
            else if (Convert.ToInt32(CtxtBx.Tag) == 3)
            {
                IsConfirm = true;
            }
        }

        private void newEntry()
        {
            IsNew = true; IsEdit = false;
            lstViewUserLogIn.HideSelection = true;
            selecteduserNameInList = string.Empty;
            //txtBxUserName.BackColor = Color.SkyBlue;
            IsUserName = true;
            //txtBxUserName.Focus();
            txtbxFirstName.Focus();
            ClearErrorProvider();
            ClearAll();
         //   lstViewUserLogIn.Enabled = false;
           // groupBox1.Enabled = false;

            dataGridView1.CurrentCell = null;
            dataGridView1.ClearSelection();
            foreach (DataGridViewRow item in dataGridView1.Rows)
            {
                //item.Cells[1].Selected = false;
                item.Cells[1].Value = false;
            }

            dataGridView1.Update();
            dataGridView1.Refresh();

        }

        private void setAllToSlateGray()
        {
           // txtBxUserName.BackColor = Color.DarkSlateGray;
            txtBxUserName.BackColor = Color.White;
         //   txtBxPasswrd.BackColor = Color.DarkSlateGray;
            txtBxPasswrd.BackColor = Color.White;
            txtbxFirstName.BackColor = Color.White;
            txtbxLastName.BackColor = Color.White;
            if (txtBxConfirmPaswrd.Enabled == true)
            {
                //txtBxConfirmPaswrd.BackColor = Color.DarkSlateGray;
                txtBxConfirmPaswrd.BackColor = Color.White;

            }
        }

        private void setallToF()
        {
            IsUserName = false;
            IsPassword = false;
            IsConfirm = false;
        }

    

        private void txtBxTextChanged(object sender, EventArgs e)
        {           
            TextBox txt = (TextBox)sender;
            ClearErrorProvider();
           
            int test = GetSecuritySettings.MinPasswordLength;

            if (Convert.ToInt32(txt.Tag) == 2)
            {
                if (txtBxPasswrd.Text != string.Empty)
                {       
           
                }
            }
            else if (Convert.ToInt32(txt.Tag) == 1)
            {
                txtBxPasswrd.Text = string.Empty;
            }

            if (txtBxUserName.Text != string.Empty && txtBxPasswrd.Text != string.Empty)
            {

                if (GetSecuritySettings.UsePasswordComplexity == true)
                {
                    bool DidYouFollowTheRequirements = PasswordPolicy.IsValid(txtBxPasswrd.Text);
                    if (DidYouFollowTheRequirements == true)
                    {
                        txtBxConfirmPaswrd.Enabled = true;
                        txtBxConfirmPaswrd.BackColor = Color.White;
                    }
                }
                else //0
                {
                    bool DidYouFollowTheRequirements = PasswordPolicy.IsValidPComplexOff(txtBxPasswrd.Text);
                    if (DidYouFollowTheRequirements == true)
                    {
                        txtBxConfirmPaswrd.Enabled = true;
                        txtBxConfirmPaswrd.BackColor = Color.White;
                    }
                    else
                    {
                        txtBxConfirmPaswrd.Enabled = false;
                        txtBxConfirmPaswrd.BackColor = Color.Silver;
                        txtBxConfirmPaswrd.Text = string.Empty;
                    }
                }             
            }
            else
            {
                txtBxConfirmPaswrd.Enabled = false;
                txtBxConfirmPaswrd.BackColor = Color.Silver;
                txtBxConfirmPaswrd.Text = string.Empty;
            }


           

            
          
        }

        private void lstViewUserLogIn_ItemActivate(object sender, EventArgs e)
        {
            txtBxUserName.Text = lstViewUserLogIn.SelectedItems[0].Text;
        }

        private void clearPassAndConfirmTxtOnSecurityForm()
        {
            txtBxPasswrd.Text = string.Empty;
            txtBxUserName.Text = string.Empty;
        }


        private void lstViewUserLogIn_SelectedIndexChanged(object sender, EventArgs e)//6
        {
            SelectedUserInList();       
        }

        private void SelectedUserInList()
        {
            clearPassAndConfirmTxtOnSecurityForm();
            string username = "";
            string IsEnable = "";
            string IsLocked = "";
            IsNew = false;

            if (IsEdit == true)
            {
                EnableUserAndPassword();
            }
            if (lstViewUserLogIn.SelectedItems.Count > 0)
            {
                var item = lstViewUserLogIn.SelectedItems[0];
                username = Convert.ToString(item.Text);

                string FirstName = "";
                string LastName = "";

                if (username != string.Empty)
                {
                    sc.Open();

                    try
                    {
                        using (SqlCommand cmd = new SqlCommand(@"select EnableUser, Locked, FirstName, LastName from dbo.B3_Login where UserName = @UserName", sc))
                        {
                            cmd.Parameters.AddWithValue("UserName", username);
                            SqlDataReader reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                IsEnable = reader.GetString(0);
                                IsLocked = reader.GetString(1);

                                if (!reader.IsDBNull(2))
                                { FirstName = reader.GetString(2); }
                                else { FirstName = string.Empty; }
                                //else

                                if (!reader.IsDBNull(3))
                                { LastName = reader.GetString(3); }
                                else { LastName = string.Empty; }
                                //    return string.Empty;                
                            }
                            /*IsEnable = (string)cmd.ExecuteScalar();*/
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

                if (IsDelete != true)
                {
                    txtBxUserName.Text = username;
                    txtbxFirstName.Text = FirstName;
                    txtbxLastName.Text = LastName;

                    if (IsEnable == "T")
                    {chkIsActive.Checked = true; } else { chkIsActive.Checked = false; }

                    if (IsLocked == "T")
                    {chkIsLock.Checked = true;} else { chkIsLock.Checked = false; }
                }            
                selecteduserNameInList = username;               
            }
       
            if (selecteduserNameInList != string.Empty)
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select LoginID from dbo.B3_Login where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", selecteduserNameInList);
                    LogInID = (int)cmd.ExecuteScalar();
                }
                sc.Close();
            }
            userName = selecteduserNameInList;

            if (lstViewUserLogIn.SelectedItems.Count > 0)
            {
                
                List<StaffPermissions> sp; //= new List<StaffPermissions>();                
                GetStaffPermissions gsp = new GetStaffPermissions();                
                sp = gsp.GetStaffPermissions_(LogInID);

                //var list = new BindingList<StaffPermissions>(sp);
                dataGridView1.DataSource = null;
                dataGridView1.Rows.Clear();
                dataGridView1.AutoGenerateColumns = false;
                dataGridView1.AllowUserToAddRows = false;
                dataGridView1.DataSource = sp;
                dataGridView1.ClearSelection();
            }




        }

        private void DisAbleListView()
        {
            lstViewUserLogIn.Enabled = false;
            lstViewUserLogIn.ForeColor = Color.Black;
        }

        private void AddEditDelSetImageToDefault()
        {
            //btnAdd.Image = GameTech.B3Reports.Properties.Resources.add;
            //btnEdit.Image = GameTech.B3Reports.Properties.Resources.edit;
            //btnDelete.Image = GameTech.B3Reports.Properties.Resources.delete;
        }

        private void AddEditDeleteSetToF()
        {
            IsDelete = false;
         //   IsAdd = false;
            IsEdit = false;
        }

        private void DisableUserAndPassword()
        {
            txtBxUserName.Enabled = false;
            txtBxPasswrd.Enabled = false;

            txtBxUserName.BackColor = Color.Silver;
            txtBxPasswrd.BackColor = Color.Silver;

        }

        private void EnableUserAndPassword()
        {
            txtBxUserName.Enabled = true;
            txtBxPasswrd.Enabled = true;

            //txtBxUserName.BackColor = Color.DarkSlateGray;
            //txtBxPasswrd.BackColor = Color.DarkSlateGray;

            txtBxUserName.BackColor = Color.White;
            txtBxPasswrd.BackColor = Color.White;


        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            AddEditDeleteSetToF();
                            try
                            {
                                sc.Open();
                                SqlCommand cmd = new SqlCommand(@"delete from dbo.B3_Login
                                where UserName = '" +userName   + "'", sc);
                                cmd.ExecuteNonQuery();
                                sc.Close();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show(ex.Message);
                            }

                            ClearAll(); setToDefault(); EnableUserAndPassword();
                            LoadCurrentUser(cType);
        }

        private void btnAdd1_Click(object sender, EventArgs e)
        {
            AddEditDeleteSetToF();
            passWord = txtBxPasswrd.Text;
            userName = txtBxUserName.Text;
            ConfirmPaswrd = txtBxConfirmPaswrd.Text;
            ClearErrorProvider();

                if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                    return;

                try
                {
                    //No btnAdd1
                    sc.Open();
                    SqlCommand cmd = new SqlCommand("Exec usp_config_b3_security_insertUser '" + userName + "' , '" + passWord + "'", sc);
                    cmd.ExecuteNonQuery();
                    sc.Close();

                   // MessageBox.Show("New login user: " + userName + " has been added.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                ClearAll(); setToDefault(); EnableUserAndPassword();
                LoadCurrentUser(cType);           
        }




        private void btnAdd_Click(object sender, EventArgs e)
        {
            AddEditDelSetImageToDefault();
            AddEditDeleteSetToF();
            ClearErrorProvider();
            ClearAll();
            Button btn = (Button)sender;

            


        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            AddEditDeleteSetToF();
            IsEdit = true;
            passWord = txtBxPasswrd.Text;
            userName = txtBxUserName.Text;
            ConfirmPaswrd = txtBxConfirmPaswrd.Text;
            ClearErrorProvider();

            IsEdit = true;

            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                return;

            try
            {
                sc.Open();
                //No edit button
                SqlCommand cmd = new SqlCommand("usp_management_SecuritySettings_UpdateUser " + LogInID + " , '" + userName + "' ,'" + passWord + "'", sc);
                cmd.ExecuteNonQuery();
                sc.Close();

                //MessageBox.Show("Updated OK.");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            ClearAll(); 
            setToDefault(); 
            EnableUserAndPassword();
            LoadCurrentUser(cType);

        }

        private void imgBtnClear_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();

            if (IsUserName == true)
            {

                ClearUserName();
            }
            else if (IsPassword == true)
            {
                ClearPassword();
            }
            else if (IsConfirm == true)
            {
                ClearConfirmnPassword();
            }

            pictureBox1.Visible = false;
        }

        private void imgBtnClearAll_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();
            ClearAll();
        }

        private void imgBtnReturn_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();
            ClearAll(); setToDefault();
            try
            {

                if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                }
                else
                {
                    this.Visible = false;

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                //MessageForm.Show(this, mstrFormName + "fixUnitToolStripMenuItem_Click....Exception: " + ex.Message, "Game Management Main");
            }
            pictureBox1.Visible = true;
        }

        private void imgBtnNew_Click(object sender, EventArgs e)
        {
            pictureBox1.Visible = false;
            newEntry();
            //txtBxUserName.SelectionStart = 0;
    
        }

        private void imgBtnCancel_Click(object sender, EventArgs e)
        {
            IsNew = false;
            IsEdit = false;
            lstViewUserLogIn.HideSelection = true;
            EnableUserAndPassword();   
            ClearErrorProvider();
            ClearAll();
            pictureBox1.Visible = false;
            groupBox1.Enabled = true;

            dataGridView1.CurrentCell = null;
            dataGridView1.ClearSelection();
            foreach (DataGridViewRow item in dataGridView1.Rows)
            {
                //item.Cells[1].Selected = false;
                item.Cells[1].Value = false;
            }
     
            dataGridView1.Update();
            dataGridView1.Refresh();


        }

        private void imgBtnSave_Click(object sender, EventArgs e)
        {
            if (pictureBox1.Visible != false)
            {
                pictureBox1.Visible = false;
            }

            if (selecteduserNameInList == string.Empty)
            {
                IsNew = true;
                IsEdit = false;
            }
            else
            {
                IsNew = false;
                IsEdit = true;
            }

            string IsActiveCheck = "F";
            if (chkIsActive.Checked == true)
            {
                IsActiveCheck = "T";
            }

            string IsLockedCheck = "F";
           if (chkIsLock.Checked == true)
           {
            IsLockedCheck = "T";
           }
            

            if (IsNew == true)//INSERT ONLY PLEASE
            {
                AddEditDeleteSetToF();
                passWord = txtBxPasswrd.Text;

                //Lets check if it meets the requiremenets.
             //   bool DidYouFollowTheRequirements =  PasswordPolicy.IsValid(passWord);      

                userName = txtBxUserName.Text;
                ConfirmPaswrd = txtBxConfirmPaswrd.Text;
     
                ClearErrorProvider();

                //Validate all entry
                if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                    return;
                int NewLoginID  = 0; 
                try
                {
                    
                    sc.Open();
                    SqlCommand cmd = new SqlCommand(
                     @"Exec usp_management_SecuritySettings__insertUser "
                    + "@userName = '" + userName + "', "
                    + "@PWord = '" + passWord + "', "
                    + "@Enable = '" + IsActiveCheck + "', "
                    + "@Locked = '" + IsLockedCheck + "', "
                    + "@FirstNamesp = '" + txtbxFirstName.Text.ToString() + "', "
                    + "@LastNamesp = '" + txtbxLastName.Text.ToString() + "'"
                    , sc);

                    NewLoginID =  (int)cmd.ExecuteScalar();// cmd.ExecuteNonQuery();                   

                    //lets write it on the auditlog table
                    //  WriteLog.WriteLog_("",CurrentUserLoggedIn.username, "Username already exists."); //Why did I did this it doesnt make sense  - will investigate.
                    //pictureBox1.Visible = true;
                    //Let us just run the Log inside the SP
                    WriteLog.WriteLog_(userName, CurrentUserLoggedIn.username, "ADD", GetCurrentMacID.MacAddress, "");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                finally
                {
                    sc.Close();
                }
                //StaffPermissionsList.PermissionList.Clear();

               SavedOrUpdatePermission(NewLoginID);//It should not be 0 even the default is 0;

                ClearAll(); setToDefault(); EnableUserAndPassword();
                //IsEdit = false; IsNew = false;
                lstViewUserLogIn.HideSelection = false;
                LoadCurrentUser(cType);
                txtBxUserName.Select();
                txtBxUserName.Focus();
                setallToF();
                pictureBox1.Visible = true;
            }
            else if (IsEdit == true)//UPDATE only
            {
                if (txtBxPasswrd.Text != string.Empty) //if were trying edit the password of a existing user
                {
                    passWord = txtBxPasswrd.Text;
                    ConfirmPaswrd = txtBxConfirmPaswrd.Text;

                    //let us see if it compy with the password policy
                    if (GetSecuritySettings.UsePasswordComplexity == true)
                    {
                        bool IsPasswordValid = PasswordPolicy.IsValid(passWord);
                        if (IsPasswordValid == false)
                        {
                            errorProvider1.SetError(txtBxPasswrd, "Policy did not met.");
                            return;
                        }
                    }
                    else
                    {
                        bool IsPasswordValid = PasswordPolicy.IsValidPComplexOff(passWord);
                        if (IsPasswordValid == false)
                        {
                            errorProvider1.SetError(txtBxPasswrd, "Policy did not met.");
                            return;
                        }
                    }

                    //let us check if we can reuse this password
                    bool IsPasswordReuseOk = IsPasswordReusable.IsPasswordReusable_(LogInID ,passWord);
                    if (IsPasswordReuseOk == false)
                    {
                        //errorProvider1.SetError(txtBxPasswrd, "This password can't be reuse.");
                        errorProvider1.SetError(txtBxPasswrd, "The password does not meet the password reuse requirements.");
                        return;
                    }
                }

               
                if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                    return;
                string PrivateUserName = "";
              
                if (txtBxUserName.Text != string.Empty)
                {
                    PrivateUserName = txtBxUserName.Text;
                }

                try
                {
                    sc.Open();
                    SqlCommand cmd = new SqlCommand(
                    @"exec usp_management_SecuritySettings_UpdateUser "
                    + "@LoginIDsp = " + LogInID + ", "
                    + "@CurrentUserLoginsp = '" + CurrentUserLoggedIn.username + "', "
                    + "@UserNamesp = '" + PrivateUserName + "', "
                    + "@UserPasswordsp = '" + passWord + "', "
                    + "@Enablesp = '" + IsActiveCheck + "', "
                    + "@Lockedsp = '" + IsLockedCheck + "', "
                    + "@MacAddresssp = '" + GetCurrentMacID.MacAddress + "', "
                    + "@FirstNamesp = '" + txtbxFirstName.Text.ToString() + "', "
                    + "@LastNamesp = '" + txtbxLastName.Text.ToString() + "'"



                    , sc);
                    cmd.ExecuteNonQuery();
                    sc.Close();

                    CurrentUserLogged.LoggedUser = PrivateUserName;
                    pictureBox1.Visible = true;                
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    sc.Close();
  
                }
            
                SavedOrUpdatePermission(LogInID);

                LoadCurrentUser(cType);
                //lstViewUserLogIn.Items[0].Selected = true;
                var x = lstViewUserLogIn.FindItemWithText(txtBxUserName.Text.ToString());
                int yy = lstViewUserLogIn.Items.IndexOf(x);

                if (yy != -1)
                {
                    lstViewUserLogIn.Items[yy].Selected = true;
                }

                pictureBox1.Visible = true;
            }

            if (IsNew == true)
            {
                dataGridView1.CurrentCell = null;
                dataGridView1.ClearSelection();
                foreach (DataGridViewRow item in dataGridView1.Rows)
                {
                    //item.Cells[1].Selected = false;
                    item.Cells[1].Value = false;
                }

                dataGridView1.Update();
                dataGridView1.Refresh();
            }
        }

        private void SavedOrUpdatePermission(int lginID)
        {
            int count = 0;

            List<StaffPermissions> sp; //= new List<StaffPermissions>();                
            GetStaffPermissions2 gsp = new GetStaffPermissions2();
            sp = gsp.GetStaffPermissions2_(LogInID);

            foreach (DataGridViewRow item in dataGridView1.Rows)
            {
                //bool x = Convert.ToBoolean(StaffPermissionsList.PermissionList[count].Allow);//It was updated automatically.
                bool y = Convert.ToBoolean(item.Cells[1].Value);
                string sqlBoolVal;
                if (y == true){sqlBoolVal = "T";}else{sqlBoolVal = "F";}    
                try
                {
                    sc.Open();
                    //if (StaffPermissionsList.PermissionList.Count == 0)
                    //{
                    //    MessageBox.Show("0");
                    //}
                    if (IsNew == true)
                    {
                        if (StaffPermissionsList2.PermissionList2[count].Permissions == "Cash Drawer")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitCashDrawer = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                           // string OldValue = "";
                          //  if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Cash Drawer", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "End Session")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitEndSession = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                          //  if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission End Session", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Set Balls")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSetBalls = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                           // string OldValue = "";
                           // if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Set Balls", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Start Session")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitStartSession = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                           // string OldValue = "";
                           // if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                           // WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Start Session", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "VIP")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVIP = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission VIP", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Accounts Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitAccountsReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Accounts Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Detail Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDetailReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                          //  if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Detail Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Drawer Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDrawerReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                          //  if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Drawer Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Jackpot Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitJackpotReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                          //  if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Jackpot Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Monthly Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitMonthlyReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Monthly Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Session Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSessionReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                        //    string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Session Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Sales")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSales = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                       //     if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Sales", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Redeem")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitRedeem = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                        //    if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                        //    WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Redeem", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Void Accounts")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVoidAccounts = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                          //  string OldValue = "";
                        //    if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                        //    WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Void Accounts", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "System")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSystem = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                            //string OldValue = "";
                            //if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                            //WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission System", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Daily Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDailyReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                        //    string OldValue = "";
                        //    if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                        //    WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Daily Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Void Report")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVoidReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                        //    if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                        //    WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Void Report", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Reports")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitReports = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                          //  WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permissions Reports", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Mgmt. Security")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementSecurity = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Security", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Mgmt. System Settings")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementSystemSettings = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                         //   if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. System Settings", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Mgmt. Dispute Resolution")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementDisputeResolution = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                        //    if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                       //     WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Dispute Resolution", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Mgmt. Reports")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementReports = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                         //   string OldValue = "";
                       //     if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                         //   WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Reports", OldValue, sqlBoolVal);
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "Client Access Control")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitClientAccessControl = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                        }
                        else if (StaffPermissionsList2.PermissionList2[count].Permissions == "ND Settings")
                        {
                            SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set [ND Settings] = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                            cmd.ExecuteNonQuery();
                        }
                    }


                    if (IsEdit == true)
                    {
                        if (StaffPermissionsList.PermissionList[count].Allow != StaffPermissionsList2.PermissionList2[count].Allow)
                        {
                            if (StaffPermissionsList.PermissionList[count].Permissions == "Cash Drawer")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitCashDrawer = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Cash Drawer", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "End Session")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitEndSession = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission End Session", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Set Balls")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSetBalls = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Set Balls", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Start Session")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitStartSession = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Start Session", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "VIP")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVIP = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission VIP", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Accounts Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitAccountsReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Accounts Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Detail Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDetailReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Detail Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Drawer Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDrawerReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Drawer Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Jackpot Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitJackpotReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Jackpot Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Monthly Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitMonthlyReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Monthly Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Session Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSessionReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Session Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Sales")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSales = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Sales", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Redeem")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitRedeem = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Redeem", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Void Accounts")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVoidAccounts = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Void Accounts", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "System")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitSystem = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission System", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Daily Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitDailyReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Daily Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Void Report")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitVoidReport = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permission Void Report", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Reports")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitReports = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permissions Reports", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Mgmt. Security")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementSecurity = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Security", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Mgmt. System Settings")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementSystemSettings = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. System Settings", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Mgmt. Dispute Resolution")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementDisputeResolution = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Dispute Resolution", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Mgmt. Reports")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitManagementReports = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Mgmt. Reports", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "Client Access Control")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set PermitClientAccessControl = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Permit Client Access Control", OldValue, sqlBoolVal);
                            }
                            else if (StaffPermissionsList.PermissionList[count].Permissions == "ND Settings")
                            {
                                SqlCommand cmd = new SqlCommand(@"Update  [dbo].[B3_Login] set [ND Settings] = '" + sqlBoolVal + "' where LoginID = " + lginID, sc);
                                cmd.ExecuteNonQuery();
                                string OldValue = "";
                                if (sqlBoolVal == "T") { OldValue = "F"; } else { OldValue = "T"; }
                                WriteLog.WriteLogWithUserName(userName, CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "ND Settings", OldValue, sqlBoolVal);
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
                count = count + 1;
            }

        }

        //private void chkShowKeyBoard_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (myChkShowVKeyBoard.Checked == false)
        //    {
        //        virtualKeyboard1.Visible = false;
        //    }
        //    else
        //    {
        //        virtualKeyboard1.Visible = true;
        //    }
        //}

        private void rdoUserbtn_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton cUserRdo = (RadioButton)sender;
            if ( Convert.ToInt32(cUserRdo.Tag) == 1) // Active
            {              
                cType = 1;
            }
            else if (Convert.ToInt32(cUserRdo.Tag) == 2)//Inactive
            {
                cType = 2;
            }
            else if (Convert.ToInt32(cUserRdo.Tag) == 3)//All
            {
                cType = 3;
            }

            LoadCurrentUser(cType);
            if (IsNew != true)
            {
                selectFirstRowInListUsername();
            }

            lstViewUserLogIn.HideSelection = false;

        }

        //private void SecurityForm_Activated(object sender, EventArgs e)
        //{

        //}

        private void SecurityForm_VisibleChanged(object sender, EventArgs e)
        {
            Form x = (Form)sender;
            if (x.Visible == true)
            {
                lstViewUserLogIn.Select();
                selectFirstRowInListUsername();
                groupBox1.Enabled = true;
                pictureBox1.Visible = false;
            }
        }

        private void lstViewUserLogIn_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("Hi there I am click");
            ListView x = (ListView)sender;
            if (lstViewUserLogIn.FocusedItem.Text != userName)
            {
                SelectedUserInList();
               // MessageBox.Show("I selected diffirent user");
            }
            pictureBox1.Visible = false;
            lstViewUserLogIn.HideSelection = false;
            groupBox1.Enabled = true;
        }

        private void chkIsActive_CheckedChanged(object sender, EventArgs e)
        {
            //pictureBox1.Visible = false;
        }

        private void chkIsActive_Click(object sender, EventArgs e)
        {
            pictureBox1.Visible = false;
        }
   

        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }

        private void chkIsActive_CheckedChanged_1(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        //VALIDATE 
        //========================================================================

        private void txtBxConfirmPaswrd_Validating(object sender, CancelEventArgs e)
        {


            if (txtBxConfirmPaswrd.Text == string.Empty && txtBxPasswrd.Text != string.Empty)
            {
                e.Cancel = true;

                errorProvider1.SetError(txtBxConfirmPaswrd, "Confirm password.");
            }
            else if (passWord != ConfirmPaswrd)
            {
                e.Cancel = true;
                // errorProvider1.SetError(txtBxConfirmPaswrd, "The password does not match the confirm password.");
                errorProvider1.SetError(txtBxConfirmPaswrd, "The password does not match the confirm password.");
            }

        }

        private void txtBxPasswrd_Validating(object sender, CancelEventArgs e)
        {

            if (IsEdit != true)//|| txtBxPasswrd.Text == string.Empty) //--> It a new record
            {
                if (txtBxPasswrd.Text == string.Empty)
                {
                    e.Cancel = true;
                    errorProvider1.SetError(txtBxPasswrd, "Enter a password.");
                }
            }
            else if (IsEdit == true)//If were trying to edit the password we make sure it passed the policy
            {

            }
        }

        private void txtBxUserName_Validating(object sender, CancelEventArgs e)
        {
            bool IsUserAlreadyExists = false;
            if (txtBxUserName.Text == string.Empty)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtBxUserName, "Enter a user login.");
            }

            if (IsEdit == true)
            {
                string userName_ = txtBxUserName.Text;
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName and 
                                                    LoginID <> @LoginID", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName_);
                    cmd.Parameters.AddWithValue("LoginID", LogInID);
                    IsUserAlreadyExists = (int)cmd.ExecuteScalar() > 0;
                }
            }
            else
            {


                string userName_ = txtBxUserName.Text;
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName_);
                    IsUserAlreadyExists = (int)cmd.ExecuteScalar() > 0;
                }
            }

            if (IsUserAlreadyExists == true)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtBxUserName, "User already exists.");
            }
            sc.Close();
        }


        private void imgBtnPasswordNorm_Validating(object sender, CancelEventArgs e)
        {

        }

        private void txtbxFirstName_Validating(object sender, CancelEventArgs e)
        {
            //Cancel if First Name is Empty
            //if (txtbxFirstName.Text == string.Empty)
            //{
            //    e.Cancel = true;
            //    errorProvider1.SetError(txtbxFirstName, "Enter firstname.");
            //}
        }

        //private void dataGridView1_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        //{
        //    // MessageBox.Show("Hello I am changed");
        //    foreach (DataGridViewRow item in dataGridView1.Rows)
        //    {

        //        bool y = Convert.ToBoolean(item.Cells[1].Value);
        //    }
        //}

        private void lstViewUserLogIn_ColumnWidthChanging(object sender, ColumnWidthChangingEventArgs e)
        {
            e.Cancel = true;
            e.NewWidth = lstViewUserLogIn.Columns[e.ColumnIndex].Width;
        }

        private void SecurityForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            ClearErrorProvider();
            ClearAll(); setToDefault();
            try
            {

                if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                }
                else
                {
                    this.Visible = false;

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                //MessageForm.Show(this, mstrFormName + "fixUnitToolStripMenuItem_Click....Exception: " + ex.Message, "Game Management Main");
            }
            pictureBox1.Visible = true;
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
           
            ClearErrorProvider();
        }      
    }

    //class Person
    //{
    //    public string Name { get; set; }
    //    public string Surname { get; set; }
    //}
}
