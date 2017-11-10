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
    public partial class GameSettingMayaMoney : SettingsControl
    {
        public GameSettingMayaMoney()
        {
            InitializeComponent();
            LoadSettings();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadMayaMoneySettings();
            this.ResumeLayout();
            return bResult;
        }

        private bool LoadMayaMoneySettings()
        {
            GetGameSettingsMayaMoney ggsmm = new GetGameSettingsMayaMoney();

            numMaxCards.Value = GetGameSettingsMayaMoney.maxcards;
            numMaxBetLevel.Value = GetGameSettingsMayaMoney.maxbetlevel;
            numMaxPattern.Value = GetGameSettingsMayaMoney.maxpatterns;
            numMaxCalls.Value = GetGameSettingsMayaMoney.maxcalls;
            numCallSpeedMin.Value = GetGameSettingsMayaMoney.callspeed_min;
            numCallSpeedMax.Value = GetGameSettingsMayaMoney.callspeed_max;

            if (GetGameSettingsMayaMoney.autocall == "T")
            { chkbxAutoCall.Checked = true; }
            else
            { chkbxAutoCall.Checked = false; }

            if (GetGameSettingsMayaMoney.autoplay == "T")
            { chkbxAutoPlay.Checked = true; }
            else
            { chkbxAutoPlay.Checked = false; }

            if (GetGameSettingsMayaMoney.hidecardserialnum == "T")
            { chkbxHideCardSerialNumber.Checked = true; }
            else
            { chkbxHideCardSerialNumber.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_1 == "T")
            { chkbxDenom1.Checked = true; }
            else
            { chkbxDenom1.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_5 == "T")
            { chkbxDenom5.Checked = true; }
            else
            { chkbxDenom5.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_10 == "T")
            { chkbxDenom10.Checked = true; }
            else
            { chkbxDenom10.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_25 == "T")
            { chkbxDenom25.Checked = true; }
            else
            { chkbxDenom25.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_50 == "T")
            { chkbxDenom50.Checked = true; }
            else
            { chkbxDenom50.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_100 == "T")
            { chkbxDenom1d.Checked = true; }
            else
            { chkbxDenom1d.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_200 == "T")
            { chkbxDenom2d.Checked = true; }
            else
            { chkbxDenom2d.Checked = false; }

            if (GetGameSettingsMayaMoney.denom_500 == "T")
            { chkbxDenom5d.Checked = true; }
            else
            { chkbxDenom5d.Checked = false; }
            return true;
        }

        public override bool SaveSettings()
        {
            Cursor curs = Cursors.WaitCursor;
            bool bResult = SaveMayaMoneyGameSettings();
            curs = Cursors.Default;
            return bResult;
            //return base.SaveSettings();
        }

        private bool SaveMayaMoneyGameSettings()
        {
           //etGameSettingsCrazyBout x = new GetGameSettingsMayaMoney();//Let us use the set instead of the static variable. Does it execute the class again?
            GetGameSettingsMayaMoney x = new GetGameSettingsMayaMoney();

            if (x.MaxCards != (int)numMaxCards.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Cards", x.MaxCards.ToString(), numMaxCards.Value.ToString());
                x.MaxCards = (int)numMaxCards.Value;


            }

            if (x.MaxBetLevel != (int)numMaxBetLevel.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Bet Level", x.MaxBetLevel.ToString(), numMaxBetLevel.Value.ToString());
                x.MaxBetLevel = (int)numMaxBetLevel.Value;

            }

            if (x.MaxPatterns != (int)numMaxPattern.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Patterns", x.MaxPatterns.ToString(), numMaxPattern.Value.ToString());
                x.MaxPatterns = (int)numMaxPattern.Value;

            }

            if (x.MaxCalls != (int)numMaxCalls.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Calls", x.MaxCalls.ToString(), numMaxCalls.Value.ToString());
                x.MaxCalls = (int)numMaxCalls.Value;

            }

            //if (x.MaxPattern_Bonus != (int)numMaxPatternBonus.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Pattern Bonus", x.MaxPattern_Bonus.ToString(), numMaxPatternBonus.Value.ToString());
            //    x.MaxPattern_Bonus = (int)numMaxPatternBonus.Value;

            //}

            //if (x.MaxCalls_Bonus != (int)numMaxCallsBonus.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Max Call Bonus", x.MaxCalls_Bonus.ToString(), numMaxCallsBonus.Value.ToString());
            //    x.MaxCalls_Bonus = (int)numMaxCallsBonus.Value;

            //}

            if (x.CallSpeed_Min != (int)numCallSpeedMin.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Call Speed min.", x.CallSpeed_Min.ToString(), numCallSpeedMin.Value.ToString());
                x.CallSpeed_Min = (int)numCallSpeedMin.Value;

            }

            if (x.CallSpeed_Max != (int)numCallSpeedMax.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Call Speed max.", x.CallSpeed_Max.ToString(), numCallSpeedMax.Value.ToString());
                x.CallSpeed_Max = (int)numCallSpeedMax.Value;

            }

            string UIValue;
            UIValue = (chkbxAutoCall.Checked == true) ? "T" : "F";
            if (x.AutoCall != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Auto Call", x.AutoCall.ToString(), UIValue);
                x.AutoCall = UIValue;//(chkbxAutoCall.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxAutoPlay.Checked == true) ? "T" : "F";
            if (x.AutoPlay != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Auto Play", x.AutoPlay.ToString(), UIValue);
                x.AutoPlay = UIValue;

            }

            UIValue = (chkbxDenom1.Checked == true) ? "T" : "F";
            if (x.Denom_1 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 1 cent", x.Denom_1.ToString(), UIValue);
                x.Denom_1 = (chkbxDenom1.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom5.Checked == true) ? "T" : "F";
            if (x.Denom_5 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 5 cent", x.Denom_5.ToString(), UIValue);
                x.Denom_5 = (chkbxDenom5.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom10.Checked == true) ? "T" : "F";
            if (x.Denom_10 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 10 cent", x.Denom_10.ToString(), UIValue);
                x.Denom_10 = (chkbxDenom10.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom25.Checked == true) ? "T" : "F";
            if (x.Denom_25 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 25 cent", x.Denom_25.ToString(), UIValue);
                x.Denom_25 = (chkbxDenom25.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom50.Checked == true) ? "T" : "F";
            if (x.Denom_50 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 50 cent", x.Denom_50.ToString(), UIValue);
                x.Denom_50 = (chkbxDenom50.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom1d.Checked == true) ? "T" : "F";
            if (x.Denom_100 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 1 dollar", x.Denom_100.ToString(), UIValue);
                x.Denom_100 = (chkbxDenom1d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom2d.Checked == true) ? "T" : "F";
            if (x.Denom_200 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 2 dollars", x.Denom_200.ToString(), UIValue);
                x.Denom_200 = (chkbxDenom2d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom5d.Checked == true) ? "T" : "F";
            if (x.Denom_500 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Denom 5 dollars", x.Denom_500.ToString(), UIValue);
                x.Denom_500 = (chkbxDenom5d.Checked == true) ? "T" : "F";

            }

            //UIValue = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";
            //if (x.SingleOfferBonus != UIValue)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Single Offer Bonus", x.SingleOfferBonus.ToString(), UIValue);
            //    x.SingleOfferBonus = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";

            //}

            UIValue = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";
            if (x.HideCardSerialNum != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Maya Money Setting - Hide card serial number", x.HideCardSerialNum.ToString(), UIValue);
                x.HideCardSerialNum = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";

            }

            //x.MaxCards = (int)numMaxCards.Value;
            //x.MaxBetLevel = (int)numMaxBetLevel.Value;
            //x.MaxPatterns = (int)numMaxPattern.Value;
            //x.MaxCalls = (int)numMaxCalls.Value;
            //x.CallSpeed_Min = (int)numCallSpeedMin.Value;
            //x.CallSpeed_Max = (int)numCallSpeedMax.Value;
            //x.AutoCall = (chkbxAutoCall.Checked == true) ? "T" : "F";
            //x.AutoPlay = (chkbxAutoPlay.Checked == true) ? "T" : "F";
            //x.Denom_1 = (chkbxDenom1.Checked == true) ? "T" : "F";
            //x.Denom_5 = (chkbxDenom5.Checked == true) ? "T" : "F";
            //x.Denom_10 = (chkbxDenom10.Checked == true) ? "T" : "F";
            //x.Denom_25 = (chkbxDenom25.Checked == true) ? "T" : "F";
            //x.Denom_50 = (chkbxDenom50.Checked == true) ? "T" : "F";
            //x.Denom_100 = (chkbxDenom1d.Checked == true) ? "T" : "F";
            //x.Denom_200 = (chkbxDenom2d.Checked == true) ? "T" : "F";
            //x.Denom_500 = (chkbxDenom5d.Checked == true) ? "T" : "F";
            //x.HideCardSerialNum = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";
            SetGameSettingsMayaMoney set = new SetGameSettingsMayaMoney();
            //SetGameSettingsCrazyBout set = new SetGameSettingsCrazyBout();

            return true;
        }

        private void numMaxCards_Leave(object sender, EventArgs e)
        {
            NumericUpDown NUDown = (NumericUpDown)sender;
            if (NUDown.Text == "")
            {
                if (Convert.ToInt32(NUDown.Tag) == 1)
                {
                    if (GetGameSettingsMayaMoney.maxcards == this.numMaxCards.Maximum)
                    {
                        numMaxCards.Value = GetGameSettingsMayaMoney.maxcards - 1;
                    }
                    else
                    { numMaxCards.Value = GetGameSettingsMayaMoney.maxcards + 1; }
                    numMaxCards.Value = GetGameSettingsMayaMoney.maxcards;

                }
                else
                    if (Convert.ToInt32(NUDown.Tag) == 2)
                    {
                        if (GetGameSettingsMayaMoney.maxbetlevel == this.numMaxBetLevel.Maximum)
                        {
                            numMaxBetLevel.Value = GetGameSettingsMayaMoney.maxbetlevel - 1;
                        }
                        else { numMaxBetLevel.Value = GetGameSettingsMayaMoney.maxbetlevel + 1; }
                        numMaxBetLevel.Value = GetGameSettingsMayaMoney.maxbetlevel;
                    }
                    else
                        if (Convert.ToInt32(NUDown.Tag) == 3)
                        {
                            if (GetGameSettingsMayaMoney.maxpatterns == this.numMaxPattern.Maximum)
                            {
                                numMaxPattern.Value = GetGameSettingsMayaMoney.maxpatterns - 1;
                            }
                            else { numMaxPattern.Value = GetGameSettingsMayaMoney.maxpatterns + 1; }
                            numMaxPattern.Value = GetGameSettingsMayaMoney.maxpatterns;
                        }
                        else
                            if (Convert.ToInt32(NUDown.Tag) == 4)
                            {
                                if (GetGameSettingsMayaMoney.maxcalls == this.numMaxCalls.Maximum)
                                {
                                    numMaxCalls.Value = GetGameSettingsMayaMoney.maxcalls - 1;
                                }
                                else { numMaxCalls.Value = GetGameSettingsMayaMoney.maxcalls + 1; }
                                numMaxCalls.Value = GetGameSettingsMayaMoney.maxcalls;
                            }
                            //else
                            //    if (Convert.ToInt32(NUDown.Tag) == 5)
                            //    {
                            //        if (GetGameSettingsMayaMoney.maxpatterns_bonus == this.numMaxPatternBonus.Maximum)
                            //        {
                            //            numMaxPatternBonus.Value = GetGameSettingsMayaMoney.maxpatterns_bonus - 1;
                            //        }
                            //        else { numMaxPatternBonus.Value = GetGameSettingsMayaMoney.maxpatterns_bonus + 1; }
                            //        numMaxPatternBonus.Value = GetGameSettingsMayaMoney.maxpatterns_bonus;
                            //    }
                            //    else if (Convert.ToInt32(NUDown.Tag) == 6)
                            //    {
                            //        if (GetGameSettingsMayaMoney.maxcalls_bonus == this.numMaxCallsBonus.Maximum)
                            //        {
                            //            numMaxCallsBonus.Value = GetGameSettingsMayaMoney.maxcalls_bonus - 1;
                            //        }
                            //        else
                            //        {
                            //            numMaxCallsBonus.Value = GetGameSettingsMayaMoney.maxcalls_bonus + 1;
                            //        }
                            //        numMaxCallsBonus.Value = GetGameSettingsMayaMoney.maxcalls_bonus;

                            //    }
                                else if (Convert.ToInt32(NUDown.Tag) == 5)
                                {
                                    if (GetGameSettingsMayaMoney.callspeed_min == this.numCallSpeedMin.Maximum)
                                    {
                                        numCallSpeedMin.Value = GetGameSettingsMayaMoney.callspeed_min - 1;
                                    }
                                    else { numCallSpeedMin.Value = GetGameSettingsMayaMoney.callspeed_min + 1; }
                                    numCallSpeedMin.Value = GetGameSettingsMayaMoney.callspeed_min;
                                }
                                else if (Convert.ToInt32(NUDown.Tag) == 6)
                                {
                                    if (GetGameSettingsMayaMoney.callspeed_max == this.numCallSpeedMax.Maximum)
                                    {
                                        numCallSpeedMax.Value = GetGameSettingsMayaMoney.callspeed_max - 1;
                                    }
                                    else
                                    {
                                        numCallSpeedMax.Value = GetGameSettingsMayaMoney.callspeed_max + 1;
                                    }
                                    numCallSpeedMax.Value = GetGameSettingsMayaMoney.callspeed_max;

                                }

            }
        }
    }
}
