using System;
using System.ComponentModel;
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

        public bool IsSinglePlayerMode { get; set; }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            errorProvider1.Clear();
            bool bResult = LoadGameSettings();
            this.ResumeLayout(true);
            IsModified = false;
            return bResult;
        }

        public override bool SaveSettings()
        {
            Cursor x = Cursors.WaitCursor; 
            SaveSecuritySettings();
            x = Cursors.Default;
            IsModified = false;
            return result_;
        }

        private bool LoadGameSettings()
        {
            GetGameSettings ggs = new GetGameSettings();
            
            if (GetGameSettings.MinNumberOfPlayers > 1)
            {
                numMinimumPlayer.Value = Convert.ToInt32(GetGameSettings.MinNumberOfPlayers);
                multiplayerPlayModeRadioButton.Checked = true;
                IsSinglePlayerMode = false;
            }
            else
            {
                IsSinglePlayerMode = true;
                singlePlayerPlayModeRadioButton.Checked = true;
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

            if (numericUpDownGameThreads.Value == ggs.GameThreads)
            {
                numericUpDownGameThreads.Value = 5;
                numericUpDownGameThreads.Value = Convert.ToInt32(ggs.GameThreads);
            }
            else
            {
                numericUpDownGameThreads.Value = Convert.ToInt32(ggs.GameThreads);
            }


            CrazyBoutCheckBox.Checked = GetGameSettings.IsCrazyBoutEnabled;
            JailBreakCheckBox.Checked = GetGameSettings.IsJailBreakEnabled;
            MayaMoneyCheckBox.Checked = GetGameSettings.IsMayaMoneyEnabled;
            WildBallCheckBox.Checked = GetGameSettings.IsWildBallEnabled;
            Spirit76CheckBox.Checked = GetGameSettings.IsSpirit76Enabled;
            TimeBombCheckBox.Checked = GetGameSettings.IsTimeBombEnabled;

            IsModified = false;
            return true;
        }

        public event EventHandler EnableGameCheckedEvent;

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

        private void radioButtonPlayMode_CheckChanged(object sender, EventArgs e)
        {
            IsModified = true;

            if (singlePlayerPlayModeRadioButton.Checked)
            {
                lblMinNumberOfPlayers.Enabled = false;
                numMinimumPlayer.Enabled = false;

                lblCountdownTimer.Enabled = false;
                numCountdownTimer.Enabled = false;
                lblCountdownTimerSec.Enabled = false;

                numWaitCountdownTimerOP.Enabled = false;
                lblMinimumNumOfPlayersSec.Enabled = false;
                lblMinNumPlayersTime.Enabled = false;

                lblExtraBonus.Enabled = false;
                lblExtraBonusDollarSign.Enabled = false;
                numericTextBoxWDecimal1.Enabled = false;

                WildBallCheckBox.Enabled = true;
                Spirit76CheckBox.Enabled = true;
                TimeBombCheckBox.Enabled = true;

                WildBallCheckBox.Checked = GetGameSettings.IsWildBallEnabled;
                Spirit76CheckBox.Checked = GetGameSettings.IsSpirit76Enabled;
                TimeBombCheckBox.Checked = GetGameSettings.IsTimeBombEnabled;
            }
            else
            {
                lblMinNumberOfPlayers.Enabled = true;
                numMinimumPlayer.Enabled = true;

                lblCountdownTimer.Enabled = true;
                numCountdownTimer.Enabled = true;
                lblCountdownTimerSec.Enabled = true;

                numWaitCountdownTimerOP.Enabled = true;
                lblMinimumNumOfPlayersSec.Enabled = true;
                lblMinNumPlayersTime.Enabled = true;

                lblExtraBonus.Enabled = true;
                lblExtraBonusDollarSign.Enabled = true;
                numericTextBoxWDecimal1.Enabled = true;

                WildBallCheckBox.Enabled = false;
                Spirit76CheckBox.Enabled = false;
                TimeBombCheckBox.Enabled = false;

                WildBallCheckBox.Checked = false;
                Spirit76CheckBox.Checked = false;
                TimeBombCheckBox.Checked = false;
            }
        }
        
        private void GameCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            IsModified = true;
            var handler = EnableGameCheckedEvent;
            if (handler != null)
            {
                handler(null, EventArgs.Empty);
            }
        }

        public bool IsCrazyBoutEnabled { get { return CrazyBoutCheckBox.Checked; } }
        public bool IsJailBreakEnabled { get { return JailBreakCheckBox.Checked; } }
        public bool IsMayaMoneyEnabled { get { return MayaMoneyCheckBox.Checked; } }
        public bool IsWildBallEnabled { get { return WildBallCheckBox.Checked; } }
        public bool IsSpirit76Enabled { get { return Spirit76CheckBox.Checked; } }
        public bool IsTimeBombEnabled { get { return TimeBombCheckBox.Checked; } }

        private void ModifiedSettings(object sender, EventArgs e)
        {
            IsModified = true;
        }


    }
}
