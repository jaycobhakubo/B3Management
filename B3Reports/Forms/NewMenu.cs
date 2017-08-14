using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;


namespace GameTech.B3Reports.Forms
{

    public partial class NewMenu : Form
    {
       // GetSystemConfig SystemConfig;


        public NewMenu()
        {
            InitializeComponent();
            AdjustWindowSize.adjust(this);

        }

        #region EVENT

        /// <summary>
        /// Load main menu
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void NewMenu_Load(object sender, EventArgs e)
        {
            if (GetSecuritySettings.LogoutInactivity != 0)
            {
                //idleTimeStart();
                IdleTimeStart start = new IdleTimeStart();
                start.StartTimer(this);
            }

            GetGameSettingsCrazyBout GameSettingsCrazyBout = new GetGameSettingsCrazyBout();
            GetGameSettingJailbreak GameSettingsJailBreak = new GetGameSettingJailbreak();
            GetGameSettingsMayaMoney GameSettingsMayaMoney = new GetGameSettingsMayaMoney();
            GetPlayerSettings PlayerSettings = new GetPlayerSettings();//Get the player Settings.
            //SystemConfig = new GetSystemConfig();
     
            //WindowsDefaultLocation Loc = new WindowsDefaultLocation();
            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);

            ActivatePermission(); //Only show the allow permission per staff

         

        }

