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
            LoadSettings();
        }

        public override sealed bool LoadSettings()
        {
            SuspendLayout();
            bool bResult = LoadWildBallSettings();
            ResumeLayout();
            return bResult;
        }

        private bool LoadWildBallSettings()
        {
            GetGameSettingsWildBall.GetSettings(m_gameSettings);

            numMaxCards.Value = m_gameSettings.MaxCards;
            numMaxBetLevel.Value = m_gameSettings.MaxBetLevel;
            numMaxPattern.Value = m_gameSettings.MaxPatterns;
            numMaxCalls.Value = m_gameSettings.MaxCalls;
            numMaxPatternBonus.Value = m_gameSettings.MaxPatternsBonus;
            numMaxCallsBonus.Value = m_gameSettings.MaxCallsBonus;
            numCallSpeed.Value = m_gameSettings.CallSpeed;

            const string t = "T";

            chkbxAutoCall.Checked = m_gameSettings.AutoCall == t;
            chkbxAutoPlay.Checked = m_gameSettings.AutoPlay == t;
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
            return bResult;
        }

        private bool SaveWildBallSettings()
        {
            if (m_gameSettings.MaxCards != (int)numMaxCards.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Cards", m_gameSettings.MaxCards.ToString(), numMaxCards.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxCards = (int)numMaxCards.Value;
            }

            if (m_gameSettings.MaxBetLevel != (int)numMaxBetLevel.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Bet Level", m_gameSettings.MaxBetLevel.ToString(), numMaxBetLevel.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxBetLevel = (int)numMaxBetLevel.Value;
            }

            if (m_gameSettings.MaxPatterns != (int)numMaxPattern.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Patterns", m_gameSettings.MaxPatterns.ToString(), numMaxPattern.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxPatterns = (int)numMaxPattern.Value;
            }

            if (m_gameSettings.MaxCalls != (int)numMaxCalls.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Calls", m_gameSettings.MaxCalls.ToString(), numMaxCalls.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxCalls = (int)numMaxCalls.Value;
            }

            if (m_gameSettings.MaxPatternsBonus != (int)numMaxPatternBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Pattern Bonus", m_gameSettings.MaxPatternsBonus.ToString(), numMaxPatternBonus.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxPatternsBonus = (int)numMaxPatternBonus.Value;
            }

            if (m_gameSettings.MaxCallsBonus != (int)numMaxCallsBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Max Call Bonus", m_gameSettings.MaxCallsBonus.ToString(), numMaxCallsBonus.Value.ToString(CultureInfo.InvariantCulture));
                m_gameSettings.MaxCallsBonus = (int)numMaxCallsBonus.Value;
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

            isTrue = chkbxAutoPlay.Checked ? "T" : "F";
            if (m_gameSettings.AutoPlay != isTrue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "WildBall Setting - Auto Play", m_gameSettings.AutoPlay, isTrue);
                m_gameSettings.AutoPlay = isTrue;
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
    }
}
