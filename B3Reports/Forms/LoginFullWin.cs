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
using System.Timers;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports.Forms
{
    /// <summary>
    /// Form for logging in and logging out.
    /// </summary>
    public partial class LoginFullWin : Form
    {

        public static bool IschangePassword = false;

        #region MEMBER

        private bool IsUserName = false;
        private bool IsPassword = false;
        private bool IsEnCurPassword = false;
        private bool IsEnNewPassword = false;
        private bool IsConfirmNewPassword = false;
        private bool IsUserAlreadyExists = false;
        private bool IsUserExists = false;
        private bool IspasswordExpired;
        private int NlogInTry = 0;
        private int UserLoginID = 0;
        private string EnNewPasswor = "";
        private string EntCurPassword = "";
        private string userName = "";
        private string passWord = "";
        private string ConfirmNewPassword = "";
        private SqlConnection sc;

        #endregion

        #region CONSTRUCTOR

        public LoginFullWin()
        {
            InitializeComponent();
            InitSqlConnection();
            AdjustWindowSize.adjust(this);
        }

        #endregion

        #region METHODS

        private void InitSqlConnection()
        {
            var databaseConnection = new DatabaseConnectionForm(true);

            var results = databaseConnection.ShowDialog();

            if (results == DialogResult.Cancel)
            {
                Application.Exit();
                return;
            }

            sc = new SqlConnection(B3DatabaseConnection.GetConnectionString);

            txtUsername.Select();

            //Load the Security Settings
            GetSecuritySettings SecuritySettings = new GetSecuritySettings();

            //Load the game settings
            GetGameSettings GameSettings = new GetGameSettings();

            //Get  the MacAdress for this PC
            GetCurrentMacID get = new GetCurrentMacID();
            //get.Get_CurrentMacID();

            //Update the user being locked due to failed attempt.
            UpdateUserForAutoUnlocking();

            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;

            label2.Text = "Version 4.2.0     09/15/2015     MAC " + GetCurrentMacID.MacAddress + "     IP " + GetCurrentMacID.IpAddress;
            label3.Text = "\u00a9" + " Copyright 2015 Fortunet, Inc. All Rights Reserved";
        }

        private void UpdateUserForAutoUnlocking()
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


        private void ClearAlTxtBxInLogin()
        {
            txtPassword.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtBxEntCurrPassword.Text = string.Empty;
            txtBxEnterNewPassword.Text = string.Empty;
            txtBxVerifyNewPassword.Text = string.Empty;
        }



        public bool IsTheUserActive()
        {
            bool isUserActive = false;

            //User is enable or not
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*)
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName  and EnableUser = 'T'", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    isUserActive = (int) cmd.ExecuteScalar() > 0; //changing the variable to IsUserActive
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

            return isUserActive;
        }

        public bool PasswordExpired()
        {
            bool IsPasswordExpired = false;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select dbo.b3_fnCheckPassordExpDate(@UserName)", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    IsPasswordExpired = Convert.ToBoolean(cmd.ExecuteScalar());
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
            return IsPasswordExpired;
        }


        public bool IsTheUserlocked()
        {

            //Get the status of the is user if its locked or unlocked
            bool IsUserlocked = true;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"select count(*)
                                                    from dbo.B3_Login 
                                                    where UserName = @UserName  and Locked = 'T'", sc))
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    IsUserlocked = (int) cmd.ExecuteScalar() > 0;
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
            return IsUserlocked;
        }

        public bool IsPasswordCorrect()
        {
            sc.Open();
            bool IsPasswordCorrect = false;
            if (IsUserAlreadyExists == true) //This will always be false
            {
                string userName = txtUsername.Text;
                string passWord_ = txtPassword.Text;
                using (SqlCommand cmd = new SqlCommand(@"select count(*) 
                    from dbo.B3_Login 
                    where UserName = @UserName and 
                    [UserPassword] COLLATE SQL_Latin1_General_CP1_CS_AS = @UserPassword", sc))
                    //Password is case sensitive
                {
                    cmd.Parameters.AddWithValue("UserName", userName);
                    cmd.Parameters.AddWithValue("UserPassword", passWord_);
                    IsPasswordCorrect = (int) cmd.ExecuteScalar() == 1;
                }

            }
            sc.Close();
            return IsPasswordCorrect;
        }

        private void Password(string password)
        {
            if (password == "{BACKSPACE}")
            {
                if (txtPassword.Text.Count() > 0)
                {
                    txtPassword.Text = txtPassword.Text.Remove(txtPassword.Text.Length - 1);
                }
            }
            else
            {
                txtPassword.Text = txtPassword.Text + password;
                passWord = txtPassword.Text;
            }

        }

        private void UserName(string username)
        {
            if (username == "{BACKSPACE}")
            {

                if (txtUsername.Text.Count() > 0)
                {
                    txtUsername.Text = txtUsername.Text.Remove(txtUsername.Text.Length - 1);
                }
            }

            else
            {
                txtUsername.Text = txtUsername.Text + username;

            }
            userName = txtUsername.Text;
        }

        private void EnterCurrentPassword(string enCurPassword)
        {
            if (enCurPassword == "{BACKSPACE}")
            {
                if (txtBxEntCurrPassword.Text.Count() > 0)
                {
                    txtBxEntCurrPassword.Text = txtBxEntCurrPassword.Text.Remove(txtBxEntCurrPassword.Text.Length - 1);
                }
            }

            else
            {
                txtBxEntCurrPassword.Text = txtBxEntCurrPassword.Text + enCurPassword;
            }
            EntCurPassword = txtBxEntCurrPassword.Text;

        }

        private void EnterNewPassword(string entnewpassword)
        {
            if (entnewpassword == "{BACKSPACE}")
            {
                if (txtBxEnterNewPassword.Text.Count() > 0)
                {
                    txtBxEnterNewPassword.Text = txtBxEnterNewPassword.Text.Remove(txtBxEnterNewPassword.Text.Length - 1);
                }
            }

            else
            {
                txtBxEnterNewPassword.Text = txtBxEnterNewPassword.Text + entnewpassword;
            }

            EnNewPasswor = txtBxEnterNewPassword.Text;
        }

        //ConfirmNewPassword
        private void VerifyNewPassword(string confnewpassword)
        {
            if (confnewpassword == "{BACKSPACE}")
            {
                if (txtBxVerifyNewPassword.Text.Count() > 0)
                {
                    txtBxVerifyNewPassword.Text =
                        txtBxVerifyNewPassword.Text.Remove(txtBxVerifyNewPassword.Text.Length - 1);
                }
            }

            else
            {
                txtBxVerifyNewPassword.Text = txtBxVerifyNewPassword.Text + confnewpassword;
            }

            ConfirmNewPassword = txtBxVerifyNewPassword.Text;
        }


        private void setallToF()
        {
            IsUserName = false;
            IsPassword = false;
            IsEnCurPassword = false;
            IsEnNewPassword = false;
            IsConfirmNewPassword = false;
        }


        private void ClearErrorProvider()
        {
            if (errorProvider1.GetError(txtUsername) != string.Empty)
            {
                errorProvider1.SetError(txtUsername, string.Empty);
            }
            if (errorProvider1.GetError(txtPassword) != string.Empty)
            {
                errorProvider1.SetError(txtPassword, string.Empty);
            }
            if (errorProvider1.GetError(txtBxEntCurrPassword) != string.Empty)
            {
                errorProvider1.SetError(txtBxEntCurrPassword, string.Empty);
            }
            if (errorProvider1.GetError(txtBxEnterNewPassword) != string.Empty)
            {
                errorProvider1.SetError(txtBxEnterNewPassword, string.Empty);
            }
            if (errorProvider1.GetError(txtBxVerifyNewPassword) != string.Empty)
            {
                errorProvider1.SetError(txtBxVerifyNewPassword, string.Empty);
            }
        }

        private void UnlockedUser() //Unlock for now if the application is close
        {
            try
            {
                sc.Open();
                SqlCommand cmd =
                    new SqlCommand(@"update [dbo].[B3_Login]                                                                               
                                                 set Locked = 'F'
                                                 where LoginID = " + CurrentLoginID.LoginID, sc);
                cmd.ExecuteNonQuery();
                WriteLog.WriteLog_("", userName, "Unlocked due to number of attempt login will now be unlock",
                    GetCurrentMacID.MacAddress, "");
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


        private void btnMouseDown(object sender, MouseEventArgs e)
        {
            Button btn = (Button) sender;
            if (Convert.ToInt32(btn.Tag) == 1)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.LoginPressed;
            }
            else if (Convert.ToInt32(btn.Tag) == 2)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.ExitPressed;
            }
        }

        private void btnMouseUp(object sender, MouseEventArgs e)
        {
            Button btn = (Button) sender;
            if (Convert.ToInt32(btn.Tag) == 1)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.Login;
            }
            else if (Convert.ToInt32(btn.Tag) == 2)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.exit2;
            }
        }

        private void ClearErrorProviderInChangePasswords()
        {
            errorProvider1.SetError(txtBxEntCurrPassword, string.Empty);
            errorProvider1.SetError(txtBxEnterNewPassword, string.Empty);
            errorProvider1.SetError(txtBxVerifyNewPassword, string.Empty);
        }


        /// <summary>
        /// Change password view.
        /// </summary>
        private void ChangePasswordForUserUI()
        {
            btnClose.Visible = false;

            if (IspasswordExpired == false)
            {
                label1.Visible = false;
            }
            else
            {
                label1.Visible = true;
            }

            pnlLogIn.Visible = false;
            pnlLogIn.SendToBack();
            pnlChangePassword.BringToFront();
            pnlChangePassword.Visible = true;
            ClearAlTxtBxInLogin();
        }


        /// <summary>
        /// Login view.
        /// </summary>
        private void LoginDefault()
        {
            btnClose.Visible = true;
            pnlChangePassword.Visible = false;
            pnlChangePassword.SendToBack();
            pnlLogIn.Visible = true;
            pnlLogIn.BringToFront();
            ClearAlTxtBxInLogin();
            txtUsername.Select();
        }

        #endregion

        #region EVENTS

     
        /// <summary>
        ///Login
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void button1_Click(object sender, EventArgs e) //Login
        {
          
            CurrentUserLogged CurrentUserLogged = new CurrentUserLogged(txtUsername.Text);

            var databaseConnection = new DatabaseConnectionForm(false);
            if (!databaseConnection.IsValidDatabaseConnection())
            {
                var results = databaseConnection.ShowDialog();
                if (results == DialogResult.Cancel)
                {
                    return;
                }
            }

            //Validate username and password
            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))//?Does is it validate every single one of the controls?
                return;

            userName = txtUsername.Text;
            //Check if the user's password is correct
            bool passwordIsCorrect = false; passwordIsCorrect = IsPasswordCorrect();
            
            //Check if the current user is locked
            bool IsUserlocked = true; IsUserlocked = IsTheUserlocked();
            
            //Check if the user is active or not.
            bool isUserActive = false; isUserActive = IsTheUserActive();
            IspasswordExpired = PasswordExpired();


            //Check if the user is unlock due to attempt Login
            bool IsUserLockedDueToAttemptLogin = false; IsUserLockedDueToAttemptLogin = IsUserCurrentlyLockedDueToLoginAttempt.YesNo();


            if (IsUserLockedDueToAttemptLogin == true)
            {                
                //GetCurrentIDPerUser x = new GetCurrentIDPerUser();
                //UserLoginID = x.Get(userName);
                bool IsUserUnlock = UnlockedUserDueToAttemptLogin.YesNo(UserLoginID);//Check if the user already passed 30 min from the time he or she was locked.

                if (IsUserUnlock == false)
                {
                    lblYourPasswordOrUsernameX.Image = Properties.Resources.Lockedout2;
                    lblYourPasswordOrUsernameX.Visible = true;
                    WriteLog.WriteLog_("", userName, "Attempt to log into locked account", GetCurrentMacID.MacAddress, "");
                    ClearAlTxtBxInLogin();
                    return;
                }
                else
                {
                    //Unlocked the user. 
                    try
                    {
                        sc.Open();
                        SqlCommand cmd = new SqlCommand("Update b3_Login set lockedDueToLoginFailedAttempt = 'F', Locked = 'F'  where loginID = " + UserLoginID, sc);
                        cmd.ExecuteNonQuery();

                        IsUserlocked = false;//IsTheUserlocked();//Why did we call again?
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

            //Check if the  password is expired from the last time he/change it.
            if (IsUserExists == true && passwordIsCorrect == true)
            {
                if (isUserActive == true)
                {
                    //Check if its locked
                    if (IsUserlocked == false)
                    {
                        //Check if the password is expired 
                        if (IspasswordExpired == false)
                        {
                            //if all of this condition is passed then lets launch the application 
                            try
                            {
                                //IspasswordExpired = false;
                                UserLogList.useloglist.Clear();

                                //Record this on auditlog table             
                                WriteLog.WriteLog_("", userName, "Login successful", GetCurrentMacID.MacAddress, "");

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

                                FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                                txtPassword.Text = string.Empty;
                                txtUsername.Text = string.Empty;
                                this.Hide();

                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show(ex.Message);
                            }
                        }
                        else//expired password
                        {
                            pnlLogIn.Visible = false;
                            pnlChangePassword.Visible = true;
                            label1.Visible = true;
                            IschangePassword = false;
                            txtBxEntCurrPassword.Select();
                            ClearAlTxtBxInLogin();

                            //Logged this activity that this user password is expired.
                            WriteLog.WriteLog_("", userName, "Password expired needs update", GetCurrentMacID.MacAddress, "");
                        }
                    }
                    else//UserIs locked
                    {
                        lblYourPasswordOrUsernameX.Image = Properties.Resources.Lockedout2;
                        WriteLog.WriteLog_("", userName, "Attempt to log into locked account", GetCurrentMacID.MacAddress, "");
                        lblYourPasswordOrUsernameX.Visible = true;
                    }
                }
                else //User is inactive
                {
                    lblYourPasswordOrUsernameX.Image = Properties.Resources.Inactive;
                    lblYourPasswordOrUsernameX.Visible = true;
                }
            }
            else//Password and username is incorrect
            {
                //if username is correct and the password is incorrect
                if (IsUserExists == true && IsUserlocked == false && isUserActive == true) //Lets count the attempt only if 3 of the condition is true else just let him know Incorrect Pasword
                {
                    CurrentLoginID u = new CurrentLoginID();
                    u.Get();

                    if (txtUsername.Text != string.Empty && txtPassword.Text != string.Empty)
                    {
                        //Check if the user exists in our list
                        if (UserLogList.useloglist.Exists(l => l.username == userName))
                        {
                            //Update this user
                            lblYourPasswordOrUsernameX.Image = Properties.Resources.IncorrectUsernameOrPassword2;
                            lblYourPasswordOrUsernameX.Visible = true;
                            ClearAlTxtBxInLogin();
                            int NlogAttempt = 0;//= get.Get(userName);
                            Userlog x = UserLogList.useloglist.Single(l => l.username == userName);
                            NlogAttempt = x.NlogAttempt + 1;

                            if (NlogAttempt == GetSecuritySettings.PrevPasswordLockoutAttempts)
                            {
                                lblYourPasswordOrUsernameX.Image = Properties.Resources.AccountLockedOut2;
                                lblYourPasswordOrUsernameX.Visible = true;
                                ClearAlTxtBxInLogin();

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
                                    x.NlogAttempt = 0;
                                    x.IsLockedDueToFailedAttempt = true;

                                    return;
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
                            else //if it did not reach the limit yet.
                            {
                                //Update it
                                x.NlogAttempt = NlogAttempt;

                                //Write it to log
                                //WriteLog.WriteLog_("", userName, "Login attempt = " + NlogAttempt.ToString(), GetCurrentMacID.MacAddress, "");
                                WriteLog.WriteLog_("", userName, "Incorrect password entered" /*+ data.NlogAttempt.ToString()*/, GetCurrentMacID.MacAddress, "");
                                //Lets update the db
                                try
                                {
                                    sc.Open();
                                    SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]
                                                                          set NofLoginAttempt = " + NlogAttempt + " ,LockedDueToAttemptTime = getdate() where UserName = '" + userName + "'", sc);//lets their username for now
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
                        else //if dont exists
                        {
                            //data.NlogAttempt = NlogInTry + 1;
                            //lets get the number of attempt per user
                            GetNOfLoginAttemptPerUser get = new GetNOfLoginAttemptPerUser();
                            int x = get.Get(userName);

                            if (x + 1 != GetSecuritySettings.PrevPasswordLockoutAttempts)
                            {
                                lblYourPasswordOrUsernameX.Image = Properties.Resources.IncorrectUsernameOrPassword2;
                                lblYourPasswordOrUsernameX.Visible = true;
                                ClearAlTxtBxInLogin();

                                //lets add it
                                Userlog data = new Userlog();
                                data.username = userName;

                                data.NlogAttempt = x + 1; NlogInTry = x + 1;

                                //add the record to our recorder.
                                UserLogList.useloglist.Add(data);

                                //lets write it to log
                                WriteLog.WriteLog_("", userName, "Incorrect password entered" /*+ data.NlogAttempt.ToString()*/, GetCurrentMacID.MacAddress, "");

                                //Update the DB 
                                try
                                {
                                    sc.Open();
                                    SqlCommand cmd = new SqlCommand(@"update [dbo].[B3_Login]
                                                                          set NofLoginAttempt = ISnull(NofLoginAttempt + " + 1 + @", 1)  
                                                                          ,LockedDueToAttemptTime = getdate()
                                                                          where LoginID = " + CurrentLoginID.LoginID, sc);
                                    cmd.ExecuteNonQuery();
                                    return;
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
                            else //if it matched
                            {

                                lblYourPasswordOrUsernameX.Image = Properties.Resources.AccountLockedOut2;
                                lblYourPasswordOrUsernameX.Visible = true;

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

                                    return;
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
                }
                else if (IsUserExists == true && IsUserlocked == true)
                {
                    lblYourPasswordOrUsernameX.Image = Properties.Resources.Lockedout2;
                    lblYourPasswordOrUsernameX.Visible = true;
                }
                else
                {
                    lblYourPasswordOrUsernameX.Image = Properties.Resources.IncorrectUsernameOrPassword2;
                    lblYourPasswordOrUsernameX.Visible = true;
                    WriteLog.WriteLog_("", userName, "User does not exist", GetCurrentMacID.MacAddress, "");
                }
            }

            ClearAlTxtBxInLogin();
        }    

        /// <summary>
        ///Close the application.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void button2_Click(object sender, EventArgs e)//Exit
        {
            WriteLog.WriteLog_("", "", "Application closed.", GetCurrentMacID.MacAddress, "");
            this.Close();
        }

        /// <summary>
        ///Enter character into the active textbox.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void virtualKeyboard1_KeyPressed(object sender, KeyboardEventArgs e)
        {
            VirtualKeyboard KeyBoard = (VirtualKeyboard)sender;

            if (KeyBoard.m_keys != "{ENTER}")// || KeyBoard.m_keys != "{TAB}")
            {
                if (KeyBoard.m_keys != "{TAB}")
                {
                    if (IsUserName == true)
                    {
                        UserName(KeyBoard.m_keys);
                    }
                    else if (IsPassword == true)
                    {
                        Password(KeyBoard.m_keys);
                    }
                    else if (IsEnCurPassword == true)
                    {
                        EnterCurrentPassword(KeyBoard.m_keys);
                    }
                    else if (IsEnNewPassword == true)
                    {
                        EnterNewPassword(KeyBoard.m_keys);
                    }
                    else if (IsConfirmNewPassword == true)
                    {
                        VerifyNewPassword(KeyBoard.m_keys);
                    }
                }
            }
            else
            {//ENTER
                btnLogin.PerformClick();
            }
        }

        /// <summary>
        ///Assign which textbox is active.
        ///Virtual keyboard will determine which textbox is active.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtUsername_Click(object sender, EventArgs e)
        {
            TextBox CtxtBx = (TextBox)sender;
            ClearErrorProvider();

            //Hide invalid username or password.
            if (lblYourPasswordOrUsernameX.Visible != false)
            {
                lblYourPasswordOrUsernameX.Visible = false;
            }

            setallToF();

            if (Convert.ToInt32(CtxtBx.Tag) == 1)
            {
                IsUserName = true;
            }
            else if (Convert.ToInt32(CtxtBx.Tag) == 2)
            {
                IsPassword = true;
            }
        }

        /// <summary>
        ///Enable or disable password textbox
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtUsername_TextChanged(object sender, EventArgs e)
        {
            ClearErrorProvider();
            if (txtPassword.Text != string.Empty) { txtPassword.Text = string.Empty; }


            if (txtUsername.Text.Count() > 0)
            {
                if (txtPassword.Enabled != true)
                {
                    txtPassword.Enabled = true;
                    txtPassword.BackColor = Color.White;
                }
            }
            else//If username is empty then disable the password textbox.
            {
                if (txtPassword.Enabled != false)
                {
                    txtPassword.Enabled = false;
                    txtPassword.BackColor = Color.Gray;
                    txtPassword.Text = string.Empty;
                }
            }
        }

        /// <summary>
        ///Show virtual keyboard or not.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void chkHideKeyBoard_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkbx = (CheckBox)sender;

            if (Convert.ToInt32(chkbx.Tag) == 1)//CheckBox_Keyboard_Login
            {
                if ( myChkShowVKeyBoard.Checked == false)
                {
                    if (virtualKeyboard1.Visible != false)
                    {
                        virtualKeyboard1.Visible = false;
                    }
                }
                else
                {
                    if (virtualKeyboard1.Visible != true)
                    {
                        virtualKeyboard1.Visible = true;
                    }
                }
            }
            else if (Convert.ToInt32(chkbx.Tag) == 2)//Checkbox_Keyboard_ChangePassword
            {
                if (  myChkShowVKeyBoard2.Checked == false)
                {
                    if (virtualKeyboard1.Visible != false)
                    {
                        virtualKeyboard1.Visible = false;
                    }
                }
                else
                {
                    if (virtualKeyboard1.Visible != true)
                    {
                        virtualKeyboard1.Visible = true;
                    }
                }
            }
        }


        /// <summary>
        /// Activate the new menu window or the login panel.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void imageButton1_Click(object sender, EventArgs e)//ChangePassword Cancel button
        {
   
            if (IschangePassword == false)
            {
                LoginDefault();
            }
            else
            {
                IschangePassword = false;
                //IschangePassword = true;
                FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                txtPassword.Text = string.Empty;
                txtUsername.Text = string.Empty;
                this.Hide();
            }


        }


        /// <summary>
        /// Assign which textbox is active.
        /// </summary>
        /// <remarks> 
        /// Whenever a user uses the VirtualKeyboard, the active textbox  are the one  being populated with character.
        /// </remarks>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtBxEntCurrPassword_Click(object sender, EventArgs e)
        {
            TextBox CtxtBx = (TextBox)sender;

            setallToF();

            if (Convert.ToInt32(CtxtBx.Tag) == 3)
            {
                IsEnCurPassword = true;
            }
            else if (Convert.ToInt32(CtxtBx.Tag) == 4)
            {
                IsEnNewPassword = true;
            }
            else if (Convert.ToInt32(CtxtBx.Tag) == 5)
            {

                IsConfirmNewPassword = true;
            }
        }


        /// <summary>
        /// Save new password for current user.
        /// </summary>summary>
        /// <remarks>
        /// <para>
        /// If "Ischangepassword" is false then current user's password is expired.
        /// If "Ischangepassword" is true then the current users already have access to the main menu.
        /// </para>
        /// </remarks>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void imgBtnSaveNewPassword_Click(object sender, EventArgs e)
        { 
            int loginID = 0;
            CurrentLoginID clID = new CurrentLoginID();
            loginID = clID.Get();//get currents user login ID

            //Current password. 
            //Checked if it match its current password
            if (txtBxEntCurrPassword.Text != string.Empty)
            {
                UserCurrentPassword usercurrentpassword = new UserCurrentPassword();
                string userpassword = usercurrentpassword.Get();

                if (userpassword != txtBxEntCurrPassword.Text)
                {
                    errorProvider1.SetError(txtBxEntCurrPassword, "The old password is incorrect.");
                    return;
                }
            }
            else if (txtBxEntCurrPassword.Text == string.Empty)
            { 
                errorProvider1.SetError(txtBxEntCurrPassword, "Current password is empty.");
                return;
            }

            //Newpassword. 
            //Checked if the new password comply with the password complexity requirements if true.
            //Checked if the new password can be reused.
            if (txtBxEnterNewPassword.Text != string.Empty)
            {
                if (GetSecuritySettings.UsePasswordComplexity == true)
                {
                    bool PasswordMeetReq = PasswordPolicy.IsValid(txtBxEnterNewPassword.Text);
                    if (PasswordMeetReq == false)
                    {
                        PasswordPolicy pl = new PasswordPolicy();
                        errorProvider1.SetError(txtBxEnterNewPassword, PasswordPolicy.MessageForPasswordLengthRequirements /*"Password did not meet requirements."*/);
                        return;
                    }
                }
                else
                {
                    bool PasswordMeetReq = PasswordPolicy.IsValidPComplexOff(txtBxEnterNewPassword.Text);
                    if (PasswordMeetReq == false)
                    {
                        errorProvider1.SetError(txtBxEnterNewPassword, PasswordPolicy.MessageForPasswordLengthRequirements /*"Password did not meet requirements."*/);
                        return;
                    }
                }
                bool PasswordReuse = IsPasswordReusable.IsPasswordReusable_(loginID/*CurrentLoginID.LoginID*/, txtBxEnterNewPassword.Text);
                if (PasswordReuse == false)
                {
                    errorProvider1.SetError(txtBxEnterNewPassword, "The password does not meet the password reuse requirements.");
                    return;
                }
            }
            else if (txtBxEnterNewPassword.Text == string.Empty)
            {
                errorProvider1.SetError(txtBxEnterNewPassword, "New password is empty.");
                return;
            }

            //Verify password.
            //Checked if it matches the newpassword.
            if (txtBxVerifyNewPassword.Text != string.Empty)
            {
                if (txtBxEnterNewPassword.Text != txtBxVerifyNewPassword.Text)
                {
                    errorProvider1.SetError(txtBxVerifyNewPassword, "The password does not match the confirm password.");
                    return;
                }
            }
            else if (txtBxVerifyNewPassword.Text == string.Empty)
            {
                errorProvider1.SetError(txtBxVerifyNewPassword, "Verify new password.");
                return;
            }

            try
            {
             
                FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");//Open main menu window
                txtPassword.Text = string.Empty;
                txtUsername.Text = string.Empty;
                this.Hide();
                UserLogList.useloglist.Clear();

                if (IschangePassword == false)
                {
                    CurrentUserLoggedIn cUserLoggedIn = new CurrentUserLoggedIn();//clear
                    CurrentUserLoggedIn.username = userName;//save
                    CurrentUserLoggedIn.id = loginID;//save
                }

                //Update password in db.
                try
                {
                    sc.Open();
                    SqlCommand cmd = new SqlCommand("exec usp_management_SecuritySettings_UpdateUser @LoginIDsp = " + loginID + " ,@CurrentUserLoginsp = '" + CurrentUserLoggedIn.username + "', @UserPasswordsp = '" + txtBxEnterNewPassword.Text + "', @MacAddresssp = '" + GetCurrentMacID.MacAddress + "'", sc);
                    cmd.ExecuteNonQuery();
                    sc.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        /// <summary>
        /// Determine if it is a change password view or login window.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void LoginFullWin_VisibleChanged(object sender, EventArgs e)
        {
            Form x = (Form)sender;
            if (x.Visible == true)
            {
                if (IschangePassword == true)
                {
                    ChangePasswordForUserUI();
                    ClearErrorProviderInChangePasswords();

                    if (myChkShowVKeyBoard2.Checked == true)
                    {
                        if (virtualKeyboard1.Visible != true)
                        {
                            virtualKeyboard1.Visible = true;
                        }
                    }
                    else
                    {
                        if (virtualKeyboard1.Visible != false)
                        {
                            virtualKeyboard1.Visible = false;
                        }
                    }
                }
                else if (IschangePassword == false)
                {
                    LoginDefault();

                    if (myChkShowVKeyBoard.Checked == true)
                    {
                        if (virtualKeyboard1.Visible != true)
                        {
                            virtualKeyboard1.Visible = true;
                        }
                    }
                    else
                    {
                        if (virtualKeyboard1.Visible != false)
                        {
                            virtualKeyboard1.Visible = false;
                        }
                    }
                }
            }
        }


        /// <summary>
        /// Whenever a user press login button this will trigger the event click "button1_Click" on the btnLogin controls.
        /// </summary>
        /// <remarks>(char)13 = "Enter Button" </remarks>
        ///   /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtPassword_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                btnLogin.PerformClick();
            }
        }
 
        /// <summary>
        /// Close the application whenever a user press the close button. 
        /// </summary>
        /// <remarks>The application is getting a unhandled exception message whenever a user try to close the app.. </remarks>
        ///   /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void LoginFullWin_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        /// <summary>
        /// Certain textbox will be empty whenever they tried to change/add character.
        /// </summary>
        /// <remarks>
        /// tag 3 = txtBxEntCurrPassword; tag 4 = txtBxEnterNewPassword
        /// If the user change/add any character into the old password textbox then newpassword textbox and confirm password textbox will be empty.
        /// If the user change/add any character into the new password textbox then  confirm password textbox will be empty. 
        /// </remarks>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtBxEntCurrPassword_TextChanged(object sender, EventArgs e)
        {
            TextBox ctxtbx = (TextBox)sender;

            //if current password textbox is modified then empty new password and verify passwoprd textbox.
            if (Convert.ToInt32(ctxtbx.Tag) == 3)
            {
                if (txtBxEnterNewPassword.Text != string.Empty)
                {
                    txtBxEnterNewPassword.Text = string.Empty;
                }

                if (txtBxVerifyNewPassword.Text != string.Empty)
                {
                    txtBxVerifyNewPassword.Text = string.Empty;
                }
            }

            //if new password textbox is changed then empty verify password
            if (Convert.ToInt32(ctxtbx.Tag) == 4)
            {
                if (txtBxVerifyNewPassword.Text != string.Empty)
                {
                    txtBxVerifyNewPassword.Text = string.Empty;
                }
            }

            //clear errorprovider.
            ClearErrorProvider();

        }

        /// <summary>
        /// This will set/moved all the windows location.
        /// </summary>
        /// <remarks>
        /// It will save the new point into a class "WindowsDefaultLocation" that holds X, Y value.
        /// </remarks>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }

        #region Events(Validate)

        /// <summary>
        ///Validate password.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            if (txtPassword.Text == string.Empty)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtPassword, "Enter a password.");
            }
        }

        /// <summary>
        ///Validate username.
        /// </summary>
        /// <remarks>
        /// <para>
        /// Check if the user exists return true or false to  variable IsUserExists.
        /// </para>
        /// </remarks>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains the 
        /// event data.</param>
        private void txtUsername_Validating(object sender, CancelEventArgs e)
        {
            if (txtUsername.Text == string.Empty)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtUsername, "Enter a user login.");
            }

            //Check if the user exists
            string userName = txtUsername.Text;
            sc.Open();
            using (SqlCommand cmd = new SqlCommand("select count(*) from dbo.B3_Login where UserName = @UserName", sc))
            {
                cmd.Parameters.AddWithValue("UserName", userName);
                IsUserAlreadyExists = (int)cmd.ExecuteScalar() > 0;
            }

            if (IsUserAlreadyExists == true)
            {
                GetCurrentIDPerUser x = new GetCurrentIDPerUser();
                UserLoginID = x.Get(userName);

                CurrentUserLoggedIn cUserLoggedIn = new CurrentUserLoggedIn();//clear
                CurrentUserLoggedIn.username = userName;//save
                CurrentUserLoggedIn.id = UserLoginID;//save

            }
            IsUserExists = IsUserAlreadyExists;//it exists but we do not know yet if its unlock or inactive
            //I can validate this one on this section or just create a message box on the click login event. I choose Login event.
            sc.Close();
        }

        #endregion

        #endregion
    

    }
}
