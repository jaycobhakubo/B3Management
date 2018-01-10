//using System;
//using System.Collections.Generic;

//REf#(D:\fortunet\gti-gametech\Dev\ClientModules\SystemSettings\UI\SecuritySettings.cs)

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
    public partial class SecuritySettings : SettingsControl
    {
        // Members
        //bool m_bModified = false;

        public SecuritySettings()
        {
            InitializeComponent();
            LoadSettings();//are we loading this, everytime we open this UI?
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadSecuritySettings();
            this.ResumeLayout(true);
            IsModified = false;
            return bResult;
        }

        public override bool SaveSettings()
        {
            Cursor x = Cursors.WaitCursor;  //  Common.BeginWait();        
            bool bResult = SaveSecuritySettings();
            x = Cursors.Default; // Common.EndWait();
            IsModified = false;
            return bResult;
        }


        private bool LoadSecuritySettings()
        {
            
            GetSecuritySettings gss = new GetSecuritySettings();

            clearError();
            //This will fixed issue if the user enter a blank value.
            if (numMinimumPasswordLength.Value == GetSecuritySettings.MinPasswordLength)
            {
                numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength + 1;
            }

            if (numPreviousPasswordReuse.Value == GetSecuritySettings.PrevPasswordReuseN)
            {
                if (GetSecuritySettings.PrevPasswordReuseN >= 100)
                {
                    numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN;
                }
                else
                {
                    numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN + 1;
                }
            }

            if (numPasswordLockOutAttempts.Value == GetSecuritySettings.PrevPasswordLockoutAttempts)
            {
                if (GetSecuritySettings.PrevPasswordLockoutAttempts >= 100)
                {
                    numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts;
                }
                else
                {
                numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts + 1;
                 }
            }

            if (numPinExpireDays.Value == GetSecuritySettings.NPasswordsExpireDays)
            {
                if (GetSecuritySettings.NPasswordsExpireDays >= 100)
                {
                    numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays;
                }
                else
                {
                    numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays + 1;
                }
            }

            if (numMaxLoginLimit.Value == GetSecuritySettings.MaximumMachineLoginLimit)
            {
                numMaxLoginLimit.Value = GetSecuritySettings.MaximumMachineLoginLimit + 1;
            }

            if (numMinWaitTimeBeforeLogout.Value == GetSecuritySettings.LogoutInactivity)
            {
                numMinWaitTimeBeforeLogout.Value = GetSecuritySettings.LogoutInactivity + 1;
            }

            numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength;           
            numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN;
            numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts;
            numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays;
            numMaxLoginLimit.Value = GetSecuritySettings.MaximumMachineLoginLimit;
            if (GetSecuritySettings.UsePasswordComplexity == true)
            {
                chkUsePasswordComplexity.Checked = true;
            }
            else
            {
                chkUsePasswordComplexity.Checked = false;
            }

            numMinWaitTimeBeforeLogout.Value = GetSecuritySettings.LogoutInactivity;
            return true;
        }



        private bool  SaveSecuritySettings()
        {
            bool result = true;
            bool IsPasswordComplexity = false;
            if (chkUsePasswordComplexity.Checked == true)
            {
                IsPasswordComplexity = true;
            }
            else
            { IsPasswordComplexity = false; }


            if (IsPasswordComplexity == true && (int)numMinimumPasswordLength.Value < 3)
            {
                errorProvider1.SetError(numMinimumPasswordLength, "Lenght must be atleast 3 or turn off password complexity");
                result = false;
            }
            else
            {

                //lets write to log
                if (GetSecuritySettings.MinPasswordLength != (int)numMinimumPasswordLength.Value)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Password Length.", GetSecuritySettings.MinPasswordLength.ToString(), numMinimumPasswordLength.Value.ToString());
                }
            
                if ( GetSecuritySettings.PrevPasswordReuseN != (int)numPreviousPasswordReuse.Value)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Previous Password Reuse Number", GetSecuritySettings.PrevPasswordReuseN.ToString(), numPreviousPasswordReuse.Value.ToString());
                }

                if (GetSecuritySettings.PrevPasswordLockoutAttempts != (int)numPasswordLockOutAttempts.Value)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Password Lockout Attempt", GetSecuritySettings.PrevPasswordLockoutAttempts.ToString(), numPasswordLockOutAttempts.Value.ToString());
                }

                if (GetSecuritySettings.NPasswordsExpireDays != (int)numPinExpireDays.Value)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Password Expire Days", GetSecuritySettings.NPasswordsExpireDays.ToString(), numPinExpireDays.Value.ToString());
                }

                if ( GetSecuritySettings.UsePasswordComplexity != IsPasswordComplexity)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Use Password Complexity", GetSecuritySettings.UsePasswordComplexity.ToString(), IsPasswordComplexity.ToString());
                }

                if (GetSecuritySettings.LogoutInactivity != numMinWaitTimeBeforeLogout.Value)
                {
                    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Logout Inactivity Wait Time(min)", GetSecuritySettings.LogoutInactivity.ToString(), numMinWaitTimeBeforeLogout.Value.ToString());
                }

           


                GetSecuritySettings.MinPasswordLength = (int)numMinimumPasswordLength.Value;
                GetSecuritySettings.PrevPasswordReuseN = (int)numPreviousPasswordReuse.Value;
                GetSecuritySettings.PrevPasswordLockoutAttempts = (int)numPasswordLockOutAttempts.Value;
                GetSecuritySettings.NPasswordsExpireDays = (int)numPinExpireDays.Value;
                GetSecuritySettings.UsePasswordComplexity = IsPasswordComplexity;
                GetSecuritySettings.LogoutInactivity = (int)numMinWaitTimeBeforeLogout.Value;

                //int test2 = GetSecuritySettings.MinPasswordLength;
                //int test3 = 1;
                //Save it to DB
                SetSecuritySettings Set = new SetSecuritySettings();

            }
            return result;
           
        }

        private void numMinimumPasswordLength_KeyPress(object sender, KeyPressEventArgs e)
        {
            clearError();
            bool result = true;
            if (e.KeyChar == (char)Keys.Back)
            {
                result = false;

            }
            if (result)
            {
                result = !char.IsDigit(e.KeyChar);
            }

            e.Handled = result;
        }

        public void clearError()
        {
            errorProvider1.SetError(numMinimumPasswordLength, string.Empty);
        }

        private void chkUsePasswordComplexity_CheckedChanged(object sender, EventArgs e)
        {
            IsModified = true;
            clearError();
            CheckBox x = (CheckBox)sender;

            if (x.Checked == true)
            {
                if ((int)numMinimumPasswordLength.Value < 3)
                {
                    //numMinimumPasswordLength.Value = 3;
                }
            }
        }

        private void numMinimumPasswordLength_ValueChanged(object sender, EventArgs e)
        {
            IsModified = true;
            //NumericUpDown NumericUD = (NumericUpDown)sender;
            //if (NumericUD.Value.ToString() == string.Empty)
            //{
            //    numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength;
            //}
                clearError();
        }

        private void chkUsePasswordComplexity_MouseHover(object sender, EventArgs e)
        {

        }

        private void numMinimumPasswordLength_Validating(object sender, CancelEventArgs e)
        {
            NumericUpDown NUdown = (NumericUpDown)sender;
        
                if (NUdown.Text == "")
                {
                    if (Convert.ToInt32(NUdown.Tag) == 1)
                    {
                        numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength + 1;
                        numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength;
                    }
                    else
                        if (Convert.ToInt32(NUdown.Tag) == 2)
                    {
                        numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN + 1;
                        numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN;
                    }
                    else
                            if (Convert.ToInt32(NUdown.Tag) == 3)
                    {
                        numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts + 1;
                        numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts;
                    }
                    else
                                if (Convert.ToInt32(NUdown.Tag) == 4)
                    {
                        numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays + 1;
                        numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays;
                    }
                    else
                                    if (Convert.ToInt32(NUdown.Tag) == 5)
                   {
                       numMinWaitTimeBeforeLogout.Value = GetSecuritySettings.LogoutInactivity + 1;
                       numMinWaitTimeBeforeLogout.Value = GetSecuritySettings.LogoutInactivity;
                   }


                }
          
            //if (numMinimumPasswordLength.Value == GetSecuritySettings.MinPasswordLength)//if its blank then 
            //{
            //    numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength + 1;
            //    numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength;
            //}
            //bool run = LoadSecuritySettings();
        }

        private void numMinimumPasswordLength_Leave(object sender, EventArgs e)
        {
            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                return;
        }
    } 
} 

