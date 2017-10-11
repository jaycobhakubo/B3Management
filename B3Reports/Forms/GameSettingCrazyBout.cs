﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace GameTech.B3Reports.Forms
{
    public partial class GameSettingCrazyBout : SettingsControl
    {
        public GameSettingCrazyBout()
        {
            InitializeComponent();
            LoadSettings();
            
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadCrazyBoutSettings();
            this.ResumeLayout();
            return bResult;
        }

        //Lets load the value from DB into the UI controls
        private bool LoadCrazyBoutSettings()
        {
            GetGameSettingsCrazyBout ggscb = new GetGameSettingsCrazyBout();

            if (numMaxCards.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxcards == this.numMaxCards.Maximum)
                {
                    numMaxCards.Value = GetGameSettingsCrazyBout.maxcards - 1;
                }
                else
                { numMaxCards.Value = GetGameSettingsCrazyBout.maxcards + 1; }
            }
            if (numMaxBetLevel.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxbetlevel == this.numMaxBetLevel.Maximum)
                {
                    numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel - 1;
                }
                else { numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel + 1; }
            }
            if (numMaxPattern.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxpatterns == this.numMaxPattern.Maximum)
                {
                    numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns - 1;
                }
                else { numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns + 1;}
            }
            if (numMaxCalls.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxcalls == this.numMaxCalls.Maximum)
                {
                numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls - 1;
                }
                else {numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls + 1;}
            }
            if (numMaxPatternBonus.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxpatterns_bonus == this.numMaxPatternBonus.Maximum)
                {
                    numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus - 1;
                }
                else { numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus + 1; }
            }
            if (numMaxCallsBonus.Text == "")
            {
                if (GetGameSettingsCrazyBout.maxcalls_bonus == this.numMaxCallsBonus.Maximum)
                {
                    numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus - 1;
                }
                else
                {
                    numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus + 1;
                }
            }
            if (numCallSpeedMin.Text == "")
            {
                if (GetGameSettingsCrazyBout.callspeed_min == this.numCallSpeedMin.Maximum)
                {
                    numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min - 1;
                }
                else { numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min + 1; }
            }
            if (numCallSpeedMax.Text == "")
            {
                if (GetGameSettingsCrazyBout.callspeed_max == this.numCallSpeedMax.Maximum)
                {
                numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max - 1;
                }
                else{
                    numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max + 1;
                }
            }
            
            numMaxCards.Value = GetGameSettingsCrazyBout.maxcards;
            numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel;
            numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns;
            numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls;
            numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus;
            numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus;
            numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min;
            numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max;

            if (GetGameSettingsCrazyBout.autocall == "T")
            {chkbxAutoCall.Checked = true;}
            else 
            { chkbxAutoCall.Checked = false; }

            if (GetGameSettingsCrazyBout.autoplay == "T")
            { chkbxAutoPlay.Checked = true; }
            else
            { chkbxAutoPlay.Checked = false; }

            if (GetGameSettingsCrazyBout.singleofferbonus == "T")
            { chkbxSingleOfferBonus.Checked = true; }
            else
            { chkbxSingleOfferBonus.Checked = false; }

            if (GetGameSettingsCrazyBout.hidecardserialnum == "T")
            { chkbxHideCardSerialNumber.Checked = true; }
            else
            { chkbxHideCardSerialNumber.Checked = false;}
       
            if (GetGameSettingsCrazyBout.denom_1 == "T")
            { chkbxDenom1.Checked = true; }
            else
            { chkbxDenom1.Checked = false; }

            if (GetGameSettingsCrazyBout.denom_5 == "T")
            { chkbxDenom5.Checked = true; }
            else
            { chkbxDenom5.Checked = false; }

            if (GetGameSettingsCrazyBout.denom_10 == "T")
            { chkbxDenom10.Checked = true; }
            else
            { chkbxDenom10.Checked = false; }

            if (GetGameSettingsCrazyBout.denom_25 == "T")
            { chkbxDenom25.Checked = true; }
            else
            { chkbxDenom25.Checked = false; }

            if (GetGameSettingsCrazyBout.denom_50 == "T")
            { chkbxDenom1d.Checked = true; }
            else
            { chkbxDenom1d.Checked = false; }

            if (GetGameSettingsCrazyBout.denom_100 == "T")
            { chkbxDenom1d.Checked = true; }
            else
            { chkbxDenom1d.Checked = false; }

            if(GetGameSettingsCrazyBout.denom_200 == "T")
            { chkbxDenom2d.Checked = true; }
            else
            { chkbxDenom2d.Checked = false; }

            if(GetGameSettingsCrazyBout.denom_500 == "T")
            { chkbxDenom5d.Checked = true; }
            else
            { chkbxDenom5d.Checked = false; }
            return true;

        }

        public override bool SaveSettings()
        {
            Cursor curs = Cursors.WaitCursor;
            bool bResult = SaveCrazyBoutGameSettings();
            curs = Cursors.Default;
            return bResult;
            //return base.SaveSettings();
        }

        private bool SaveCrazyBoutGameSettings()
        {
            GetGameSettingsCrazyBout x = new GetGameSettingsCrazyBout();//Let us use the set instead of the static variable. Does it execute the class again?
            if (x.MaxCards != (int)numMaxCards.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Cards", x.MaxCards.ToString(), numMaxCards.Value.ToString());
            x.MaxCards = (int)numMaxCards.Value;
      

            }

            if (x.MaxBetLevel != (int)numMaxBetLevel.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Bet Level", x.MaxBetLevel.ToString(), numMaxBetLevel.Value.ToString());
                x.MaxBetLevel = (int)numMaxBetLevel.Value;
               
            }

            if (x.MaxPatterns != (int)numMaxPattern.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Patterns", x.MaxPatterns.ToString(), numMaxPattern.Value.ToString());
                x.MaxPatterns = (int)numMaxPattern.Value;
         
            }

            if (x.MaxCalls != (int)numMaxCalls.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Calls", x.MaxCalls.ToString(), numMaxCalls.Value.ToString());
                x.MaxCalls = (int)numMaxCalls.Value;
        
            }

            if (x.MaxPattern_Bonus != (int)numMaxPatternBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Pattern Bonus", x.MaxPattern_Bonus.ToString(), numMaxPatternBonus.Value.ToString());
                x.MaxPattern_Bonus = (int)numMaxPatternBonus.Value;
     
            }

            if (x.MaxCalls_Bonus != (int)numMaxCallsBonus.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Call Bonus", x.MaxCalls_Bonus.ToString(), numMaxCallsBonus.Value.ToString());
                x.MaxCalls_Bonus = (int)numMaxCallsBonus.Value;

            }

            if (x.CallSpeed_Min != (int)numCallSpeedMin.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Call Speed min.", x.CallSpeed_Min.ToString(), numCallSpeedMin.Value.ToString());
                x.CallSpeed_Min = (int)numCallSpeedMin.Value;
                
            }

            if ( x.CallSpeed_Max != (int)numCallSpeedMax.Value)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Call Speed max.", x.CallSpeed_Max.ToString(), numCallSpeedMax.Value.ToString());
                x.CallSpeed_Max = (int)numCallSpeedMax.Value;

            }

            string  UIValue;
            UIValue = (chkbxAutoCall.Checked == true) ? "T" : "F";
            if (x.AutoCall != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Auto Call", x.AutoCall.ToString(), UIValue);
                x.AutoCall = UIValue;//(chkbxAutoCall.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxAutoPlay.Checked == true) ? "T" : "F";
            if (x.AutoPlay != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Auto Play", x.AutoPlay.ToString(), UIValue);
                x.AutoPlay = UIValue;

            }

            UIValue = (chkbxDenom1.Checked == true) ? "T" : "F";
            if (x.Denom_1 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 1 cent", x.Denom_1.ToString(), UIValue);
               x.Denom_1 = (chkbxDenom1.Checked == true) ? "T" : "F";

           }

            UIValue = (chkbxDenom5.Checked == true) ? "T" : "F";
            if (x.Denom_5 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 5 cent", x.Denom_5.ToString(), UIValue);
                x.Denom_5 = (chkbxDenom5.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom10.Checked == true) ? "T" : "F";
            if (x.Denom_10 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 10 cent", x.Denom_10.ToString(), UIValue);
                x.Denom_10 = (chkbxDenom10.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom25.Checked == true) ? "T" : "F";
            if (x.Denom_25 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 25 cent", x.Denom_25.ToString(), UIValue);
                x.Denom_25 = (chkbxDenom25.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom50.Checked == true) ? "T" : "F";
            if (x.Denom_50 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 50 cent", x.Denom_50.ToString(), UIValue);
                x.Denom_50 = (chkbxDenom50.Checked == true) ? "T" : "F";
     
            }

            UIValue = (chkbxDenom1d.Checked == true) ? "T" : "F";
            if (x.Denom_100 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 1 dollar", x.Denom_100.ToString(), UIValue);
                x.Denom_100 = (chkbxDenom1d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom2d.Checked == true) ? "T" : "F";
            if (x.Denom_200 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 2 dollars", x.Denom_200.ToString(), UIValue);
                x.Denom_200 = (chkbxDenom2d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxDenom5d.Checked == true) ? "T" : "F";
            if (x.Denom_500 != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Denom 5 dollars", x.Denom_500.ToString(), UIValue);
                x.Denom_500 = (chkbxDenom5d.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";
            if (x.SingleOfferBonus != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Single Offer Bonus", x.SingleOfferBonus.ToString(), UIValue);
                x.SingleOfferBonus = (chkbxSingleOfferBonus.Checked == true) ? "T" : "F";

            }

            UIValue = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";
            if (x.HideCardSerialNum != UIValue)
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Hide card serial number", x.HideCardSerialNum.ToString(), UIValue);
                x.HideCardSerialNum = (chkbxHideCardSerialNumber.Checked == true) ? "T" : "F";

            }
    
            SetGameSettingsCrazyBout set = new SetGameSettingsCrazyBout();

            return true;

            //REFERENCE ON GAME SETTINGS
            //Logged the changes
            //if (GetGameSettings.MinNumberOfPlayers != (int)numMinimumPlayer.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Number of Players", GetGameSettings.MinNumberOfPlayers.ToString(), numMinimumPlayer.Value.ToString());
            //}
            //if (GetGameSettings.ConsolationPrize != x)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum Consolation Prize", GetGameSettings.ConsolationPrize.ToString(), x.ToString());
            //}
            //if (GetGameSettings.CountDownTimer != (int)numCountdownTimer.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Countdown Timer", GetGameSettings.CountDownTimer.ToString(), numCountdownTimer.Value.ToString());
            //}
            //if (GetGameSettings.GameRecalPasswords != txtbxGameRecallPassword.Text.ToString())
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Game Recall Paswword", GetGameSettings.GameRecalPasswords.ToString(), txtbxGameRecallPassword.Text);
            //}
            //if (GetGameSettings.WaitCountDownForOtherPLayers != (int)numWaitCountdownTimerOP.Value)
            //{
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Minimum number of Players Wait Time", GetGameSettings.WaitCountDownForOtherPLayers.ToString(), numWaitCountdownTimerOP.Value.ToString());
            //}

            //GetGameSettings.MinNumberOfPlayers = (int)numMinimumPlayer.Value;
            //GetGameSettings.ConsolationPrize = x;
            //GetGameSettings.CountDownTimer = (int)numCountdownTimer.Value;
            //GetGameSettings.GameRecalPasswords = txtbxGameRecallPassword.Text.ToString();
            //GetGameSettings.WaitCountDownForOtherPLayers = (int)numWaitCountdownTimerOP.Value;
            //SetGameSettings set = new SetGameSettings();
        }

        private void numMaxCards_Leave(object sender, EventArgs e)
        {
            NumericUpDown NUDown = (NumericUpDown)sender;
            if (NUDown.Text == "")
            {
                if (Convert.ToInt32(NUDown.Tag) == 1)
                {
                    if (GetGameSettingsCrazyBout.maxcards == this.numMaxCards.Maximum)
                    {
                        numMaxCards.Value = GetGameSettingsCrazyBout.maxcards - 1;
                    }
                    else
                    { numMaxCards.Value = GetGameSettingsCrazyBout.maxcards + 1; }
                    numMaxCards.Value = GetGameSettingsCrazyBout.maxcards;

                }else
                if (Convert.ToInt32(NUDown.Tag) == 2)
                {
                    if (GetGameSettingsCrazyBout.maxbetlevel == this.numMaxBetLevel.Maximum)
                    {
                        numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel - 1;
                    }
                    else { numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel + 1; }
                    numMaxBetLevel.Value = GetGameSettingsCrazyBout.maxbetlevel;
                }else
                    if (Convert.ToInt32(NUDown.Tag) == 3)
                    {
                        if (GetGameSettingsCrazyBout.maxpatterns == this.numMaxPattern.Maximum)
                        {
                            numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns - 1;
                        }
                        else { numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns + 1; }
                        numMaxPattern.Value = GetGameSettingsCrazyBout.maxpatterns;
                    }
                    else
                        if (Convert.ToInt32(NUDown.Tag) == 4)
                    {
                        if (GetGameSettingsCrazyBout.maxcalls == this.numMaxCalls.Maximum)
                        {
                            numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls - 1;
                        }
                        else { numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls + 1; }
                        numMaxCalls.Value = GetGameSettingsCrazyBout.maxcalls;
                    }else
                if (Convert.ToInt32(NUDown.Tag) == 5)
                      {
                          if (GetGameSettingsCrazyBout.maxpatterns_bonus == this.numMaxPatternBonus.Maximum)
                          {
                              numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus - 1;
                          }
                          else { numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus + 1; }
                          numMaxPatternBonus.Value = GetGameSettingsCrazyBout.maxpatterns_bonus;
                      }
                else if (Convert.ToInt32(NUDown.Tag) == 6)
                {
                    if (GetGameSettingsCrazyBout.maxcalls_bonus == this.numMaxCallsBonus.Maximum)
                    {
                        numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus - 1;
                    }
                    else
                    {
                        numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus + 1;
                    }
                    numMaxCallsBonus.Value = GetGameSettingsCrazyBout.maxcalls_bonus;

                }
                else if (Convert.ToInt32(NUDown.Tag) == 7)
                {
                    if (GetGameSettingsCrazyBout.callspeed_min == this.numCallSpeedMin.Maximum)
                    {
                        numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min - 1;
                    }
                    else { numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min + 1; }
                    numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min;
                }
                else if (Convert.ToInt32(NUDown.Tag) == 8)
                {
                    if (GetGameSettingsCrazyBout.callspeed_max == this.numCallSpeedMax.Maximum)
                    {
                        numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max - 1;
                    }
                    else
                    {
                        numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max + 1;
                    }
                    numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max;

                }
                
            }
        }

    }
}