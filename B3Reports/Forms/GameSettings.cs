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
    public partial class GameSettings : SettingsControl
    {
        bool result_;

        public GameSettings()
        {
            InitializeComponent();
            LoadSettings();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            errorProvider1.Clear();
            bool bResult = LoadSecuritySettings();
            this.ResumeLayout(true);
            return bResult;
        }

        public override bool SaveSettings()
        {
            Cursor x = Cursors.WaitCursor; 
            SaveSecuritySettings();    
            x = Cursors.Default; 
            return result_;
        }

        private bool LoadSecuritySettings()
        {
            GetGameSettings ggs = new GetGameSettings();
            
            if (numMinimumPlayer.Value == GetGameSettings.MinNumberOfPlayers)
            {
                numMinimumPlayer.Value = 1;
                numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
            }
            else
            {
                numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
            }
            numericTextBoxWDecimal1.Text = ConvertIntToMoneyFormat.convertToDecimal(GetGameSettings.ConsolationPrize);
            if (numCountdownTimer.Value == GetGameSettings.CountDownTimer)
            {
                numCountdownTimer.Value = 0;
                numCountdownTimer.Value = Convert.ToInt32(GetGameSettings.CountDownTimer);
            }
            else
            {
                numCountdownTimer.Value = Convert.ToInt32(GetGameSettings.CountDownTimer);
            }
            txtbxGameRecallPassword.Text = GetGameSettings.GameRecalPasswords;
            if (numWaitCountdownTimerOP.Value == GetGameSettings.WaitCountDownForOtherPLayers)
            {
                numWaitCountdownTimerOP.Value = 0;
                numWaitCountdownTimerOP.Value = Convert.ToInt32(GetGameSettings.WaitCountDownForOtherPLayers);
            }
            else
            {
                numWaitCountdownTimerOP.Value = Convert.ToInt32(GetGameSettings.WaitCountDownForOtherPLayers);
            }      
            return true;
        }


        public bool ValidateInput()
        {
            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
            {
                result_ = false;
               
            }
            else { result_ = true; }
            return result_;
        }

        private void SaveSecuritySettings()
        {
            decimal y = Convert.ToDecimal(numericTextBoxWDecimal1.Text) * 100;
            if (y == 1) { }
            int x = Convert.ToInt32(y);

            //Logged the changes
            if (GetGameSettings.MinNumberOfPlayers != (int)numMinimumPlayer.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Number of Players", GetGameSettings.MinNumberOfPlayers.ToString(), numMinimumPlayer.Value.ToString());
            }
            if (GetGameSettings.ConsolationPrize != x)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Extra Bonus Prize", GetGameSettings.ConsolationPrize.ToString(), x.ToString());
            }
            if (GetGameSettings.CountDownTimer != (int)numCountdownTimer.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Countdown Timer", GetGameSettings.CountDownTimer.ToString(), numCountdownTimer.Value.ToString());
            }
            if (GetGameSettings.GameRecalPasswords != txtbxGameRecallPassword.Text.ToString())
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Game Recall Paswword", GetGameSettings.GameRecalPasswords.ToString(), txtbxGameRecallPassword.Text);
            }
            if (GetGameSettings.WaitCountDownForOtherPLayers != (int)numWaitCountdownTimerOP.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum number of Players Wait Time", GetGameSettings.WaitCountDownForOtherPLayers.ToString(), numWaitCountdownTimerOP.Value.ToString());
            }

            GetGameSettings.MinNumberOfPlayers = (int)numMinimumPlayer.Value;
            GetGameSettings.ConsolationPrize = x; 
            GetGameSettings.CountDownTimer = (int)numCountdownTimer.Value;
            GetGameSettings.GameRecalPasswords = txtbxGameRecallPassword.Text.ToString();
            GetGameSettings.WaitCountDownForOtherPLayers = (int)numWaitCountdownTimerOP.Value;
            SetGameSettings set = new SetGameSettings();

            //return true;
        }

        private void numericTextBoxWDecimal1_Validating(object sender, CancelEventArgs e)
        {
            if (numericTextBoxWDecimal1.Text == string.Empty)
            {
               // errorProvider1.SetError(numericTextBoxWDecimal1, "Consolation prize is empty");
                errorProvider1.SetError(numericTextBoxWDecimal1, "Invalid entry");
                e.Cancel = true;

            }
        }

        private void numMinimumPlayer_Click(object sender, EventArgs e)
        {
            errorProvider1.Clear();
        }

        private void numCountdownTimer_Validating(object sender, CancelEventArgs e)
        {
            //if (string.IsNullOrEmpty(((Control)this.numCountdownTimer).Text))
            //{
            //    errorProvider1.SetError(numCountdownTimer, "Countdown Timer is empty");             
            //    e.Cancel = true;                
            //}
        }

        private void numMinimumPlayer_Validating(object sender, CancelEventArgs e)
        {
            //if (string.IsNullOrEmpty(((Control)this.numMinimumPlayer).Text))
            //{
            //    numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers) + 1;
            //    numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
            //   // errorProvider1.SetError(numMinimumPlayer, "Minimum player is empty");
            //   // e.Cancel = true;
            //}
            //else 
            //    if (numMinimumPlayer.Value < 2)
            //{
            //    errorProvider1.SetError(numMinimumPlayer, "Minimum player should be higher or equal than 2.");
            //    numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
            //    e.Cancel = true;
            //}
            //    else
            //        if (numMinimumPlayer.Value > 255)
            //        {
            //            errorProvider1.SetError(numMinimumPlayer, "Maximum player should not be higher than 255.");
            //            //numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
            //            e.Cancel = true;
            //        }
        }

        private void numWaitCountdownTimerOP_Validating(object sender, CancelEventArgs e)
        {
            //if (string.IsNullOrEmpty(((Control)this.numWaitCountdownTimerOP).Text))
            //{
            //    errorProvider1.SetError(numWaitCountdownTimerOP, "Minimum number of players wait time is empty");
            //    e.Cancel = true;
            //}
        }

        private void numMinimumPlayer_Leave(object sender, EventArgs e)
        {
            NumericUpDown NUDown = (NumericUpDown)sender;

            if (string.IsNullOrEmpty(((Control)NUDown).Text))
            {
                if (Convert.ToInt32(NUDown.Tag) == 1)
                {
                    numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers) + 1;
                    numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
                }
                else
                    if (Convert.ToInt32(NUDown.Tag) == 2)
                    {
                        numWaitCountdownTimerOP.Value = Convert.ToInt32(GetGameSettings.WaitCountDownForOtherPLayers) + 1;
                        numWaitCountdownTimerOP.Value = Convert.ToInt32(GetGameSettings.WaitCountDownForOtherPLayers);
                    }
                    else
                        if (Convert.ToInt32(NUDown.Tag) == 3)
                        {
                            numCountdownTimer.Value = Convert.ToInt32(GetGameSettings.CountDownTimer) + 1;
                            numCountdownTimer.Value = Convert.ToInt32(GetGameSettings.CountDownTimer);
                        }
            }
        }

        private void txtbxGameRecallPassword_Validating(object sender, CancelEventArgs e)
        {
            if (txtbxGameRecallPassword.Text == string.Empty)
            {
                // errorProvider1.SetError(numericTextBoxWDecimal1, "Consolation prize is empty");
                errorProvider1.SetError(txtbxGameRecallPassword, "Invalid entry");
                e.Cancel = true;

            }
        }
    }
}
