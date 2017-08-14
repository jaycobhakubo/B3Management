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
    public partial class GameSettingJailBreak : SettingsControl
    {
        public GameSettingJailBreak()
        {
            InitializeComponent();
            LoadSettings();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadJailBreakSettings();
            this.ResumeLayout();
            return bResult;
        }

        private bool LoadJailBreakSettings()
        {
            GetGameSettingJailbreak ggsjb = new GetGameSettingJailbreak();

            numMaxCards.Value = GetGameSettingJailbreak.maxcards;
            numMaxBetLevel.Value = GetGameSettingJailbreak.maxbetlevel;
            numMaxPattern.Value = GetGameSettingJailbreak.maxpatterns;
            numMaxCalls.Value = GetGameSettingJailbreak.maxcalls;
            numMaxPatternBonus.Value = GetGameSettingJailbreak.maxpatterns_bonus;
            numMaxCallsBonus.Value = GetGameSettingJailbreak.maxcalls_bonus;
            numCallSpeed.Value = GetGameSettingJailbreak.callspeed;

            if (GetGameSettingJailbreak.autocall == "T")
            { chkbxAutoCall.Checked = true; }
            else
            { chkbxAutoCall.Checked = false; }

            if (GetGameSettingJailbreak.autoplay == "T")
            { chkbxAutoPlay.Checked = true; }
            else
            { chkbxAutoPlay.Checked = false; }

            if (GetGameSettingJailbreak.hidecardserialnum == "T")
            { chkbxHideCardSerialNumber.Checked = true; }
            else
            { chkbxHideCardSerialNumber.Checked = false; }

            if (GetGameSettingJailbreak.denom_1 == "T")
            { chkbxDenom1.Checked = true; }
            else
            { chkbxDenom1.Checked = false; }

            if (GetGameSettingJailbreak.denom_5 == "T")
            { chkbxDenom5.Checked = true; }
            else
            { chkbxDenom5.Checked = false; }

            if (GetGameSettingJailbreak.denom_10 == "T")
            { chkbxDenom10.Checked = true; }
            else
            { chkbxDenom10.Checked = false; }

            if (GetGameSettingJailbreak.denom_25 == "T")
            { chkbxDenom25.Checked = true; }
            else
            { chkbxDenom25.Checked = false; }

            if (GetGameSettingJailbreak.denom_50 == "T")
            { chkbxDenom1d.Checked = true; }
            else
            { chkbxDenom1d.Checked = false; }

            if (GetGameSettingJailbreak.denom_100 == "T")
            { chkbxDenom1d.Checked = true; }
            else
            { chkbxDenom1d.Checked = false; }

            if (GetGameSettingJailbreak.denom_200 == "T")
            { chkbxDenom2d.Checked = true; }
            else
            { chkbxDenom2d.Checked = false; }

            if (GetGameSettingJailbreak.denom_500 == "T")
            { chkbxDenom5d.Checked = true; }
            else
            { chkbxDenom5d.Checked = false; }
            return true;

        }

        public override bool SaveSettings()
        {
            Cursor curs = Cursors.WaitCursor;
            bool bResult = SaveJailBreakGameSettings();
            curs = Cursors.Default;
            return bResult;
            //return base.SaveSettings();
        }


        private bool SaveJailBreakGameSettings()
        {
            GetGameSettingJailbreak x = new GetGameSettingJailbreak();//Let us use the set instead of the static variable. Does it execute the class again?

            if (x.MaxCards != (int)numMaxCards.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Cards", x.MaxCards.ToString(), numMaxCards.Value.ToString());
                x.MaxCards = (int)numMaxCards.Value;


            }

            if (x.MaxBetLevel != (int)numMaxBetLevel.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Bet Level", x.MaxBetLevel.ToString(), numMaxBetLevel.Value.ToString());
                x.MaxBetLevel = (int)numMaxBetLevel.Value;

            }

            if (x.MaxPatterns != (int)numMaxPattern.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Patterns", x.MaxPatterns.ToString(), numMaxPattern.Value.ToString());
                x.MaxPatterns = (int)numMaxPattern.Value;

            }

            if (x.MaxCalls != (int)numMaxCalls.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Calls", x.MaxCalls.ToString(), numMaxCalls.Value.ToString());
                x.MaxCalls = (int)numMaxCalls.Value;

            }

            if (x.MaxPattern_Bonus != (int)numMaxPatternBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Pattern Bonus", x.MaxPattern_Bonus.ToString(), numMaxPatternBonus.Value.ToString());
                x.MaxPattern_Bonus = (int)numMaxPatternBonus.Value;

            }

            if (x.MaxCalls_Bonus != (int)numMaxCallsBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Max Call Bonus", x.MaxCalls_Bonus.ToString(), numMaxCallsBonus.Value.ToString());
                x.MaxCalls_Bonus = (int)numMaxCallsBonus.Value;

            }

            if (x.CallSpeed != (int)numCallSpeed.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Call Speed.", x.CallSpeed.ToString(), numCallSpeed.Value.ToString());
                x.CallSpeed = (int)numCallSpeed.Value;

            }

            //if (x.CallSpeed_Max != (int)numCallSpeedMax.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Call Speed max.", x.CallSpeed_Max.ToString(), numCallSpeedMax.Value.ToString());
            //    x.CallSpeed_Max = (int)numCallSpeedMax.Value;

            //}

            string UIValue;
            UIValue = (chkbxAutoCall.Checked == true) ? "T" : "F";
            if (x.AutoCall != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Auto Call", x.AutoCall.ToString(), UIValue);
                x.AutoCall = UIValue;//(chkbxAutoCall.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxAutoPlay.Checked == true) ? "T" : "F";
            if (x.AutoPlay != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Auto Play", x.AutoPlay.ToString(), UIValue);
                x.AutoPlay = UIValue;

            }

            UIValue = (chkbxDenom1.Checked == true) ? "T" : "F";
            if (x.Denom_1 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 1 cent", x.Denom_1.ToString(), UIValue);
                x.Denom_1 = (chkbxDenom1.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom5.Checked == true) ? "T" : "F";
            if (x.Denom_5 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 5 cent", x.Denom_5.ToString(), UIValue);
                x.Denom_5 = (chkbxDenom5.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom10.Checked == true) ? "T" : "F";
            if (x.Denom_10 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 10 cent", x.Denom_10.ToString(), UIValue);
                x.Denom_10 = (chkbxDenom10.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom25.Checked == true) ? "T" : "F";
            if (x.Denom_25 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 25 cent", x.Denom_25.ToString(), UIValue);
                x.Denom_25 = (chkbxDenom25.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom50.Checked == true) ? "T" : "F";
            if (x.Denom_50 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 50 cent", x.Denom_50.ToString(), UIValue);
                x.Denom_50 = (chkbxDenom50.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom1d.Checked == true) ? "T" : "F";
            if (x.Denom_100 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 1 dollar", x.Denom_100.ToString(), UIValue);
                x.Denom_100 = (chkbxDenom1d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom2d.Checked == true) ? "T" : "F";
            if (x.Denom_200 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 2 dollars", x.Denom_200.ToString(), UIValue);
                x.Denom_200 = (chkbxDenom2d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom5d.Checked == true) ? "T" : "F";
            if (x.Denom_500 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Denom 5 dollars", x.Denom_500.ToString(), UIValue);
                x.Denom_500 = (chkbxDenom5d.Checked == true) ? "T" : "F";

            }

            //UIValue = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";
            //if (x.SingleOfferBonus != UIValue)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Single Offer Bonus", x.SingleOfferBonus.ToString(), UIValue);
            //    x.SingleOfferBonus = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";

            //}

            UIValue = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";
            if (x.HideCardSerialNum != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Jailbreak Setting - Hide card serial number", x.HideCardSerialNum.ToString(), UIValue);
                x.HideCardSerialNum = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";

            }

            //x.MaxCards = (int)numMaxCards.Value;
            //x.MaxBetLevel = (int)numMaxBetLevel.Value;
            //x.MaxPatterns = (int)numMaxPattern.Value;
            //x.MaxCalls = (int)numMaxCalls.Value;
            //x.MaxPattern_Bonus = (int)numMaxPatternBonus.Value;
            //x.MaxCalls_Bonus = (int)numMaxCallsBonus.Value;
            //x.CallSpeed = (int)numCallSpeed.Value;
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
            SetGameSettingsJailbreak set = new SetGameSettingsJailbreak();
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
                    if (GetGameSettingJailbreak.maxcards == this.numMaxCards.Maximum)
                    {
                        numMaxCards.Value = GetGameSettingJailbreak.maxcards - 1;
                    }
                    else
                    { numMaxCards.Value = GetGameSettingJailbreak.maxcards + 1; }
                    numMaxCards.Value = GetGameSettingJailbreak.maxcards;

                }
                else
                    if (Convert.ToInt32(NUDown.Tag) == 2)
                    {
                        if (GetGameSettingJailbreak.maxbetlevel == this.numMaxBetLevel.Maximum)
                        {
                            numMaxBetLevel.Value = GetGameSettingJailbreak.maxbetlevel - 1;
                        }
                        else { numMaxBetLevel.Value = GetGameSettingJailbreak.maxbetlevel + 1; }
                        numMaxBetLevel.Value = GetGameSettingJailbreak.maxbetlevel;
                    }
                    else
                        if (Convert.ToInt32(NUDown.Tag) == 3)
                        {
                            if (GetGameSettingJailbreak.maxpatterns == this.numMaxPattern.Maximum)
                            {
                                numMaxPattern.Value = GetGameSettingJailbreak.maxpatterns - 1;
                            }
                            else { numMaxPattern.Value = GetGameSettingJailbreak.maxpatterns + 1; }
                            numMaxPattern.Value = GetGameSettingJailbreak.maxpatterns;
                        }
                        else
                            if (Convert.ToInt32(NUDown.Tag) == 4)
                            {
                                if (GetGameSettingJailbreak.maxcalls == this.numMaxCalls.Maximum)
                                {
                                    numMaxCalls.Value = GetGameSettingJailbreak.maxcalls - 1;
                                }
                                else { numMaxCalls.Value = GetGameSettingJailbreak.maxcalls + 1; }
                                numMaxCalls.Value = GetGameSettingJailbreak.maxcalls;
                            }
                            else
                                if (Convert.ToInt32(NUDown.Tag) == 5)
                                {
                                    if (GetGameSettingJailbreak.maxpatterns_bonus == this.numMaxPatternBonus.Maximum)
                                    {
                                        numMaxPatternBonus.Value = GetGameSettingJailbreak.maxpatterns_bonus - 1;
                                    }
                                    else { numMaxPatternBonus.Value = GetGameSettingJailbreak.maxpatterns_bonus + 1; }
                                    numMaxPatternBonus.Value = GetGameSettingJailbreak.maxpatterns_bonus;
                                }
                                else if (Convert.ToInt32(NUDown.Tag) == 6)
                                {
                                    if (GetGameSettingJailbreak.maxcalls_bonus == this.numMaxCallsBonus.Maximum)
                                    {
                                        numMaxCallsBonus.Value = GetGameSettingJailbreak.maxcalls_bonus - 1;
                                    }
                                    else
                                    {
                                        numMaxCallsBonus.Value = GetGameSettingJailbreak.maxcalls_bonus + 1;
                                    }
                                    numMaxCallsBonus.Value = GetGameSettingJailbreak.maxcalls_bonus;

                                }
                                else if (Convert.ToInt32(NUDown.Tag) == 7)
                                {
                                    if (GetGameSettingJailbreak.callspeed == this.numCallSpeed.Maximum)
                                    {
                                        numCallSpeed.Value = GetGameSettingJailbreak.callspeed - 1;
                                    }
                                    else
                                    {
                                        numCallSpeed.Value = GetGameSettingJailbreak.callspeed + 1;
                                    }
                                    numCallSpeed.Value = GetGameSettingJailbreak.callspeed;
                                }
                                //else if (Convert.ToInt32(NUDown.Tag) == 7)
                                //{
                                //    if (GetGameSettingJailbreak.callspeed_min == this.numCallSpeedMin.Maximum)
                                //    {
                                //        numCallSpeedMin.Value = GetGameSettingJailbreak.callspeed_min - 1;
                                //    }
                                //    else { numCallSpeedMin.Value = GetGameSettingJailbreak.callspeed_min + 1; }
                                //    numCallSpeedMin.Value = GetGameSettingJailbreak.callspeed_min;
                                //}
                                //else if (Convert.ToInt32(NUDown.Tag) == 8)
                                //{
                                //    if (GetGameSettingJailbreak.callspeed_max == this.numCallSpeedMax.Maximum)
                                //    {
                                //        numCallSpeedMax.Value = GetGameSettingJailbreak.callspeed_max - 1;
                                //    }
                                //    else
                                //    {
                                //        numCallSpeedMax.Value = GetGameSettingJailbreak.callspeed_max + 1;
                                //    }
                                //    numCallSpeedMax.Value = GetGameSettingJailbreak.callspeed_max;

                                //}

            }
        }
    }
}
