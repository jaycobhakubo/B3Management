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
    public partial class PlayerSettings : SettingsControl
    {
      //  bool m_bModified = false;

        public PlayerSettings()
        {
            InitializeComponent();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadSecuritySettings();
            this.ResumeLayout(true);
            return bResult;
        }

        //public override bool SaveSettings()
        //{
        //    Cursor x = Cursors.WaitCursor;  //  Common.BeginWait();        
        //    bool bResult = SaveSecuritySettings();
        //    x = Cursors.Default; // Common.EndWait();
        //    return bResult;
        //}

        private bool LoadSecuritySettings()
        {

            numUpDwnTimeToCollect.Value = GetPlayerSettings.TimeToCollect;
            numUpDwnMainVolume.Value = GetPlayerSettings.MainVolume;
            if (GetPlayerSettings.ScreenCursor == "T")
            { chkbxScreenCursor.Checked = true; }else { chkbxScreenCursor.Checked = false; }

            if (GetPlayerSettings.CalibrateTouch == "T")            
            {chkbxCalibrateTouch.Checked = true; } else {chkbxCalibrateTouch.Checked = false;}
            
            if (GetPlayerSettings.Disclaimer == "T")
            { chkbxDisclaimer.Checked = true; } else { chkbxDisclaimer.Checked = false; }

            if (GetPlayerSettings.AnnounceCall == "T")
            {chkbxAnnounceCall.Checked = true ;}else {chkbxAnnounceCall.Checked = false;}

            if (GetPlayerSettings.PressToCollect == "T")
            {chkbxPressToCollect.Checked = true;} else {chkbxPressToCollect.Checked = false;}


            
            //clearError();
            //numMinimumPasswordLength.Value = GetSecuritySettings.MinPasswordLength;
            //numPreviousPasswordReuse.Value = GetSecuritySettings.PrevPasswordReuseN;
            //numPasswordLockOutAttempts.Value = GetSecuritySettings.PrevPasswordLockoutAttempts;
            //numPinExpireDays.Value = GetSecuritySettings.NPasswordsExpireDays;
            //numMaxLoginLimit.Value = GetSecuritySettings.MaximumMachineLoginLimit;
            //if (GetSecuritySettings.UsePasswordComplexity == true)
            //{
            //    chkUsePasswordComplexity.Checked = true;
            //}
            //else
            //{
            //    chkUsePasswordComplexity.Checked = false;
            //}

            //numMinWaitTimeBeforeLogout.Value = GetSecuritySettings.LogoutInactivity;
            return true;
        }



    }
}
