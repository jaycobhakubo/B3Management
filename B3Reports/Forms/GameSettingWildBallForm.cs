using System;
using System.Globalization;
using System.Windows.Forms;
using GameTech.B3Reports._cs_Get;
using GameTech.B3Reports._cs_Set;

namespace GameTech.B3Reports.Forms
{
    public partial class GameSettingWildBallForm : SettingsControl
    {
        private readonly _cs_Other.GameSettings m_gameSettings;

        public GameSettingWildBallForm()
        {
            InitializeComponent();
            m_gameSettings = new _cs_Other.GameSettings();
        }

        public override sealed bool LoadSettings()
        {
            SuspendLayout();
            bool bResult = LoadWildBallSettings();
            ResumeLayout();
            IsModified = false;
            return bResult;
        }

        private bool LoadWildBallSettings()
        {
            GetGameSettingsWildBall.GetSettings(m_gameSettings);

            comboBoxMaxCard.SelectedItem = m_gameSettings.MaxCards.ToString();
            comboBoxMaxBetLevel.SelectedItem = m_gameSettings.MaxBetLevel.ToString();
            numCallSpeed.Value = m_gameSettings.CallSpeed;

            const string t = "T";

            chkbxAutoCall.Checked = m_gameSettings.AutoCall == t;
            chkbxHideCardSerialNumber.Checked = m_gameSettings.HideCardSerialNumber == t;
            chkbxSingleOfferBonus.Checked = m_gameSettings.SingleOfferBonus == t;
            chkbxDenom1.Checked = m_gameSettings.Denom1 == t;
            chkbxDenom5.Checked = m_gameSettings.Denom5 == t;
            chkbxDenom10.Checked = m_gameSettings.Denom10 == t;
            chkbxDenom25.Checked = m_gameSettings.Denom25 == t;
            chkbxDenom50.Checked = m_gameSettings.Denom50 == t;
            chkbxDenom1d.Checked = m_gameSettings.Denom100 == t;
            chkbxDenom2d.Checked = m_gameSettings.Denom200 == t;
            chkbxDenom5d.Checked = m_gameSettings.Denom500 == t;
            return true; 
        }

        public override bool SaveSettings()
        {
            bool bResult = SaveWildBallSettings();
            IsModified = false;
            return bResult;
        }

        private bool SaveWildBallSettings()
        {
            if (m_gameSettings.MaxCards != int.Parse(comboBoxMaxCard.SelectedItem.ToString()))
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Cards", m_gameSettings.MaxCards.ToString(), comboBoxMaxCard.SelectedItem.ToString());
                m_gameSettings.MaxCards = int.Parse(comboBoxMaxCard.SelectedItem.ToString());
            }

            if (m_gameSettings.MaxBetLevel != int.Parse(comboBoxMaxBetLevel.SelectedItem.ToString()))
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Bet Level", m_gameSettings.MaxBetLevel.ToString(), comboBoxMaxBetLevel.SelectedItem.ToString());
                m_gameSettings.MaxBetLevel = int.Parse(comboBoxMaxBetLevel.SelectedItem.ToString());
            }

            if (m_gameSettings.CallSpeed != (int)numCallSpeed.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Call Speed.", m_gameSettings.CallSpeed.ToString(), numCallSpeed.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.CallSpeed = (int)numCallSpeed.Value;
            }

            var isTrue = chkbxAutoCall.Checked ? "T" : "F";
            if (m_gameSettings.AutoCall != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Auto Call", m_gameSettings.AutoCall, isTrue);
                m_gameSettings.AutoCall = isTrue;
            }

            isTrue = chkbxDenom1.Checked ? "T" : "F";
            if (m_gameSettings.Denom1 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 1 cent", m_gameSettings.Denom1, isTrue);
                m_gameSettings.Denom1 = isTrue;
            }

            isTrue = chkbxDenom5.Checked ? "T" : "F";
            if (m_gameSettings.Denom5 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 5 cent", m_gameSettings.Denom5, isTrue);
                m_gameSettings.Denom5 = isTrue;
            }

            isTrue = chkbxDenom10.Checked ? "T" : "F";
            if (m_gameSettings.Denom10 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 10 cent", m_gameSettings.Denom10, isTrue);
                m_gameSettings.Denom10 = isTrue;
            }

            isTrue = chkbxDenom25.Checked ? "T" : "F";
            if (m_gameSettings.Denom25 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 25 cent", m_gameSettings.Denom25, isTrue);
                m_gameSettings.Denom25 = isTrue;
            }

            isTrue = chkbxDenom50.Checked ? "T" : "F";
            if (m_gameSettings.Denom50 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 50 cent", m_gameSettings.Denom50, isTrue);
                m_gameSettings.Denom50 = isTrue;
            }

            isTrue = chkbxDenom1d.Checked ? "T" : "F";
            if (m_gameSettings.Denom100 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 1 dollar", m_gameSettings.Denom100, isTrue);
                m_gameSettings.Denom100 = isTrue;
            }

            isTrue = chkbxDenom2d.Checked ? "T" : "F";
            if (m_gameSettings.Denom200 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 2 dollars", m_gameSettings.Denom200, isTrue);
                m_gameSettings.Denom200 = isTrue;
            }

            isTrue = chkbxDenom5d.Checked ? "T" : "F";
            if (m_gameSettings.Denom500 != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Denom 5 dollars", m_gameSettings.Denom500, isTrue);
                m_gameSettings.Denom500 = isTrue;
            }

            isTrue = chkbxSingleOfferBonus.Checked ? "T" : "F";
            if (m_gameSettings.SingleOfferBonus != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Single offer bonus", m_gameSettings.HideCardSerialNumber, isTrue);
                m_gameSettings.SingleOfferBonus = isTrue;
            }

            isTrue = chkbxHideCardSerialNumber.Checked ? "T" : "F";
            if (m_gameSettings.HideCardSerialNumber != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Hide card serial number", m_gameSettings.HideCardSerialNumber, isTrue);
                m_gameSettings.HideCardSerialNumber = isTrue;
            }

            SetGameSettingsWildBall.SetSettings(m_gameSettings);

            return true;
        }

        private void ModifiedSettings(object sender, EventArgs e)
        {
            IsModified = true;
        }
    }
}
