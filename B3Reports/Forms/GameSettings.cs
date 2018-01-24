using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Windows.Forms;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports.Forms
{
    public partial class GameSettings : SettingsControl
    {
        bool result_;
        private List<string> m_activeGameList; 
        private bool m_gamesEnabledModified;
        private readonly Dictionary<string, CheckBox> m_gameCheckboxDictionary;
        public GameSettings()
        {
            m_gameCheckboxDictionary = new Dictionary<string, CheckBox>();
            InitializeComponent();
            m_activeGameList = GetActiveGames.B3ActiveGamesList;
            SetAvailableGames();
            LoadSettings();

        }

        public bool IsSinglePlayerMode { get; set; }
        
        public override bool LoadSettings()
        {
            DoubleBuffered = true;
            SetStyle(ControlStyles.OptimizedDoubleBuffer, true);
            this.SuspendLayout();
            errorProvider1.Clear();
            bool bResult = LoadGameSettings();
            this.ResumeLayout(true);
            IsModified = false;
            m_gamesEnabledModified = false;
            return bResult;
        }

        public override bool SaveSettings()
        {
            Cursor x = Cursors.WaitCursor; 
            SaveGameSettings();
            x = Cursors.Default;
            IsModified = false;
            m_gamesEnabledModified = false;
            return result_;
        }

        private void SetAvailableGames()
        {
            var b3Games = GetAvailableGames.GamesList;
            m_gameCheckboxDictionary.Clear();
            GamesFlowPanel.Controls.Clear();
            foreach (var b3GamesInfo in b3Games)
            {
                var checkBox = new CheckBox
                {
                    Width = 150,
                    Margin = new Padding(7),
                    Text = b3GamesInfo.DisplayName,
                    Tag = b3GamesInfo
                };

                checkBox.CheckedChanged += GameCheckBox_CheckedChanged;

                GamesFlowPanel.Controls.Add(checkBox);
                m_gameCheckboxDictionary.Add(b3GamesInfo.GameIconName.ToString(), checkBox);
            }
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

            if (GetGameSettings.ConsolationPrize == 0)
            {
                numericUpDownExtraBonus.Value = 0.01m;
            }
            else
            {
                numericUpDownExtraBonus.Value = Convert.ToDecimal(ConvertIntToMoneyFormat.convertToDecimal(GetGameSettings.ConsolationPrize));                
            }
           
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

            m_activeGameList = GetActiveGames.B3ActiveGamesList;

            foreach (var gameCheckBox in m_gameCheckboxDictionary.Values)
            {
                var gameInfo = gameCheckBox.Tag as B3GamesInfo;

                switch (gameInfo.GameIconName)
                {
                    case GameIconNameEnum.CRAZYBOUT:
                    case GameIconNameEnum.JAILBREAK:
                    case GameIconNameEnum.MAYAMONEY:
                        gameCheckBox.Checked = m_activeGameList.Contains(gameInfo.GameIconName.ToString());
                        break;

                    case GameIconNameEnum.WILDBALL:
                    case GameIconNameEnum.SPIRIT76:
                    case GameIconNameEnum.TIMEBOMB:
                        gameCheckBox.Checked = IsSinglePlayerMode && m_activeGameList.Contains(gameInfo.GameIconName.ToString());
                        break;
                }
            }

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

        private void SaveGameSettings()
        {
            decimal y = Convert.ToDecimal(numericUpDownExtraBonus.Value) * 100;

            if (y == 1)
            {
                if (IsSinglePlayerMode && GetGameSettings.ConsolationPrize == 0)
                {
                    y = 0;
                }
            }
            int x = Convert.ToInt32(y);

            //Logged the changes
            if (IsSinglePlayerMode && GetGameSettings.MinNumberOfPlayers != 1)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Number of Players", GetGameSettings.MinNumberOfPlayers.ToString(), 1.ToString());
                GetGameSettings.MinNumberOfPlayers = 1;
            }
            else if(!IsSinglePlayerMode && GetGameSettings.MinNumberOfPlayers != (int)numMinimumPlayer.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Number of Players", GetGameSettings.MinNumberOfPlayers.ToString(), numMinimumPlayer.Value.ToString());
                GetGameSettings.MinNumberOfPlayers = (int)numMinimumPlayer.Value;
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

            GetGameSettings.ConsolationPrize = x; 
            GetGameSettings.CountDownTimer = (int)numCountdownTimer.Value;
            GetGameSettings.GameRecalPasswords = txtbxGameRecallPassword.Text;
            GetGameSettings.WaitCountDownForOtherPLayers = (int)numWaitCountdownTimerOP.Value;
            SetGameSettings set = new SetGameSettings();

            if (m_gamesEnabledModified)
            {
                SetActiveGames.Set(GetEnabledGames());
            }
            //return true;
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

        private void RadioButtonPlayMode_CheckChanged(object sender, EventArgs e)
        {
            IsModified = true;

            if (singlePlayerPlayModeRadioButton.Checked)
            {
                IsSinglePlayerMode = true;
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
                numericUpDownExtraBonus.Enabled = false;

                //WildBallCheckBox.Enabled = true;
                //Spirit76CheckBox.Enabled = true;
                //TimeBombCheckBox.Enabled = true;

                //WildBallCheckBox.Checked = GetGameSettings.IsWildBallEnabled;
                //Spirit76CheckBox.Checked = GetGameSettings.IsSpirit76Enabled;
                //TimeBombCheckBox.Checked = GetGameSettings.IsTimeBombEnabled;
            }
            else
            {
                IsSinglePlayerMode = false;

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
                numericUpDownExtraBonus.Enabled = true;

                //WildBallCheckBox.Enabled = false;
                //Spirit76CheckBox.Enabled = false;
                //TimeBombCheckBox.Enabled = false;

                //WildBallCheckBox.Checked = false;
                //Spirit76CheckBox.Checked = false;
                //TimeBombCheckBox.Checked = false;
            }

            foreach (var gameCheckBox in m_gameCheckboxDictionary.Values)
            {
                var gameInfo = gameCheckBox.Tag as B3GamesInfo;

                switch (gameInfo.GameIconName)
                {
                    case GameIconNameEnum.CRAZYBOUT:
                    case GameIconNameEnum.JAILBREAK:
                    case GameIconNameEnum.MAYAMONEY:
                        gameCheckBox.Checked = m_activeGameList.Contains(gameInfo.GameIconName.ToString());
                        break;

                    case GameIconNameEnum.SPIRIT76:
                    case GameIconNameEnum.WILDBALL:
                    case GameIconNameEnum.TIMEBOMB:
                        gameCheckBox.Checked = IsSinglePlayerMode && m_activeGameList.Contains(gameInfo.GameIconName.ToString());
                        gameCheckBox.Enabled = IsSinglePlayerMode;
                        break;

                }
            }
        }
        
        private void GameCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            IsModified = true;
            m_gamesEnabledModified = true;
            var handler = EnableGameCheckedEvent;
            if (handler != null)
            {
                handler(sender, EventArgs.Empty);
            }
        }

        private List<string> GetEnabledGames()
        {
            var activeGameList = new List<string>();

            foreach (var gameCheckBox in m_gameCheckboxDictionary.Values)
            {
                var gameInfo = gameCheckBox.Tag as B3GamesInfo;

                if (gameInfo == null)
                {
                    continue;
                }

                if (gameCheckBox.Checked)
                {
                    activeGameList.Add(gameInfo.GameIconName.ToString());
                }
            }

            return activeGameList;
        }

        private bool IsGameChecked(GameIconNameEnum gameIconName)
        {
            foreach (var gameCheckBox in m_gameCheckboxDictionary.Values)
            {
                var gameInfo = gameCheckBox.Tag as B3GamesInfo;

                if (gameInfo == null)
                {
                    continue;
                }

                if (gameInfo.GameIconName == gameIconName)
                {
                    return gameCheckBox.Checked;
                }
            }

            return false;
        }

        public bool IsCrazyBoutEnabled { get { return IsGameChecked(GameIconNameEnum.CRAZYBOUT); } }
        public bool IsJailBreakEnabled { get { return IsGameChecked(GameIconNameEnum.JAILBREAK); } }
        public bool IsMayaMoneyEnabled { get { return IsGameChecked(GameIconNameEnum.MAYAMONEY); } }
        public bool IsWildBallEnabled { get { return IsGameChecked(GameIconNameEnum.WILDBALL); } }
        public bool IsSpirit76Enabled { get { return IsGameChecked(GameIconNameEnum.SPIRIT76); } }
        public bool IsTimeBombEnabled { get { return IsGameChecked(GameIconNameEnum.TIMEBOMB); } }

        private void ModifiedSettings(object sender, EventArgs e)
        {
            IsModified = true;
        }


    }
}