        private void imgBtn_Reports_Click(object sender, EventArgs e)
        {

            try
            {

                if (!ActivateForm.NOW("WideForm"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.WideForm");
                }
                this.Visible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }


        private void imgBtn_Settings_Click(object sender, EventArgs e)
        {
            try
            {

                if (!ActivateForm.NOW("SecurityForm"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.SecurityForm");
                }
                this.Visible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }


            //  SecurityForm.selectFirstRowListUserNameFromNewMenu();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            WriteLog.WriteLog_("", CurrentUserLoggedIn.username, "Quit application", GetCurrentMacID.MacAddress, "");
            Application.Exit();
        }

        private void button1_KeyDown(object sender, KeyEventArgs e)
        {
            //btnExit.
        }

        private void btnMouseDown(object sender, MouseEventArgs e)
        {
            Button btn = (Button)sender;
            if (Convert.ToInt32(btn.Tag) == 5)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.LogoutPressed;
            }
        }

        private void btnMouseUp(object sender, MouseEventArgs e)
        {

            Button btn = (Button)sender;
            if (Convert.ToInt32(btn.Tag) == 5)
            {
                btn.BackgroundImage = GameTech.B3Reports.Properties.Resources.Logout;
            }
        }

        private void btnLogout(object sender, EventArgs e)
        {
            WriteLog.WriteLog_("", CurrentUserLoggedIn.username, "Logout successful", GetCurrentMacID.MacAddress, "");

            try
            {
                LoginFullWin.IschangePassword = false;
                if (!ActivateForm.NOW("loginFullWin"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.loginFullWin");
                }
                else
                {
                    this.Visible = false;

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void imgBtnSettings_Click(object sender, EventArgs e)
        {
            try
            {

                if (!ActivateForm.NOW("SystemSettings"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.SystemSettings");
                }


                this.Visible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        private void imgBtnChangePassword_Click(object sender, EventArgs e)
        {

            try
            {
                LoginFullWin.IschangePassword = true;

                if (!ActivateForm.NOW("loginFullWin"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.loginFullWin");
                }
                else
                {
                    this.Visible = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void imageButton1_Click(object sender, EventArgs e)
        {
            try
            {

                if (!ActivateForm.NOW("DisputeResolution"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.DisputeResolution");
                }


                this.Visible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }

        private void NewMenu_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void NewMenu_VisibleChanged(object sender, EventArgs e)
        {
            Form mainMenu = (Form)sender;
            if (mainMenu.Visible == true)
            { ActivatePermission(); }
        }



        #endregion

        #region METHOD

        private void ActivatePermission()
        {
            StaffManagementPermisions smgmtp;
            GetStaffMgmtPermissions gsmgmtp = new GetStaffMgmtPermissions();

            smgmtp = gsmgmtp.GetMgmtStaffPermissions(CurrentUserLoggedIn.id);

            List<Button> MgmtBtnModule = new List<Button>();

            if (smgmtp.MgmtReports == true)
            {
                imgBtn_Reports.Visible = true;
                MgmtBtnModule.Add(imgBtn_Reports);
            }
            else
            {
                imgBtn_Reports.Visible = false;
            }


            if (smgmtp.MgmtSecurity == true)
            {
                imgBtnSecurity.Visible = true;
                MgmtBtnModule.Add(imgBtnSecurity);
            }
            else
            {
                imgBtnSecurity.Visible = false;
            }

            if (smgmtp.MgmtSystemSettings == true)
            {
                imgBtnSettings.Visible = true;
                MgmtBtnModule.Add(imgBtnSettings);
            }
            else
            {
                imgBtnSettings.Visible = false;
            }

            if (smgmtp.MgmtDisputeResolution == true)
            {
                imageButton1.Visible = true;
                MgmtBtnModule.Add(imageButton1);
            }
            else
            {
                imageButton1.Visible = false;

            }

            int count = 0;
            label2.Visible = false; label3.Visible = false; label4.Visible = false; label5.Visible = false;
            foreach (Button btnMainMenu in MgmtBtnModule)
            {
                if (count == 0)
                {
                    btnMainMenu.Location = new Point(163, 122);
                    label5.Text = btnMainMenu.Tag.ToString();
                    label5.Visible = true;

                }
                else if (count == 1)
                {
                    btnMainMenu.Location = new Point(439, 122);
                    label2.Text = btnMainMenu.Tag.ToString();
                    label2.Visible = true;
                }
                else if (count == 2)
                {
                    btnMainMenu.Location = new Point(710, 122);
                    label3.Text = btnMainMenu.Tag.ToString();
                    label3.Visible = true;
                }
                else if (count == 3)
                {
                    btnMainMenu.Location = new Point(163, 295);
                    label4.Text = btnMainMenu.Tag.ToString();
                    label4.Visible = true;
                }

                count = count + 1;

            }
        }
        #endregion

        #region ref1

        //private void CheckIdleTimer_Tick(object sender, EventArgs e)
        //{
        //    //1 min = 60 sec
        //    //1 sec = 1000
        //    //1 min = 60000

        //    int IdleinSec = Convert.ToInt32(GetSecuritySettings.LogoutInactivity) * 60000 ;

        //    if (Convert.ToInt32(GetSecuritySettings.LogoutInactivity) == 0)
        //    {
        //        CheckIdleTimer.Stop();
        //        CheckIdleTimer.Enabled = false;
        //    }

        //    if (Win32.GetIdleTime() >= IdleinSec && Convert.ToInt32(GetSecuritySettings.LogoutInactivity) != 0)
        //    {

        //        try
        //        {
        //            FormCollection fc = Application.OpenForms;
        //            foreach (Form frm in fc)
        //            {

        //                if (frm.Name.ToUpper()  != "LoginFullWin")
        //                {
        //                    frm.Hide();
        //                }
        //            }

        //            if (!ActivateForm.NOW("LoginFullWin"))//check the form if its already loaded 
        //            {
        //                FireForm.Fire("GameTech.B3Reports.Forms.LoginFullWin");
        //            }

        //            WriteLog.WriteLog_("", CurrentUserLoggedIn.username, "Inactivity Logout", GetCurrentMacID.MacAddress, "");

        //            this.Visible = false;
        //            this.Hide();


        //        }
        //        catch (Exception ex)
        //        {
        //            MessageBox.Show(ex.Message);

        //        }
        //        IdleTimeStop();
        //    }

        //}

        #endregion

        #region ref2
        // StaffManagementPermisions smgmtp;
        // GetStaffMgmtPermissions gsmgmtp = new GetStaffMgmtPermissions();

        // smgmtp = gsmgmtp.GetMgmtStaffPermissions(CurrentUserLoggedIn.id);

        // List<Button> MgmtBtnModule = new List<Button>();

        // if (smgmtp.MgmtReports == true)
        // {
        //     imgBtn_Reports.Visible = true;
        //    // label1.Visible = true;
        //     MgmtBtnModule.Add(imgBtn_Reports);
        // }
        // else
        // {
        //     imgBtn_Reports.Visible = false;
        //   //  label1.Visible = false;
        // }


        // if (smgmtp.MgmtSecurity == true)
        // {
        //     imgBtnSecurity.Visible = true;
        //  //   label2.Visible = true;
        //     MgmtBtnModule.Add(imgBtnSecurity);
        // }
        // else
        // {
        //     imgBtnSecurity.Visible = false;
        //    // label2.Visible = false;
        // }

        // if (smgmtp.MgmtSystemSettings == true)
        // {
        //     imgBtnSettings.Visible = true;
        ////     label3.Visible = true;
        //     MgmtBtnModule.Add(imgBtnSettings);
        // }
        // else
        // {
        //     imgBtnSettings.Visible = false;
        //   //  label3.Visible = false;    
        // }

        // if (smgmtp.MgmtDisputeResolution == true)
        // {
        //     imageButton1.Visible = true;
        //  //   label4.Visible = true;
        //     MgmtBtnModule.Add(imageButton1);
        // }
        // else
        // {
        //     imageButton1.Visible = false;
        //   //  label4.Visible = false;
        // }

        // int count = 0;
        // label2.Visible = false; label3.Visible = false; label4.Visible = false; label5.Visible = false;
        //   foreach(Button btnMainMenu in MgmtBtnModule)
        //   {
        //       if (count == 0) 
        //       {
        //           btnMainMenu.Location = new Point(163, 122);
        //            label5.Text = btnMainMenu.Tag.ToString();
        //            label5.Visible = true;

        //       }
        //       else if (count == 1)
        //       {
        //           btnMainMenu.Location = new Point(439, 122);
        //           label2.Text = btnMainMenu.Tag.ToString();
        //           label2.Visible = true;
        //       }
        //       else if (count == 2)
        //       {
        //           btnMainMenu.Location = new Point(710, 122);
        //           label3.Text = btnMainMenu.Tag.ToString();
        //           label3.Visible = true;
        //       }
        //       else if (count == 3)
        //       {
        //           btnMainMenu.Location = new Point(163, 295);
        //           label4.Text = btnMainMenu.Tag.ToString();
        //           label4.Visible = true;
        //       }

        //       count = count + 1;

        //   }

        //List<bool> LmgmtStaffPermissions = new List<bool>();
        //LmgmtStaffPermissions.Add(smgmtp.MgmtReports);
        //LmgmtStaffPermissions.Add(smgmtp.MgmtSecurity);
        //LmgmtStaffPermissions.Add(smgmtp.MgmtSystemSettings);
        //LmgmtStaffPermissions.Add(smgmtp.MgmtDisputeResolution);

        //int count = 0;
        //while (LmgmtStaffPermissions.Count != count)
        //{

        //    count = count + 1;
        //}
        #endregion

    }
}
