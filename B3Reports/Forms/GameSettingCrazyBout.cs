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

            IsModified = false;
            return bResult;
        }

        //Lets load the value from DB into the UI controls
        private bool LoadCrazyBoutSettings()
        {
            GetGameSettingsCrazyBout ggscb = new GetGameSettingsCrazyBout();

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
            
            comboBoxMaxCard.SelectedItem = GetGameSettingsCrazyBout.maxcards.ToString();
            comboBoxMaxBetLevel.SelectedItem = GetGameSettingsCrazyBout.maxbetlevel.ToString();
            numCallSpeedMin.Value = GetGameSettingsCrazyBout.callspeed_min;
            numCallSpeedMax.Value = GetGameSettingsCrazyBout.callspeed_max;

            if (GetGameSettingsCrazyBout.autocall == "T")
            {chkbxAutoCall.Checked = true;}
            else 
            { chkbxAutoCall.Checked = false; }

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
            { chkbxDenom50.Checked = true; }
            else
            { chkbxDenom50.Checked = false; }

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
            IsModified = false;
            return bResult;
            //return base.SaveSettings();
        }

        private bool SaveCrazyBoutGameSettings()
        {
            GetGameSettingsCrazyBout x = new GetGameSettingsCrazyBout();//Let us use the set instead of the static variable. Does it execute the class again?
            if (x.MaxCards != int.Parse(comboBoxMaxCard.SelectedItem.ToString()))
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Cards", x.MaxCards.ToString(), comboBoxMaxCard.SelectedItem.ToString());
                x.MaxCards = int.Parse(comboBoxMaxCard.SelectedItem.ToString());
            }

            if (x.MaxBetLevel != int.Parse(comboBoxMaxBetLevel.SelectedItem.ToString()))
            {
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "Crazy Bout Setting - Max Bet Level", x.MaxBetLevel.ToString(), comboBoxMaxBetLevel.SelectedItem.ToString());
                x.MaxBetLevel = int.Parse(comboBoxMaxBetLevel.SelectedItem.ToString());

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
        }

        private void numMaxCards_Leave(object sender, EventArgs e)
        {
            NumericUpDown NUDown = (NumericUpDown)sender;
            if (NUDown.Text == "")
            {
                if (Convert.ToInt32(NUDown.Tag) == 7)
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

        private void ModifiedSettings(object sender, EventArgs e)
        {
            IsModified = true;
        }

    }
}
