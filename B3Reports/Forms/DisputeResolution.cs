using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace GameTech.B3Reports.Forms
{
    public partial class DisputeResolution : Form//: GradientForm
    //   public partial class DisputeResolution :  GradientForm
    {
        #region MEMBERS

        int AccountNumber;
        bool IsAccountNumberValid_ = false;
        bool AccountPlayed = false;
        string SelectedB4Game = "";
        int GameNumStart = 0;
        int GameNumEnd = 0;
        int CardNumStart = 0;
        int CardNumEnd = 0;
        DateTime? PlayTime = null;
        int Status = 0; //0 -> First record, 1 -> next, 2 -> back
        int CurrentDenom;
        string BallCall;
        string MayaMoneyPattern = "";
        bool SpiritBR = false;
        bool GetDualAccountSetting;
        bool sClass2;
        int MayaMoneyCardTypeImage = 0; //1 = regular; 2 = all card is active
        SqlConnection sc = GetSQLConnection.get();
        GetInfo mGetInfo;
        bool mIsBonusGameInProgress;


        #endregion

        public DisputeResolution()
        {
            InitializeComponent();
            AdjustWindowSize.adjust(this);
        }

        #region EVENTS

        private void imageButton4_Click(object sender, EventArgs e)//Return
        {
            if (lblTotalWin2.Text != string.Empty)
            {
                lblTotalWin2.Text = string.Empty;
            }

            label18.Text = string.Empty;
            cmbxGameNumberStart.Text = string.Empty;
            cmbxGameNumberEnd.Text = string.Empty;
            cmbxGameNumberStart.SelectedIndex = -1;
            cmbxGameNumberEnd.SelectedIndex = -1;
            cmbxGameNumberStart.Items.Clear();
            cmbxGameNumberEnd.Items.Clear();

            ClearErrorProvider();
            if (checkBox1.Checked != false)
            {
                checkBox1.Checked = false;
            }

            TurnOffNotInPlayImages();
            DontShowCardPanel();
            pnlBonusRound.Visible = false;
            ClearInfo();
            clearAllLblMessage();
            PlayTime = null;
            DisableControlsInPanel1();
            EnableControlInPanel2();
            txtbxAccountNumber.Select();
            Status = 0;
            CardNumStart = 0;
            CardNumEnd = 0;
            lstviewPatterListTable.Items.Clear();
            chkbxGameNumber.Checked = false;
            chkbxGameNumber.Enabled = false;
            cmbxGameName.Items.Clear();
            txtbxAccountNumber.Text = string.Empty;
            AccountNumber = 0;
            label11.Visible = false;

            try
            {
                if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                }
                else
                {
                    this.Visible = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void imgbtnEnd_Click(object sender, EventArgs e)
        {

            lblTotalWin2.Text = string.Empty;

            if (checkBox1.Checked != false)
            {checkBox1.Checked = false;}

            if (checkBox1.Visible != false)
            { checkBox1.Visible = false; }
            
            TurnOffNotInPlayImages();
            DontShowCardPanel();
            pnlBonusRound.Visible = false;
            ClearInfo();
            clearAllLblMessage();
            PlayTime = null;
            DisableControlsInPanel1();
            EnableControlInPanel2();
            txtbxAccountNumber.Select();
            Status = 0;
            CardNumStart = 0;
            CardNumEnd = 0;
            label11.Visible = false;
            label18.Text = string.Empty;


            if (cmbxGameName.SelectedIndex != -1 && cmbxGameName.SelectedItem.ToString() != "All")
            {
                chkbxGameNumber.Enabled = true;
            }

            lstviewPatterListTable.Items.Clear();

            if (chkbxGameNumber.Checked == true)
            {
                loadGameStartAndEndNumber();
            }
        }

        private void imageButton2_Click(object sender, EventArgs e)
        {
            NonBonusRound();
        }

        private void DisputeResolution_Load(object sender, EventArgs e)
        {

            cmbxGameName.SelectedIndex = -1;
            txtbxAccountNumber.Select();
            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);

            GetDualAccountSetting = GetDualAccountSettings.getDualAccountSettings();
            if (GetDualAccountSetting == true)
            {
                lblTotalWin.Visible = true;
                lblTotalWin2.Visible = true;
            }
            else
            {
                lblTotalWin.Visible = false;
                lblTotalWin2.Visible = false;
            }

            //REMOVED CARD
            RemovedCardLabelEvent(pnlRegRedCard);
            RemovedCardLabelEvent(pnlRegPurpCard);
            RemovedCardLabelEvent(pnlRegGreenCard);
            RemovedCardLabelEvent(pnlRegBlueCard);

        }

        private void txtbxAccountNumber_MouseLeave(object sender, EventArgs e)
        {
        }

        private void txtbxAccountNumber_Leave(object sender, EventArgs e)
        {
        }

        private void txtbxAccountNumber_KeyPress(object sender, KeyPressEventArgs e)
        {
            //if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
            //    return;
            bool result = true;
            if (e.KeyChar == (char)Keys.Back)
            {
                result = false;
            }

            if (e.KeyChar == (char)13)
            {
                imgbtnLookUp.PerformClick();
            }

            if (result)
            {
                result = !char.IsDigit(e.KeyChar);
            }
            e.Handled = result;
        }

        private void txtbxAccountNumber_Validating(object sender, CancelEventArgs e)
        {
            if (txtbxAccountNumber.Text != string.Empty)
            {
                if (IsAccountNumberValid_ == false)
                {
                    cmbxGameName.SelectedIndex = -1;
                    cmbxGameName.Items.Clear();
                    chkbxGameNumber.Checked = false;
                    chkbxCardNumber.Checked = false;
                    e.Cancel = true;
                    errorProvider1.SetError(txtbxAccountNumber, "Invalid Account Number");
                }
                else
                    if (AccountPlayed == false)
                    {
                        e.Cancel = true;
                        errorProvider1.SetError(txtbxAccountNumber, "No activity.");
                    }
            }

        }

        private void cmbxGameName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearErrorProvider();
            if (cmbxGameName.SelectedIndex != -1 && cmbxGameName.SelectedItem.ToString() != "All")
            {
                cmbxGameNumberStart.Items.Clear();
                GameNumEnd = 0;
                CardNumEnd = 0;
                if (cmbxGameName.SelectedItem.ToString() == "Crazy Bout")
                {
                    SelectedB4Game = "CrazyBout";
                }
                else
                if (cmbxGameName.SelectedItem.ToString() == "Jailbreak")
                {
                    SelectedB4Game = "JailBreak";
                }
                else
                if (cmbxGameName.SelectedItem.ToString() == "Maya Money")
                {
                    SelectedB4Game = "MayaMoney";
                }
                else
                if (cmbxGameName.SelectedItem.ToString() == "Wild Ball")
                {
                    SelectedB4Game = "WildBall";
                }
                else
                if (cmbxGameName.SelectedItem.ToString() == "Spirit 76")
                {
                    SelectedB4Game = "Spirit76";
                }
                else
                    if (cmbxGameName.SelectedItem.ToString() == "Time Bomb")
                    {
                        SelectedB4Game = "TimeBomb";
                    }
                else
                {
                    SelectedB4Game = cmbxGameName.SelectedItem.ToString();
                }

                chkbxGameNumber.Enabled = true;


                GetGameNumber getGameNumber = new GetGameNumber(AccountNumber, SelectedB4Game);
                List<gamenumber> gn = new List<gamenumber>();
                gn = listgamenumber.lgamenumber;

                foreach (gamenumber g_n in gn)
                {
                    cmbxGameNumberStart.Items.Add(g_n.gamenum);
                }


                if (chkbxGameNumber.Checked == true)
                {
                    cmbxGameNumberStart.SelectedIndex = 0;
                }
            }
            else if (cmbxGameName.SelectedItem.ToString() == "All")
            {
                chkbxGameNumber.Checked = false;
                chkbxCardNumber.Checked = false;
                chkbxGameNumber.Enabled = false;
                chkbxCardNumber.Enabled = false;
                SelectedB4Game = "All";
            }
            else if (cmbxGameName.SelectedIndex == -1)
            {
                chkbxGameNumber.Checked = false;
                chkbxCardNumber.Checked = false;
                chkbxGameNumber.Enabled = false;
                chkbxCardNumber.Enabled = false;
            }
        }

        private void cmbxGameNumberStart_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (cmbxGameNumberStart.Items.Count > 0 && cmbxGameNumberStart.SelectedIndex != -1)
            {
                cmbxGameNumberEnd.Items.Clear();
                //GameNumStart = Convert.ToInt32(cmbxGameNumberStart.SelectedItem.ToString());
                GameNumStart = listgamenumber.lgamenumber[cmbxGameNumberStart.SelectedIndex].sgamenum;

                //CurrentGameNumber = GameNumStart;
                try
                {
                    sc.Open();
                    using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetGameNumEnd
                                                            @spCreditAccountNumber  = @AccountNumber
                                                            ,@spB4Games = @SelectedB4Game 
                                                             ,@spStartGameNum = @GameNumStart", sc))
                    {
                        cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                        cmd.Parameters.AddWithValue("SelectedB4Game", SelectedB4Game);
                        cmd.Parameters.AddWithValue("GameNumStart", GameNumStart);
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            cmbxGameNumberEnd.Items.Add(reader.GetInt32(0));
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    sc.Close();
                }



                if (GameNumEnd == 0)
                {
                    cmbxGameNumberEnd.SelectedIndex = cmbxGameNumberEnd.Items.Count - 1;
                }
                else
                {
                    if (GameNumStart <= GameNumEnd)
                    {
                        int indexOfGameEnd = cmbxGameNumberEnd.Items.IndexOf(GameNumEnd);
                        cmbxGameNumberEnd.SelectedIndex = indexOfGameEnd;
                    }
                    else
                    {
                        int indexOfGameEnd = cmbxGameNumberEnd.Items.IndexOf(GameNumStart);
                        cmbxGameNumberEnd.SelectedIndex = indexOfGameEnd;
                    }
                }

                GetCardStartNumber();

            }
            else
                if (cmbxGameNumberStart.SelectedIndex == -1)
                {
                    cmbxGameNumberEnd.SelectedIndex = -1;
                }
        }

        private void cmbxGameNumberEnd_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbxGameNumberEnd.SelectedIndex != -1)
            {
                GameNumEnd = Convert.ToInt32(cmbxGameNumberEnd.SelectedItem.ToString());
                //if (chkbxCardNumber.Checked == true)
                //{

                //find the selectindex of an item
                int index = cmbxGameNumberStart.Items.IndexOf(cmbxGameNumberEnd.SelectedItem);
                GameNumEnd = listgamenumber.lgamenumber[index].sgamenum;

                CardNumEnd = 0;
                //GetCardStartNumber();
                //}

            }
        }


        private void txtbxAccountNumber_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();
        }

        private void chkbxGameNumber_CheckedChanged(object sender, EventArgs e)
        {

            loadGameStartAndEndNumber();
            ClearErrorProvider();
        }

        private void chkbxCardNumber_CheckedChanged(object sender, EventArgs e)
        {
            if (chkbxCardNumber.Checked == true)
            {
                groupBox3.Enabled = true;
                cmbxCardNumberStart.SelectedIndex = 0;
            }
            else
            {
                groupBox3.Enabled = false;
                cmbxCardNumberStart.SelectedIndex = -1;
                cmbxCardNumberEnd.SelectedIndex = -1;
            }
        }

        private void cmbxCardNumberStart_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbxCardNumberStart.Items.Count > 0 && cmbxCardNumberStart.SelectedIndex != -1)
            {
                cmbxCardNumberEnd.Items.Clear();
                CardNumStart = Convert.ToInt32(cmbxCardNumberStart.SelectedItem.ToString());

                //Lets us not go to DB let us handle it here in .NET.
                //get the maximum value
                int MaxNumber = Convert.ToInt32(cmbxCardNumberStart.Items[cmbxCardNumberStart.Items.Count - 1].ToString());

                List<int> test3 = new List<int>();
                foreach (int x in cmbxCardNumberStart.Items)
                {
                    test3.Add(x);
                }

                int[] test4 = test3.ToArray();

                var test = from x in test4
                           where (x >= CardNumStart && x <= MaxNumber)
                           select x;

                foreach (int num in test)
                {
                    cmbxCardNumberEnd.Items.Add(num);
                }

                if (CardNumEnd == 0)
                {
                    cmbxCardNumberEnd.SelectedIndex = cmbxCardNumberEnd.Items.Count - 1;
                }
                else
                {
                    if (CardNumStart <= CardNumEnd)
                    {
                        int indexOfCardEnd = cmbxCardNumberEnd.Items.IndexOf(CardNumEnd); //cmbxGameNumberEnd.Items.IndexOf(GameNumEnd);
                        cmbxCardNumberEnd.SelectedIndex = indexOfCardEnd;
                    }
                    else
                    {
                        int indexOfCardEnd = cmbxCardNumberEnd.Items.IndexOf(CardNumStart); //cmbxGameNumberEnd.Items.IndexOf(GameNumEnd);
                        cmbxCardNumberEnd.SelectedIndex = indexOfCardEnd;
                    }
                }
            }
        }

        private void cmbxCardNumberEnd_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbxCardNumberEnd.SelectedIndex != -1)
            {
                CardNumEnd = Convert.ToInt32(cmbxCardNumberEnd.SelectedItem.ToString());
            }
        }

        private void imgbtnLookUp_Click(object sender, EventArgs e)
        {

            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                return;

            if (txtbxAccountNumber.Text != string.Empty && cmbxGameName.Items.Count != 0)
            {
                GetInfoALL();            
                ShowCardPanel();
                DisableControlsInPanel2();//knc
                //EnableControlInPanel1();

                imgbtnNext.Enabled = false;
                imgbtnBack.Enabled = true;
                imgbtnEnd.Enabled = true;

                TurnOnNotInPlayImages();
            }
            else
            {
                errorProvider1.SetError(txtbxAccountNumber, "Account number is empty.");
            }
        }


        private void imgbtnBack_Click(object sender, EventArgs e)
        {

            if (checkBox1.Checked != false)
            {
                checkBox1.Checked = false;
            }

            Status = 2;
            GetInfoALL();         
        }

        private void imgbtnNext_Click(object sender, EventArgs e)
        {
            Status = 1;
            GetInfoALL();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkbxShowBonusCard = (CheckBox)sender;
            if (chkbxShowBonusCard.Checked == true)
            {
                pnlRegularGames.Visible = false;
                pnlBonusRound.Visible = true;

                if (SelectedB4Game != "WildBall")
                {
                    panel14.Visible = false;
                }
                else
                {
                    panel14.Visible = true;
                }

                GetBallCall.GetBonusBallCall_(PlayTime, mGetInfo.B4Games.ToString(), AccountNumber, mGetInfo.BonusBallCount);
                BallCall = GetBallCall.BonusBallCall;
                BallCall = BallCall.Remove(BallCall.Length - 1);
                richTextBox1.Clear();
                richTextBox1.Text = BallCall.Replace(",", ", ");

                //PatternPayTable 
                GetNWinningPattern.GetNBonusWinningPattern(AccountNumber, PlayTime, mGetInfo.B4Games);
                lstviewPatterListTable.Items.Clear();
                CurrentDenom = mGetInfo.BetDenom;
                GetPatternBonusPayTable getPatternBonusPayTable = new GetPatternBonusPayTable(CurrentDenom, mGetInfo.B4Games);

                List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
                listPatternTable = ListPatternPayTable.listpatternpaytable;

                foreach (PatternPayTable ppt in listPatternTable)
                {
                    ListViewItem lvi = new ListViewItem(ppt.PatterName);
                    lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * mGetInfo.BetLevel));
                    string NH = (ppt.NH == 0) ? string.Empty : ppt.NH.ToString();
                    lvi.SubItems.Add(NH);
                    lstviewPatterListTable.Items.Add(lvi);
                }



                OfferAccepted();

                int TempCardNumber = mGetInfo.FirstBonusCardNumber;
                int Count = 7;
                while (TempCardNumber != mGetInfo.LastBonusCardNumber + 1)
                {
                    //  MessageBox.Show(TempCardNumber.ToString());
                    GetCardNumber gcn = new GetCardNumber(TempCardNumber);
                    LoadCard(Count);
                    if (Count == 7)
                    {
                        lblBonusSerialn1.Text = TempCardNumber.ToString();
                    }
                    else if (Count == 8)
                    {
                        lblBonusSerial2.Text = TempCardNumber.ToString();
                    }
                    else if (Count == 9)
                    {
                        lblBonusSerial3.Text = TempCardNumber.ToString();
                    }
                    else if (Count == 10)
                    {
                        lblBonusSerial4.Text = TempCardNumber.ToString();
                    }

                    Count = Count + 1;
                    TempCardNumber = TempCardNumber + 1;
                }
            }
            else
            {
                pnlRegularGames.Visible = true;
                pnlBonusRound.Visible = false;
                richTextBox1.Clear();
                GetBallCall y = new GetBallCall(PlayTime, mGetInfo.B4Games.ToString(), AccountNumber, mGetInfo.BallCount, mGetInfo.GameNumber);
                BallCall = GetBallCall.BallCall;
                BallCall = BallCall.Remove(BallCall.Length - 1);
                richTextBox1.Text = BallCall.Replace(",", ", ");


                GetNWinningPattern gnwn = new GetNWinningPattern(AccountNumber, PlayTime, mGetInfo.B4Games, mGetInfo.WinAmount);
                lstviewPatterListTable.Items.Clear();
                CurrentDenom = mGetInfo.BetDenom;
                GetPatternPayTable getPatternPayTable = new GetPatternPayTable(CurrentDenom, mGetInfo.B4Games);

                List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
                listPatternTable = ListPatternPayTable.listpatternpaytable;




                foreach (PatternPayTable ppt in listPatternTable)
                {
                    if (GetGameSettings.MinNumberOfPlayers <= 1 &&
                        ppt.PatterName == "Coverall")
                    {
                        continue;
                    }
                    ListViewItem lvi = new ListViewItem(ppt.PatterName);
                    lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * mGetInfo.BetLevel));
                    string NH = (ppt.NH == 0) ? string.Empty : ppt.NH.ToString();
                    lvi.SubItems.Add(NH);
                    lstviewPatterListTable.Items.Add(lvi);
                }


            }
        }

        private void StampBingoN(Panel pnl)
        {

            var c = pnl.Controls.OfType<Label>().ToArray();
            foreach (var x in c)
            {
                if (IsDubbed.Dubbed(x.Text, BallCall) == true ||  ((x.Text == "Fr") || (x.Text == "Free") ))
                {
                    x.BackColor = Color.LimeGreen;
                }
                else
                {
                    x.BackColor = Color.White;
                }


                if ((SelectedB4Game == "Spirit76" && SpiritBR == true) && checkBox1.Checked == true)
                {
                    string ballfreq = "," + GetBallCall.GetBallFreqFor76Games(PlayTime, AccountNumber);
                    if (ballfreq.IndexOf("," + x.Tag.ToString() + ",") != -1)
                    {
                        x.BackColor = Color.LimeGreen;
                    }
                }
            }

            
        }

        private void lblBingoCard1_TextChanged(object sender, EventArgs e)
        {
            Label x = (Label)sender;
            //test

            if (IsDubbed.Dubbed(x.Text, BallCall) == true)
            {
                x.BackColor = Color.LimeGreen;
            }
            else 
            {
                x.BackColor = Color.White;
            }


            if ((SelectedB4Game == "Spirit76" && SpiritBR == true) && checkBox1.Checked == true)
            {
                string ballfreq = "," + GetBallCall.GetBallFreqFor76Games(PlayTime, AccountNumber);
                if (ballfreq.IndexOf("," + x.Tag.ToString() + ",") != -1)
                {
                    x.BackColor = Color.LimeGreen;
                }
            }
        }


        private void DisputeResolution_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void txtbxAccountNumber_TextChanged(object sender, EventArgs e)
        {
            if (txtbxAccountNumber.Text != string.Empty)
            {
                bool isValid = IsAccountNumberValid(Convert.ToInt32(txtbxAccountNumber.Text));
                if (isValid == true)//if its valid
                {
                    imgbtnLookUp.Enabled = true;
                    SelectedB4Game = "";
                    label11.Visible = false;
                    AccountNumber = Convert.ToInt32(txtbxAccountNumber.Text);
                    IsAccountNumberValid_ = true;
                    cmbxGameName.Items.Clear();
                    chkbxGameNumber.Checked = false;
                    GameNumStart = 0;
                    GameNumEnd = 0;
                    CardNumStart = 0;
                    CardNumEnd = 0;
                    Status = 0;
                    CurrentDenom = 0;
                    BallCall = string.Empty;

                    AccountPlayed = IsThisAccountPlayedAnyGames(AccountNumber);

                    try
                    {
                        sc.Open();
                        using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetGames @spAccountNumber  = @AccountNumber", sc))
                        {
                            cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                            SqlDataReader reader = cmd.ExecuteReader();
                            string GameName = "";
                            while (reader.Read())
                            {
                                if (reader.GetString(0) == "CrazyBout" ||
                                    reader.GetString(0) == "JailBreak" ||
                                    reader.GetString(0) == "WildBall" ||
                                    reader.GetString(0) == "Spirit76" ||
                                    reader.GetString(0) == "MayaMoney" ||
                                     reader.GetString(0) == "TimeBomb")

                                    if (reader.GetString(0) == "CrazyBout")
                                    {
                                        GameName = "Crazy Bout";
                                    }
                                    else if (reader.GetString(0) == "JailBreak")
                                    {
                                        GameName = "Jailbreak";
                                    }
                                    else if (reader.GetString(0) == "MayaMoney")
                                    {
                                        GameName = "Maya Money";
                                    }
                                    else if (reader.GetString(0) == "WildBall")
                                    {
                                        GameName = "Wild Ball";
                                    }
                                    else if (reader.GetString(0) == "Spirit76")
                                    {
                                        GameName = "Spirit 76";
                                    }
                                    else if (reader.GetString(0) == "TimeBomb")
                                    {
                                        GameName = "Time Bomb";
                                    }
                                    else
                                    {
                                        GameName = reader.GetString(0);
                                    }
                       
                                    cmbxGameName.Items.Add(GameName);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        sc.Close();
                    }

                    if (cmbxGameName.Items.Count > 1)//If it only plays one game we dont need to include the "ALL"
                    {
                        cmbxGameName.Items.Add("All");
                    }

                    if (cmbxGameName.Items.Count > 0)
                    {
                        cmbxGameName.SelectedIndex = 0;
                    }

                    ClearErrorProvider();
                }
                else
                {
                    imgbtnLookUp.Enabled = false;
                    SelectedB4Game = "";
                    label11.Visible = false;
                    cmbxGameName.Items.Clear();
                    chkbxGameNumber.Checked = false;
                    GameNumStart = 0;
                    GameNumEnd = 0;
                    CardNumStart = 0;
                    CardNumEnd = 0;
                    Status = 0;
                    CurrentDenom = 0;
                    BallCall = string.Empty;
                }
            }
            else
            {
                imgbtnLookUp.Enabled = false;
                SelectedB4Game = "";
                label11.Visible = false;
                cmbxGameName.Items.Clear();
                chkbxGameNumber.Checked = false;
                GameNumStart = 0;
                GameNumEnd = 0;
                CardNumStart = 0;
                CardNumEnd = 0;
                Status = 0;
                CurrentDenom = 0;
                BallCall = string.Empty;
            }
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }



        private void DisputeResolution_FormClosing_1(object sender, FormClosingEventArgs e)
        {
            ClearErrorProvider();
            checkBox1.Checked = false;
            TurnOffNotInPlayImages();
            DontShowCardPanel();
            pnlBonusRound.Visible = false;
            ClearInfo();
            clearAllLblMessage();
            PlayTime = null;
            DisableControlsInPanel1();
            EnableControlInPanel2();
            txtbxAccountNumber.Select();
            Status = 0;
            CardNumStart = 0;
            CardNumEnd = 0;
            lstviewPatterListTable.Items.Clear();
            chkbxGameNumber.Checked = false;
            chkbxGameNumber.Enabled = false;
            cmbxGameName.Items.Clear();
            txtbxAccountNumber.Text = string.Empty;
            AccountNumber = 0;

            //cmbxGameName.Items.Clear();
            //SetDisputeResolutionToDefault();
            try
            {
                if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                {
                    FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                }
                else
                {
                    this.Visible = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void cmbxGameNumberStart_Validating(object sender, CancelEventArgs e)
        {
            //check if game number is being selected

            // ComboBox cmbxCurrentSelected = (ComboBox)sender;

            if (chkbxGameNumber.Checked == true)
            {
                //check if the cmbx is not empty
                if (cmbxGameNumberStart.Text == string.Empty) //string.Empty)
                {
                    errorProvider1.SetError(cmbxGameNumberStart, "Start game number can not be emty.");
                    e.Cancel = true;
                }
                else
                {
                    int resultidex = -1;
                    resultidex = cmbxGameNumberStart.FindStringExact(cmbxGameNumberStart.Text);

                    if (resultidex == -1)
                    {
                        errorProvider1.SetError(cmbxGameNumberStart, "The game number doesnt exists.");
                        e.Cancel = true;
                    }

                }

                //check if the input exists

            }
        }

        private void cmbxGameNumberStart_KeyPress(object sender, KeyPressEventArgs e)
        {
            ClearErrorProvider();

            //allow only numeric value
            string keyInput = e.KeyChar.ToString();

            if (Char.IsDigit(e.KeyChar))
            {

            }
            else
                if (e.KeyChar == '\b')
                {

                }
                else
                {
                    e.Handled = true;

                }

        }

        private void cmbxGameNumberEnd_Validating(object sender, CancelEventArgs e)
        {
            if (chkbxGameNumber.Checked == true)
            {
                //check if the cmbx is not empty
                if (cmbxGameNumberEnd.Text == string.Empty) //string.Empty)
                {
                    errorProvider1.SetError(cmbxGameNumberEnd, "Start end number can not be emty.");
                    e.Cancel = true;
                }
                else
                {
                    int resultidex = -1;
                    resultidex = cmbxGameNumberEnd.FindStringExact(cmbxGameNumberEnd.Text);

                    if (resultidex == -1)
                    {
                        errorProvider1.SetError(cmbxGameNumberEnd, "The game number doesnt exists.");
                        e.Cancel = true;
                    }

                }

                //check if the input exists
            }

            //private void cmbxGameNumberEnd_KeyPress(object sender, KeyPressEventArgs e)
            //{
            //    ClearErrorProvider();
            //}      


        }
        #endregion

        #region METHODS

        private void SetFreeBackColor()
        {
            lblBingoCard13.BackColor = Color.LimeGreen;
            lbl2BingoCard13.BackColor = Color.LimeGreen;
            lbl3BingoCard13.BackColor = Color.LimeGreen;
            lbl4BingoCard13.BackColor = Color.LimeGreen;
            lbl5BingoCard13.BackColor = Color.LimeGreen;
            lbl6BingoCard13.BackColor = Color.LimeGreen;
        }



        private void OfferAccepted()
        {
            if (mGetInfo.BonusOfferAccepted == 1)
            {
                label12.Text = "First Offer Accepted";
            }
            else
                if (mGetInfo.BonusOfferAccepted == 2)
                {
                    label12.Text = "Second Offer Accepted";
                }
                else if (mGetInfo.BonusOfferAccepted == 3)
                {
                    label12.Text = "Third Offer Accepted";
                }
                else if (mGetInfo.BonusOfferAccepted == 4)
                {
                    label12.Text = "Final Offer Accepted";
                }
        }

        private void HideCardsIfNotEnable(int NCard)//knc
        {
            if (NCard == 1)
            {
                panel5.Visible = false;
            }
            else if (NCard == 2)
            {
                panel6.Visible = false;
            }
            else if (NCard == 3)
            {
                panel7.Visible = false;
            }
            else if (NCard == 4)
            {
                panel8.Visible = false;
            }
            else if (NCard == 5)
            {
                panel9.Visible = false;
            }
            else if (NCard == 6)
            {
                panel10.Visible = false;
            }

        }

        private void ClearAllTextInCardNumber()
        {
            var c = panel5.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;

            }

            c = panel6.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;
            }

            c = panel7.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;
            }

            c = panel8.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;
            }

            c = panel9.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;
            }

            c = panel10.Controls.OfType<Label>().ToArray();

            foreach (var control in c)
            {
                control.Text = string.Empty;
                control.BackColor = Color.White;
            }
        }


        private void LoadCardTimeBomb(int nCard)
        {
            string NCardDubbed = ",";
            if (nCard == 1)
            {
                lblTimeBombCardr1.Text = gcn.Card_Num_1.ToString(); if (lblTimeBombCardr1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                lblTimeBombCardr2.Text = gcn.Card_Num_2.ToString(); if (lblTimeBombCardr2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                lblTimeBombCardr3.Text = gcn.Card_Num_3.ToString(); if (lblTimeBombCardr3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                lblTimeBombCardr4.Text = gcn.Card_Num_4.ToString(); if (lblTimeBombCardr4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                lblTimeBombCardr5.Text = gcn.Card_Num_5.ToString(); if (lblTimeBombCardr5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                lblTimeBombCardr6.Text = gcn.Card_Num_6.ToString(); if (lblTimeBombCardr6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                lblTimeBombCardr7.Text = gcn.Card_Num_7.ToString(); if (lblTimeBombCardr7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                lblTimeBombCardr8.Text = gcn.Card_Num_8.ToString(); if (lblTimeBombCardr8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                lblTimeBombCardr9.Text = gcn.Card_Num_9.ToString(); if (lblTimeBombCardr9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                lblTimeBombCardr10.Text = gcn.Card_Num_10.ToString(); if (lblTimeBombCardr10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                lblTimeBombCardr11.Text = gcn.Card_Num_11.ToString(); if (lblTimeBombCardr11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                lblTimeBombCardr12.Text = gcn.Card_Num_12.ToString(); if (lblTimeBombCardr12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                lblTimeBombCardr13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                lblTimeBombCardr13.BackColor = Color.LimeGreen;
                NCardDubbed = NCardDubbed + "13,";
                lblTimeBombCardr14.Text = gcn.Card_Num_14.ToString(); if (lblTimeBombCardr14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                lblTimeBombCardr15.Text = gcn.Card_Num_15.ToString(); if (lblTimeBombCardr15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                lblTimeBombCardr16.Text = gcn.Card_Num_16.ToString(); if (lblTimeBombCardr16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                lblTimeBombCardr17.Text = gcn.Card_Num_17.ToString(); if (lblTimeBombCardr17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                lblTimeBombCardr18.Text = gcn.Card_Num_18.ToString(); if (lblTimeBombCardr18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                lblTimeBombCardr19.Text = gcn.Card_Num_19.ToString(); if (lblTimeBombCardr19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                lblTimeBombCardr20.Text = gcn.Card_Num_20.ToString(); if (lblTimeBombCardr20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                lblTimeBombCardr21.Text = gcn.Card_Num_21.ToString(); if (lblTimeBombCardr21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                lblTimeBombCardr22.Text = gcn.Card_Num_22.ToString(); if (lblTimeBombCardr22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                lblTimeBombCardr23.Text = gcn.Card_Num_23.ToString(); if (lblTimeBombCardr23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                lblTimeBombCardr24.Text = gcn.Card_Num_24.ToString(); if (lblTimeBombCardr24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                lblTimeBombCardr25.Text = gcn.Card_Num_25.ToString(); if (lblTimeBombCardr25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
            }
            else
                if (nCard == 2)
                {
                    NCardDubbed = ",";
                    lblTimeBombCardp1.Text = gcn.Card_Num_1.ToString();
                    lblTimeBombCardp2.Text = gcn.Card_Num_2.ToString();
                    lblTimeBombCardp3.Text = gcn.Card_Num_3.ToString();
                    lblTimeBombCardp4.Text = gcn.Card_Num_4.ToString();
                    lblTimeBombCardp5.Text = gcn.Card_Num_5.ToString();
                    lblTimeBombCardp6.Text = gcn.Card_Num_6.ToString();
                    lblTimeBombCardp7.Text = gcn.Card_Num_7.ToString();
                    lblTimeBombCardp8.Text = gcn.Card_Num_8.ToString();
                    lblTimeBombCardp9.Text = gcn.Card_Num_9.ToString();
                    lblTimeBombCardp10.Text = gcn.Card_Num_10.ToString();
                    lblTimeBombCardp11.Text = gcn.Card_Num_11.ToString();
                    lblTimeBombCardp12.Text = gcn.Card_Num_12.ToString();
                    lblTimeBombCardp13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                    //lblTimeBombCardp13.BackColor = Color.LimeGreen;
                    lblTimeBombCardp14.Text = gcn.Card_Num_14.ToString();
                    lblTimeBombCardp15.Text = gcn.Card_Num_15.ToString();
                    lblTimeBombCardp16.Text = gcn.Card_Num_16.ToString();
                    lblTimeBombCardp17.Text = gcn.Card_Num_17.ToString();
                    lblTimeBombCardp18.Text = gcn.Card_Num_18.ToString();
                    lblTimeBombCardp19.Text = gcn.Card_Num_19.ToString();
                    lblTimeBombCardp20.Text = gcn.Card_Num_20.ToString();
                    lblTimeBombCardp21.Text = gcn.Card_Num_21.ToString();
                    lblTimeBombCardp22.Text = gcn.Card_Num_22.ToString();
                    lblTimeBombCardp23.Text = gcn.Card_Num_23.ToString();
                    lblTimeBombCardp24.Text = gcn.Card_Num_24.ToString();
                    lblTimeBombCardp25.Text = gcn.Card_Num_25.ToString();


                    if (lblTimeBombCardp1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                    if (lblTimeBombCardp2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                    if (lblTimeBombCardp3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                    if (lblTimeBombCardp4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                    if (lblTimeBombCardp5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                    if (lblTimeBombCardp6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                    if (lblTimeBombCardp7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                    if (lblTimeBombCardp8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                    if (lblTimeBombCardp9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                    if (lblTimeBombCardp10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                    if (lblTimeBombCardp11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                    if (lblTimeBombCardp12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                    lblTimeBombCardp13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                    lblTimeBombCardp13.BackColor = Color.LimeGreen;
                    NCardDubbed = NCardDubbed + "13,";
                    if (lblTimeBombCardp14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                    if (lblTimeBombCardp15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                    if (lblTimeBombCardp16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                    if (lblTimeBombCardp17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                    if (lblTimeBombCardp18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                    if (lblTimeBombCardp19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                    if (lblTimeBombCardp20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                    if (lblTimeBombCardp21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                    if (lblTimeBombCardp22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                    if (lblTimeBombCardp23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                    if (lblTimeBombCardp24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                    if (lblTimeBombCardp25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }



                }
                else
                    if (nCard == 3)
                    {
                        NCardDubbed = ",";
                        lblTimeBombCardg1.Text = gcn.Card_Num_1.ToString();
                        lblTimeBombCardg2.Text = gcn.Card_Num_2.ToString();
                        lblTimeBombCardg3.Text = gcn.Card_Num_3.ToString();
                        lblTimeBombCardg4.Text = gcn.Card_Num_4.ToString();
                        lblTimeBombCardg5.Text = gcn.Card_Num_5.ToString();
                        lblTimeBombCardg6.Text = gcn.Card_Num_6.ToString();
                        lblTimeBombCardg7.Text = gcn.Card_Num_7.ToString();
                        lblTimeBombCardg8.Text = gcn.Card_Num_8.ToString();
                        lblTimeBombCardg9.Text = gcn.Card_Num_9.ToString();
                        lblTimeBombCardg10.Text = gcn.Card_Num_10.ToString();
                        lblTimeBombCardg11.Text = gcn.Card_Num_11.ToString();
                        lblTimeBombCardg12.Text = gcn.Card_Num_12.ToString();
                        lblTimeBombCardg13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                        //lblTimeBombCardg13.BackColor = Color.LimeGreen;
                        lblTimeBombCardg14.Text = gcn.Card_Num_14.ToString();
                        lblTimeBombCardg15.Text = gcn.Card_Num_15.ToString();
                        lblTimeBombCardg16.Text = gcn.Card_Num_16.ToString();
                        lblTimeBombCardg17.Text = gcn.Card_Num_17.ToString();
                        lblTimeBombCardg18.Text = gcn.Card_Num_18.ToString();
                        lblTimeBombCardg19.Text = gcn.Card_Num_19.ToString();
                        lblTimeBombCardg20.Text = gcn.Card_Num_20.ToString();
                        lblTimeBombCardg21.Text = gcn.Card_Num_21.ToString();
                        lblTimeBombCardg22.Text = gcn.Card_Num_22.ToString();
                        lblTimeBombCardg23.Text = gcn.Card_Num_23.ToString();
                        lblTimeBombCardg24.Text = gcn.Card_Num_24.ToString();
                        lblTimeBombCardg25.Text = gcn.Card_Num_25.ToString();

                        if (lblTimeBombCardg1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                        if (lblTimeBombCardg2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                        if (lblTimeBombCardg3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                        if (lblTimeBombCardg4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                        if (lblTimeBombCardg5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                        if (lblTimeBombCardg6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                        if (lblTimeBombCardg7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                        if (lblTimeBombCardg8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                        if (lblTimeBombCardg9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                        if (lblTimeBombCardg10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                        if (lblTimeBombCardg11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                        if (lblTimeBombCardg12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                        lblTimeBombCardg13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                        lblTimeBombCardg13.BackColor = Color.LimeGreen;
                        NCardDubbed = NCardDubbed + "13,";
                        if (lblTimeBombCardg14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                        if (lblTimeBombCardg15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                        if (lblTimeBombCardg16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                        if (lblTimeBombCardg17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                        if (lblTimeBombCardg18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                        if (lblTimeBombCardg19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                        if (lblTimeBombCardg20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                        if (lblTimeBombCardg21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                        if (lblTimeBombCardg22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                        if (lblTimeBombCardg23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                        if (lblTimeBombCardg24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                        if (lblTimeBombCardg25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }



                    }
                    else
                        if (nCard == 4)
                        {
                            NCardDubbed = ",";
                            lblTimeBombCardb1.Text = gcn.Card_Num_1.ToString();
                            lblTimeBombCardb2.Text = gcn.Card_Num_2.ToString();
                            lblTimeBombCardb3.Text = gcn.Card_Num_3.ToString();
                            lblTimeBombCardb4.Text = gcn.Card_Num_4.ToString();
                            lblTimeBombCardb5.Text = gcn.Card_Num_5.ToString();
                            lblTimeBombCardb6.Text = gcn.Card_Num_6.ToString();
                            lblTimeBombCardb7.Text = gcn.Card_Num_7.ToString();
                            lblTimeBombCardb8.Text = gcn.Card_Num_8.ToString();
                            lblTimeBombCardb9.Text = gcn.Card_Num_9.ToString();
                            lblTimeBombCardb10.Text = gcn.Card_Num_10.ToString();
                            lblTimeBombCardb11.Text = gcn.Card_Num_11.ToString();
                            lblTimeBombCardb12.Text = gcn.Card_Num_12.ToString();
                            lblTimeBombCardb13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                            //lblTimeBombCardb13.BackColor = Color.LimeGreen;
                            lblTimeBombCardb14.Text = gcn.Card_Num_14.ToString();
                            lblTimeBombCardb15.Text = gcn.Card_Num_15.ToString();
                            lblTimeBombCardb16.Text = gcn.Card_Num_16.ToString();
                            lblTimeBombCardb17.Text = gcn.Card_Num_17.ToString();
                            lblTimeBombCardb18.Text = gcn.Card_Num_18.ToString();
                            lblTimeBombCardb19.Text = gcn.Card_Num_19.ToString();
                            lblTimeBombCardb20.Text = gcn.Card_Num_20.ToString();
                            lblTimeBombCardb21.Text = gcn.Card_Num_21.ToString();
                            lblTimeBombCardb22.Text = gcn.Card_Num_22.ToString();
                            lblTimeBombCardb23.Text = gcn.Card_Num_23.ToString();
                            lblTimeBombCardb24.Text = gcn.Card_Num_24.ToString();
                            lblTimeBombCardb25.Text = gcn.Card_Num_25.ToString();

                            if (lblTimeBombCardb1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                            if (lblTimeBombCardb2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                            if (lblTimeBombCardb3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                            if (lblTimeBombCardb4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                            if (lblTimeBombCardb5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                            if (lblTimeBombCardb6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                            if (lblTimeBombCardb7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                            if (lblTimeBombCardb8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                            if (lblTimeBombCardb9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                            if (lblTimeBombCardb10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                            if (lblTimeBombCardb11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                            if (lblTimeBombCardb12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                            lblTimeBombCardb13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                            lblTimeBombCardb13.BackColor = Color.LimeGreen;
                            NCardDubbed = NCardDubbed + "13,";
                            if (lblTimeBombCardb14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                            if (lblTimeBombCardb15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                            if (lblTimeBombCardb16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                            if (lblTimeBombCardb17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                            if (lblTimeBombCardb18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                            if (lblTimeBombCardb19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                            if (lblTimeBombCardb20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                            if (lblTimeBombCardb21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                            if (lblTimeBombCardb22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                            if (lblTimeBombCardb23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                            if (lblTimeBombCardb24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                            if (lblTimeBombCardb25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                        }
                        else
                            if (nCard == 5)
                            {
                                NCardDubbed = ",";
                                lblTimeBombCardrb1.Text = gcn.Card_Num_1.ToString(); if (lblTimeBombCardrb1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                lblTimeBombCardrb2.Text = gcn.Card_Num_2.ToString(); if (lblTimeBombCardrb2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                lblTimeBombCardrb3.Text = gcn.Card_Num_3.ToString(); if (lblTimeBombCardrb3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                lblTimeBombCardrb4.Text = gcn.Card_Num_4.ToString(); if (lblTimeBombCardrb4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                lblTimeBombCardrb5.Text = gcn.Card_Num_5.ToString(); if (lblTimeBombCardrb5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                lblTimeBombCardrb6.Text = gcn.Card_Num_6.ToString(); if (lblTimeBombCardrb6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                lblTimeBombCardrb7.Text = gcn.Card_Num_7.ToString(); if (lblTimeBombCardrb7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                lblTimeBombCardrb8.Text = gcn.Card_Num_8.ToString(); if (lblTimeBombCardrb8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                lblTimeBombCardrb9.Text = gcn.Card_Num_9.ToString(); if (lblTimeBombCardrb9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                lblTimeBombCardrb10.Text = gcn.Card_Num_10.ToString(); if (lblTimeBombCardrb10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                lblTimeBombCardrb11.Text = gcn.Card_Num_11.ToString(); if (lblTimeBombCardrb11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                lblTimeBombCardrb12.Text = gcn.Card_Num_12.ToString(); if (lblTimeBombCardrb12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                lblTimeBombCardrb13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                                lblTimeBombCardrb13.BackColor = Color.LimeGreen; 
                                NCardDubbed = NCardDubbed + "13,";
                                lblTimeBombCardrb14.Text = gcn.Card_Num_14.ToString(); if (lblTimeBombCardrb14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                lblTimeBombCardrb15.Text = gcn.Card_Num_15.ToString(); if (lblTimeBombCardrb15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                lblTimeBombCardrb16.Text = gcn.Card_Num_16.ToString(); if (lblTimeBombCardrb16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                lblTimeBombCardrb17.Text = gcn.Card_Num_17.ToString(); if (lblTimeBombCardrb17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                lblTimeBombCardrb18.Text = gcn.Card_Num_18.ToString(); if (lblTimeBombCardrb18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                lblTimeBombCardrb19.Text = gcn.Card_Num_19.ToString(); if (lblTimeBombCardrb19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                lblTimeBombCardrb20.Text = gcn.Card_Num_20.ToString(); if (lblTimeBombCardrb20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                lblTimeBombCardrb21.Text = gcn.Card_Num_21.ToString(); if (lblTimeBombCardrb21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                lblTimeBombCardrb22.Text = gcn.Card_Num_22.ToString(); if (lblTimeBombCardrb22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                lblTimeBombCardrb23.Text = gcn.Card_Num_23.ToString(); if (lblTimeBombCardrb23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                lblTimeBombCardrb24.Text = gcn.Card_Num_24.ToString(); if (lblTimeBombCardrb24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                lblTimeBombCardrb25.Text = gcn.Card_Num_25.ToString(); if (lblTimeBombCardrb25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                            }
                            else
                                if (nCard == 6)
                                {
                                    NCardDubbed = ",";
                                    lblTimeBombCardpb1.Text = gcn.Card_Num_1.ToString();
                                    lblTimeBombCardpb2.Text = gcn.Card_Num_2.ToString();
                                    lblTimeBombCardpb3.Text = gcn.Card_Num_3.ToString();
                                    lblTimeBombCardpb4.Text = gcn.Card_Num_4.ToString();
                                    lblTimeBombCardpb5.Text = gcn.Card_Num_5.ToString();
                                    lblTimeBombCardpb6.Text = gcn.Card_Num_6.ToString();
                                    lblTimeBombCardpb7.Text = gcn.Card_Num_7.ToString();
                                    lblTimeBombCardpb8.Text = gcn.Card_Num_8.ToString();
                                    lblTimeBombCardpb9.Text = gcn.Card_Num_9.ToString();
                                    lblTimeBombCardpb10.Text = gcn.Card_Num_10.ToString();
                                    lblTimeBombCardpb11.Text = gcn.Card_Num_11.ToString();
                                    lblTimeBombCardpb12.Text = gcn.Card_Num_12.ToString();
                                    lblTimeBombCardpb13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                                    //lblTimeBombCardpb13.BackColor = Color.LimeGreen;
                                    lblTimeBombCardpb14.Text = gcn.Card_Num_14.ToString();
                                    lblTimeBombCardpb15.Text = gcn.Card_Num_15.ToString();
                                    lblTimeBombCardpb16.Text = gcn.Card_Num_16.ToString();
                                    lblTimeBombCardpb17.Text = gcn.Card_Num_17.ToString();
                                    lblTimeBombCardpb18.Text = gcn.Card_Num_18.ToString();
                                    lblTimeBombCardpb19.Text = gcn.Card_Num_19.ToString();
                                    lblTimeBombCardpb20.Text = gcn.Card_Num_20.ToString();
                                    lblTimeBombCardpb21.Text = gcn.Card_Num_21.ToString();
                                    lblTimeBombCardpb22.Text = gcn.Card_Num_22.ToString();
                                    lblTimeBombCardpb23.Text = gcn.Card_Num_23.ToString();
                                    lblTimeBombCardpb24.Text = gcn.Card_Num_24.ToString();
                                    lblTimeBombCardpb25.Text = gcn.Card_Num_25.ToString();


                                    if (lblTimeBombCardpb1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                    if (lblTimeBombCardpb2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                    if (lblTimeBombCardpb3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                    if (lblTimeBombCardpb4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                    if (lblTimeBombCardpb5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                    if (lblTimeBombCardpb6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                    if (lblTimeBombCardpb7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                    if (lblTimeBombCardpb8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                    if (lblTimeBombCardpb9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                    if (lblTimeBombCardpb10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                    if (lblTimeBombCardpb11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                    if (lblTimeBombCardpb12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                    lblTimeBombCardpb13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                                    lblTimeBombCardpb13.BackColor = Color.LimeGreen; 
                                    NCardDubbed = NCardDubbed + "13,";
                                    if (lblTimeBombCardpb14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                    if (lblTimeBombCardpb15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                    if (lblTimeBombCardpb16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                    if (lblTimeBombCardpb17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                    if (lblTimeBombCardpb18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                    if (lblTimeBombCardpb19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                    if (lblTimeBombCardpb20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                    if (lblTimeBombCardpb21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                    if (lblTimeBombCardpb22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                    if (lblTimeBombCardpb23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                    if (lblTimeBombCardpb24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                    if (lblTimeBombCardpb25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                                }
                                else
                                    if (nCard == 7)
                                    {
                                        NCardDubbed = ",";
                                        lblTimeBombCardgb1.Text = gcn.Card_Num_1.ToString();
                                        lblTimeBombCardgb2.Text = gcn.Card_Num_2.ToString();
                                        lblTimeBombCardgb3.Text = gcn.Card_Num_3.ToString();
                                        lblTimeBombCardgb4.Text = gcn.Card_Num_4.ToString();
                                        lblTimeBombCardgb5.Text = gcn.Card_Num_5.ToString();
                                        lblTimeBombCardgb6.Text = gcn.Card_Num_6.ToString();
                                        lblTimeBombCardgb7.Text = gcn.Card_Num_7.ToString();
                                        lblTimeBombCardgb8.Text = gcn.Card_Num_8.ToString();
                                        lblTimeBombCardgb9.Text = gcn.Card_Num_9.ToString();
                                        lblTimeBombCardgb10.Text = gcn.Card_Num_10.ToString();
                                        lblTimeBombCardgb11.Text = gcn.Card_Num_11.ToString();
                                        lblTimeBombCardgb12.Text = gcn.Card_Num_12.ToString();
                                        lblTimeBombCardgb13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                                        //lblTimeBombCardgb13.BackColor = Color.LimeGreen;
                                        lblTimeBombCardgb14.Text = gcn.Card_Num_14.ToString();
                                        lblTimeBombCardgb15.Text = gcn.Card_Num_15.ToString();
                                        lblTimeBombCardgb16.Text = gcn.Card_Num_16.ToString();
                                        lblTimeBombCardgb17.Text = gcn.Card_Num_17.ToString();
                                        lblTimeBombCardgb18.Text = gcn.Card_Num_18.ToString();
                                        lblTimeBombCardgb19.Text = gcn.Card_Num_19.ToString();
                                        lblTimeBombCardgb20.Text = gcn.Card_Num_20.ToString();
                                        lblTimeBombCardgb21.Text = gcn.Card_Num_21.ToString();
                                        lblTimeBombCardgb22.Text = gcn.Card_Num_22.ToString();
                                        lblTimeBombCardgb23.Text = gcn.Card_Num_23.ToString();
                                        lblTimeBombCardgb24.Text = gcn.Card_Num_24.ToString();
                                        lblTimeBombCardgb25.Text = gcn.Card_Num_25.ToString();

                                        if (lblTimeBombCardgb1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                        if (lblTimeBombCardgb2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                        if (lblTimeBombCardgb3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                        if (lblTimeBombCardgb4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                        if (lblTimeBombCardgb5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                        if (lblTimeBombCardgb6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                        if (lblTimeBombCardgb7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                        if (lblTimeBombCardgb8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                        if (lblTimeBombCardgb9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                        if (lblTimeBombCardgb10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                        if (lblTimeBombCardgb11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                        if (lblTimeBombCardgb12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                        lblTimeBombCardgb13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                                         lblTimeBombCardgb13.BackColor = Color.LimeGreen; 
                                        NCardDubbed = NCardDubbed + "13,";
                                        if (lblTimeBombCardgb14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                        if (lblTimeBombCardgb15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                        if (lblTimeBombCardgb16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                        if (lblTimeBombCardgb17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                        if (lblTimeBombCardgb18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                        if (lblTimeBombCardgb19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                        if (lblTimeBombCardgb20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                        if (lblTimeBombCardgb21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                        if (lblTimeBombCardgb22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                        if (lblTimeBombCardgb23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                        if (lblTimeBombCardgb24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                        if (lblTimeBombCardgb25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                                    }
                                    else
                                        if (nCard == 8)
                                        {
                                            NCardDubbed = ",";
                                            lblTimeBombCardbb1.Text = gcn.Card_Num_1.ToString();
                                            lblTimeBombCardbb2.Text = gcn.Card_Num_2.ToString();
                                            lblTimeBombCardbb3.Text = gcn.Card_Num_3.ToString();
                                            lblTimeBombCardbb4.Text = gcn.Card_Num_4.ToString();
                                            lblTimeBombCardbb5.Text = gcn.Card_Num_5.ToString();
                                            lblTimeBombCardbb6.Text = gcn.Card_Num_6.ToString();
                                            lblTimeBombCardbb7.Text = gcn.Card_Num_7.ToString();
                                            lblTimeBombCardbb8.Text = gcn.Card_Num_8.ToString();
                                            lblTimeBombCardbb9.Text = gcn.Card_Num_9.ToString();
                                            lblTimeBombCardbb10.Text = gcn.Card_Num_10.ToString();
                                            lblTimeBombCardbb11.Text = gcn.Card_Num_11.ToString();
                                            lblTimeBombCardbb12.Text = gcn.Card_Num_12.ToString();
                                            lblTimeBombCardbb13.Text = "Fr"; //gcn.Card_Num_13.ToString();
                                            //lblTimeBombCardbb13.BackColor = Color.LimeGreen;
                                            lblTimeBombCardbb14.Text = gcn.Card_Num_14.ToString();
                                            lblTimeBombCardbb15.Text = gcn.Card_Num_15.ToString();
                                            lblTimeBombCardbb16.Text = gcn.Card_Num_16.ToString();
                                            lblTimeBombCardbb17.Text = gcn.Card_Num_17.ToString();
                                            lblTimeBombCardbb18.Text = gcn.Card_Num_18.ToString();
                                            lblTimeBombCardbb19.Text = gcn.Card_Num_19.ToString();
                                            lblTimeBombCardbb20.Text = gcn.Card_Num_20.ToString();
                                            lblTimeBombCardbb21.Text = gcn.Card_Num_21.ToString();
                                            lblTimeBombCardbb22.Text = gcn.Card_Num_22.ToString();
                                            lblTimeBombCardbb23.Text = gcn.Card_Num_23.ToString();
                                            lblTimeBombCardbb24.Text = gcn.Card_Num_24.ToString();
                                            lblTimeBombCardbb25.Text = gcn.Card_Num_25.ToString();

                                            if (lblTimeBombCardbb1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                            if (lblTimeBombCardbb2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                            if (lblTimeBombCardbb3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                            if (lblTimeBombCardbb4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                            if (lblTimeBombCardbb5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                            if (lblTimeBombCardbb6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                            if (lblTimeBombCardbb7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                            if (lblTimeBombCardbb8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                            if (lblTimeBombCardbb9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                            if (lblTimeBombCardbb10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                            if (lblTimeBombCardbb11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                            if (lblTimeBombCardbb12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                            lblTimeBombCardbb13.Text = "Fr"; //gcn.Card_Num_13.ToString(); t
                                             lblTimeBombCardbb13.BackColor = Color.LimeGreen; 
                                            //NCardDubbed = NCardDubbed + "13,";
                                            if (lblTimeBombCardbb14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                            if (lblTimeBombCardbb15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                            if (lblTimeBombCardbb16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                            if (lblTimeBombCardbb17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                            if (lblTimeBombCardbb18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                            if (lblTimeBombCardbb19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                            if (lblTimeBombCardbb20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                            if (lblTimeBombCardbb21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                            if (lblTimeBombCardbb22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                            if (lblTimeBombCardbb23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                            if (lblTimeBombCardbb24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                            if (lblTimeBombCardbb25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                                        }
        }


        private void LoadCard(int nCard)
        {

            string NCardDubbed = ",";
            if (nCard == 1)
            {
                panel5.Visible = true;
                lblBingoCard1.Text = GetCardNumber.Card_Num_1.ToString(); if (lblBingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                lblBingoCard2.Text = GetCardNumber.Card_Num_2.ToString(); if (lblBingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                lblBingoCard3.Text = GetCardNumber.Card_Num_3.ToString(); if (lblBingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                lblBingoCard4.Text = GetCardNumber.Card_Num_4.ToString(); if (lblBingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                lblBingoCard5.Text = GetCardNumber.Card_Num_5.ToString(); if (lblBingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                lblBingoCard6.Text = GetCardNumber.Card_Num_6.ToString(); if (lblBingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                lblBingoCard7.Text = GetCardNumber.Card_Num_7.ToString(); if (lblBingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                lblBingoCard8.Text = GetCardNumber.Card_Num_8.ToString(); if (lblBingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                lblBingoCard9.Text = GetCardNumber.Card_Num_9.ToString(); if (lblBingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                lblBingoCard10.Text = GetCardNumber.Card_Num_10.ToString(); if (lblBingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                lblBingoCard11.Text = GetCardNumber.Card_Num_11.ToString(); if (lblBingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                lblBingoCard12.Text = GetCardNumber.Card_Num_12.ToString(); if (lblBingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                lblBingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                lblBingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                lblBingoCard14.Text = GetCardNumber.Card_Num_14.ToString(); if (lblBingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                lblBingoCard15.Text = GetCardNumber.Card_Num_15.ToString(); if (lblBingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                lblBingoCard16.Text = GetCardNumber.Card_Num_16.ToString(); if (lblBingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                lblBingoCard17.Text = GetCardNumber.Card_Num_17.ToString(); if (lblBingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                lblBingoCard18.Text = GetCardNumber.Card_Num_18.ToString(); if (lblBingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                lblBingoCard19.Text = GetCardNumber.Card_Num_19.ToString(); if (lblBingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                lblBingoCard20.Text = GetCardNumber.Card_Num_20.ToString(); if (lblBingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                lblBingoCard21.Text = GetCardNumber.Card_Num_21.ToString(); if (lblBingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                lblBingoCard22.Text = GetCardNumber.Card_Num_22.ToString(); if (lblBingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                lblBingoCard23.Text = GetCardNumber.Card_Num_23.ToString(); if (lblBingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                lblBingoCard24.Text = GetCardNumber.Card_Num_24.ToString(); if (lblBingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                lblBingoCard25.Text = GetCardNumber.Card_Num_25.ToString(); if (lblBingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
            }
            else
                if (nCard == 2)
                {
                    NCardDubbed = ",";
                    panel6.Visible = true;
                    lbl2BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                    lbl2BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                    lbl2BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                    lbl2BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                    lbl2BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                    lbl2BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                    lbl2BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                    lbl2BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                    lbl2BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                    lbl2BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                    lbl2BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                    lbl2BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                    lbl2BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                    lbl2BingoCard13.BackColor = Color.LimeGreen;
                    lbl2BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                    lbl2BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                    lbl2BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                    lbl2BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                    lbl2BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                    lbl2BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                    lbl2BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                    lbl2BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                    lbl2BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                    lbl2BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                    lbl2BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                    lbl2BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();


                    if (lbl2BingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                    if (lbl2BingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                    if (lbl2BingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                    if (lbl2BingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                    if (lbl2BingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                    if (lbl2BingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                    if (lbl2BingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                    if (lbl2BingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                    if (lbl2BingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                    if (lbl2BingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                    if (lbl2BingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                    if (lbl2BingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                    lbl2BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                    lbl2BingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                    if (lbl2BingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                    if (lbl2BingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                    if (lbl2BingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                    if (lbl2BingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                    if (lbl2BingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                    if (lbl2BingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                    if (lbl2BingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                    if (lbl2BingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                    if (lbl2BingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                    if (lbl2BingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                    if (lbl2BingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                    if (lbl2BingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }

                }
                else
                    if (nCard == 3)
                    {
                        NCardDubbed = ",";
                        panel7.Visible = true;
                        lbl3BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                        lbl3BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                        lbl3BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                        lbl3BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                        lbl3BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                        lbl3BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                        lbl3BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                        lbl3BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                        lbl3BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                        lbl3BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                        lbl3BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                        lbl3BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                        lbl3BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                        lbl3BingoCard13.BackColor = Color.LimeGreen;
                        lbl3BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                        lbl3BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                        lbl3BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                        lbl3BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                        lbl3BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                        lbl3BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                        lbl3BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                        lbl3BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                        lbl3BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                        lbl3BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                        lbl3BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                        lbl3BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();

                        if (lbl3BingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                        if (lbl3BingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                        if (lbl3BingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                        if (lbl3BingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                        if (lbl3BingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                        if (lbl3BingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                        if (lbl3BingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                        if (lbl3BingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                        if (lbl3BingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                        if (lbl3BingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                        if (lbl3BingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                        if (lbl3BingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                        lbl3BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                        lbl3BingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                        if (lbl3BingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                        if (lbl3BingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                        if (lbl3BingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                        if (lbl3BingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                        if (lbl3BingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                        if (lbl3BingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                        if (lbl3BingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                        if (lbl3BingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                        if (lbl3BingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                        if (lbl3BingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                        if (lbl3BingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                        if (lbl3BingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                      
                    }
                    else
                        if (nCard == 4)
                        {
                            NCardDubbed = ",";
                            panel8.Visible = true;
                            lbl4BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                            lbl4BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                            lbl4BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                            lbl4BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                            lbl4BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                            lbl4BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                            lbl4BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                            lbl4BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                            lbl4BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                            lbl4BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                            lbl4BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                            lbl4BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                            lbl4BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                            lbl4BingoCard13.BackColor = Color.LimeGreen;
                            lbl4BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                            lbl4BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                            lbl4BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                            lbl4BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                            lbl4BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                            lbl4BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                            lbl4BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                            lbl4BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                            lbl4BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                            lbl4BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                            lbl4BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                            lbl4BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();

                            if (lbl4BingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                            if (lbl4BingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                            if (lbl4BingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                            if (lbl4BingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                            if (lbl4BingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                            if (lbl4BingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                            if (lbl4BingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                            if (lbl4BingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                            if (lbl4BingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                            if (lbl4BingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                            if (lbl4BingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                            if (lbl4BingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                            lbl4BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                            lbl4BingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                            if (lbl4BingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                            if (lbl4BingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                            if (lbl4BingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                            if (lbl4BingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                            if (lbl4BingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                            if (lbl4BingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                            if (lbl4BingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                            if (lbl4BingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                            if (lbl4BingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                            if (lbl4BingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                            if (lbl4BingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                            if (lbl4BingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                         
                        }
                        else
                            if (nCard == 5)
                            {
                                NCardDubbed = ",";
                                panel9.Visible = true;
                                lbl5BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                lbl5BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                lbl5BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                lbl5BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                lbl5BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                lbl5BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                lbl5BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                lbl5BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                lbl5BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                lbl5BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                lbl5BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                lbl5BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                lbl5BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                lbl5BingoCard13.BackColor = Color.LimeGreen;
                                lbl5BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                lbl5BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                lbl5BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                lbl5BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                lbl5BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                lbl5BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                lbl5BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                lbl5BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                lbl5BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                lbl5BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                lbl5BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                lbl5BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();

                                if (lbl5BingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                if (lbl5BingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                if (lbl5BingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                if (lbl5BingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                if (lbl5BingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                if (lbl5BingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                if (lbl5BingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                if (lbl5BingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                if (lbl5BingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                if (lbl5BingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                if (lbl5BingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                if (lbl5BingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                lbl5BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                                lbl5BingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                                if (lbl5BingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                if (lbl5BingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                if (lbl5BingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                if (lbl5BingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                if (lbl5BingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                if (lbl5BingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                if (lbl5BingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                if (lbl5BingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                if (lbl5BingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                if (lbl5BingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                if (lbl5BingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                if (lbl5BingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                        
                            }
                            else
                                if (nCard == 6)
                                {
                                    NCardDubbed = ",";
                                    panel10.Visible = true;
                                    lbl6BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                    lbl6BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                    lbl6BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                    lbl6BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                    lbl6BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                    lbl6BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                    lbl6BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                    lbl6BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                    lbl6BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                    lbl6BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                    lbl6BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                    lbl6BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                    lbl6BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                    lbl6BingoCard13.BackColor = Color.LimeGreen;
                                    lbl6BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                    lbl6BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                    lbl6BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                    lbl6BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                    lbl6BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                    lbl6BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                    lbl6BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                    lbl6BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                    lbl6BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                    lbl6BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                    lbl6BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                    lbl6BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();

                                    if (lbl6BingoCard1.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "1,"; }
                                    if (lbl6BingoCard2.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "2,"; }
                                    if (lbl6BingoCard3.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "3,"; }
                                    if (lbl6BingoCard4.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "4,"; }
                                    if (lbl6BingoCard5.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "5,"; }
                                    if (lbl6BingoCard6.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "6,"; }
                                    if (lbl6BingoCard7.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "7,"; }
                                    if (lbl6BingoCard8.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "8,"; }
                                    if (lbl6BingoCard9.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "9,"; }
                                    if (lbl6BingoCard10.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "10,"; }
                                    if (lbl6BingoCard11.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "11,"; }
                                    if (lbl6BingoCard12.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "12,"; }
                                    lbl6BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString(); t
                                    lbl6BingoCard13.BackColor = Color.LimeGreen; NCardDubbed = NCardDubbed + "13,";
                                    if (lbl6BingoCard14.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "14,"; }
                                    if (lbl6BingoCard15.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "15,"; }
                                    if (lbl6BingoCard16.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "16,"; }
                                    if (lbl6BingoCard17.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "17,"; }
                                    if (lbl6BingoCard18.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "18,"; }
                                    if (lbl6BingoCard19.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "19,"; }
                                    if (lbl6BingoCard20.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "20,"; }
                                    if (lbl6BingoCard21.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "21,"; }
                                    if (lbl6BingoCard22.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "22,"; }
                                    if (lbl6BingoCard23.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "23,"; }
                                    if (lbl6BingoCard24.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "24,"; }
                                    if (lbl6BingoCard25.BackColor.ToArgb() == -13447886) { NCardDubbed = NCardDubbed + "25,"; }
                                }
                                else
                                    if (nCard == 7)
                                    {

                                        lbl7BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                        lbl7BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                        lbl7BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                        lbl7BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                        lbl7BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                        lbl7BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                        lbl7BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                        lbl7BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                        lbl7BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                        lbl7BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                        lbl7BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                        lbl7BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                        lbl7BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                        lbl7BingoCard13.BackColor = Color.LimeGreen;
                                        lbl7BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                        lbl7BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                        lbl7BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                        lbl7BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                        lbl7BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                        lbl7BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                        lbl7BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                        lbl7BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                        lbl7BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                        lbl7BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                        lbl7BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                        lbl7BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();
                                    }
                                    else
                                        if (nCard == 8)
                                        {
                                            lbl8BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                            lbl8BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                            lbl8BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                            lbl8BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                            lbl8BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                            lbl8BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                            lbl8BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                            lbl8BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                            lbl8BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                            lbl8BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                            lbl8BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                            lbl8BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                            lbl8BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                            lbl8BingoCard13.BackColor = Color.LimeGreen;
                                            lbl8BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                            lbl8BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                            lbl8BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                            lbl8BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                            lbl8BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                            lbl8BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                            lbl8BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                            lbl8BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                            lbl8BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                            lbl8BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                            lbl8BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                            lbl8BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();
                                        }
                                        else
                                            if (nCard == 9)
                                            {
                                                lbl9BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                                lbl9BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                                lbl9BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                                lbl9BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                                lbl9BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                                lbl9BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                                lbl9BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                                lbl9BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                                lbl9BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                                lbl9BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                                lbl9BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                                lbl9BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                                lbl9BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                                lbl9BingoCard13.BackColor = Color.LimeGreen;
                                                lbl9BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                                lbl9BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                                lbl9BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                                lbl9BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                                lbl9BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                                lbl9BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                                lbl9BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                                lbl9BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                                lbl9BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                                lbl9BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                                lbl9BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                                lbl9BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();
                                            }
                                            else
                                                if (nCard == 10)
                                                {
                                                    lbl10BingoCard1.Text = GetCardNumber.Card_Num_1.ToString();
                                                    lbl10BingoCard2.Text = GetCardNumber.Card_Num_2.ToString();
                                                    lbl10BingoCard3.Text = GetCardNumber.Card_Num_3.ToString();
                                                    lbl10BingoCard4.Text = GetCardNumber.Card_Num_4.ToString();
                                                    lbl10BingoCard5.Text = GetCardNumber.Card_Num_5.ToString();
                                                    lbl10BingoCard6.Text = GetCardNumber.Card_Num_6.ToString();
                                                    lbl10BingoCard7.Text = GetCardNumber.Card_Num_7.ToString();
                                                    lbl10BingoCard8.Text = GetCardNumber.Card_Num_8.ToString();
                                                    lbl10BingoCard9.Text = GetCardNumber.Card_Num_9.ToString();
                                                    lbl10BingoCard10.Text = GetCardNumber.Card_Num_10.ToString();
                                                    lbl10BingoCard11.Text = GetCardNumber.Card_Num_11.ToString();
                                                    lbl10BingoCard12.Text = GetCardNumber.Card_Num_12.ToString();
                                                    lbl10BingoCard13.Text = "Free"; //GetCardNumber.Card_Num_13.ToString();
                                                    lbl10BingoCard13.BackColor = Color.LimeGreen;
                                                    lbl10BingoCard14.Text = GetCardNumber.Card_Num_14.ToString();
                                                    lbl10BingoCard15.Text = GetCardNumber.Card_Num_15.ToString();
                                                    lbl10BingoCard16.Text = GetCardNumber.Card_Num_16.ToString();
                                                    lbl10BingoCard17.Text = GetCardNumber.Card_Num_17.ToString();
                                                    lbl10BingoCard18.Text = GetCardNumber.Card_Num_18.ToString();
                                                    lbl10BingoCard19.Text = GetCardNumber.Card_Num_19.ToString();
                                                    lbl10BingoCard20.Text = GetCardNumber.Card_Num_20.ToString();
                                                    lbl10BingoCard21.Text = GetCardNumber.Card_Num_21.ToString();
                                                    lbl10BingoCard22.Text = GetCardNumber.Card_Num_22.ToString();
                                                    lbl10BingoCard23.Text = GetCardNumber.Card_Num_23.ToString();
                                                    lbl10BingoCard24.Text = GetCardNumber.Card_Num_24.ToString();
                                                    lbl10BingoCard25.Text = GetCardNumber.Card_Num_25.ToString();
                                                }
        }

        private DateTime? SaveDate;
        GetCardNumber2 gcn;

        private void HideLabelNumber(Panel pnl, bool Value)
        {
            var c = pnl.Controls.OfType<Label>().ToArray();
            foreach (var control in c)
            {
                if (control.Visible != Value)
                {
                    control.Visible = Value;
                }
                else
                {
                    break;
                }
            }
        }

        private void AddCardLabelEvent(Panel pnl)
        {
            var c = pnl.Controls.OfType<Label>().ToArray();
            foreach (var control in c)
            {
                //control.TextChanged += new EventArgs();
                control.TextChanged += new EventHandler(lblBingoCard1_TextChanged);
            }
        }

        private void RemovedCardLabelEvent(Panel pnl)
        {
            var c = pnl.Controls.OfType<Label>().ToArray();
            foreach (var control in c)
            {
                //control.TextChanged += new EventArgs();
                control.TextChanged -= new EventHandler(lblBingoCard1_TextChanged);
            }
        }


        private void GetInfoALL()
        {
            if (groupBox1.Visible == false)//grpInfo
            {
                groupBox1.Visible = true;
            }

            if (SpiritBR != false)
            {
                SpiritBR = false;
            }

            if (MayaMoneyPattern != string.Empty)
            { MayaMoneyPattern = ""; };

            if (cmbxGameName.SelectedIndex == -1 || cmbxGameName.SelectedItem.ToString() == "All")
            {
                SelectedB4Game = "";
            }

            string IsGameNumber = "";

            if (chkbxGameNumber.Checked == true)
            {
                IsGameNumber = "T";
            }
            else
            {
                IsGameNumber = "F";
            }

            mGetInfo = new GetInfo(AccountNumber, PlayTime, Status, SelectedB4Game, GameNumStart, GameNumEnd, IsGameNumber);

            if (mGetInfo.DateTimePlay != null)
            {
                SaveDate = mGetInfo.DateTimePlay;
            }

            if (PlayTime != SaveDate)
            {
                PlayTime = mGetInfo.DateTimePlay;
                if (lblMessageLastGameReach.Visible != false)
                {
                    lblMessageLastGameReach.Visible = false;
                }

                if (checkBox1.Checked != false)
                {
                    checkBox1.Checked = false;
                }

                if (label11.Visible != false)
                {
                    label11.Visible = false;
                }

                if (imgbtnNext.Enabled != true || imgbtnBack.Enabled != true)
                {
                    imgbtnNext.Enabled = true;
                    imgbtnBack.Enabled = true;
                }
            }
            else
            {
                lblMessageLastGameReach.Visible = true;
                if (Status == 1)
                {
                    imgbtnNext.Enabled = false; ;
                }
                else if (Status == 2)
                {
                    imgbtnBack.Enabled = false;
                }
                return;
            }

            lblTotalWin2.Text = string.Empty;
            lblStartingCrdtAmt.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.StartingCrdAmnt);
            lblEndingCreditAmt.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.EndingCrdAmnt);

            if (mGetInfo.WinAmount == 0)
            {
                lblWinAmt.Text = string.Empty;
            }
            else
            {
                lblWinAmt.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.WinAmount);
            }

            if (mGetInfo.BonusWinAmount == 0)
            {
                lblBonusWinAmt.Text = string.Empty;
            }
            else
            {
                lblBonusWinAmt.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.BonusWinAmount);
            }

            lblBetAmount.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.BetAmount);
//            label18.Text = "Game #: " + mGetInfo.GameNumber.ToString();

            if (mGetInfo.FirstBonusCardNumber != 0 && mGetInfo.IsBonusGameInProgress != 1)
            {
                if (mGetInfo.WinAmount == 0)
                {
                    checkBox1.Visible = false;
                }
                else
                {
                    checkBox1.Visible = true;
                }
                if (mGetInfo.B4Games == "Spirit76")
                {
                    SpiritBR = true;
                    
                    // Spirit does not require a base win amount to make it into 
                    //  the bonus round
                    checkBox1.Visible = true; 
                }
            }
            else
            {
                checkBox1.Visible = false;
            }


            lblBetLevel.Text = mGetInfo.BetLevel.ToString();
            lblBetDenom.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.BetDenom);
            lblB4Games.Text = mGetInfo.B4Games.ToString();
            SelectedB4Game = mGetInfo.B4Games.ToString();

            //GetBallCall
            GetBallCall y = new GetBallCall(PlayTime, mGetInfo.B4Games.ToString(), AccountNumber, mGetInfo.BallCount, mGetInfo.GameNumber);
            BallCall = GetBallCall.BallCall;
            BallCall = BallCall.Remove(BallCall.Length - 1);
            richTextBox1.Text = BallCall.Replace(",", ", ");

            int countBall = BallCall.Split(',').Length - 1;//If BallCall is more than 30


            GetNWinningPattern gnwn = new GetNWinningPattern(AccountNumber, PlayTime, mGetInfo.B4Games, mGetInfo.WinAmount);

            //PatternPayTable 
            lstviewPatterListTable.Items.Clear();
            CurrentDenom = mGetInfo.BetDenom;
            GetPatternPayTable getPatternPayTable = new GetPatternPayTable(CurrentDenom, mGetInfo.B4Games);

            List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
            listPatternTable = ListPatternPayTable.listpatternpaytable;


            int FMayaMoney = 0;
            foreach (PatternPayTable ppt in listPatternTable)
            {
                if (GetGameSettings.MinNumberOfPlayers <= 1 &&
                    ppt.PatterName == "Coverall")
                {
                    continue;
                }
                ListViewItem lvi = new ListViewItem(ppt.PatterName);
                lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * mGetInfo.BetLevel));//ppt.Pay.ToString());
                string NH = (ppt.NH == 0) ? string.Empty : (ppt.NH).ToString();
                lvi.SubItems.Add(NH);
                lstviewPatterListTable.Items.Add(lvi);
                //ForMayaMoney Bonus Round
                FMayaMoney = FMayaMoney + (ppt.Pay * mGetInfo.BetLevel * ppt.NH);
            }

            //Get the total win for dual accounting
            if (GetDualAccountSetting == true)
            {
                int TotalWinDA = GetTotalWinForDualAccount.getTotalWinForDualAccount(AccountNumber, mGetInfo.B4Games, /*mGetInfo.GameNumber*/PlayTime);
                if (TotalWinDA == 0)
                {
                    lblTotalWin2.Text = string.Empty;
                }
                else
                {
                    lblTotalWin2.Text = ConvertIntToMoneyFormat.convert_(TotalWinDA);
                }
                lblEndingCreditAmt.Text = ConvertIntToMoneyFormat.convert_(mGetInfo.StartingCrdAmnt - mGetInfo.BetAmount);
            }

            //Check if the game played is ClassII or ClassIII
//            sClass2 = IsClass2.GetStatus(mGetInfo.B4Games, mGetInfo.GameNumber, mGetInfo.DateTimePlay);
//            if (sClass2 == true)
//            {
                // Always show the server game number not the game number
                label18.Text = "Game #: " + mGetInfo.ServerGameNumber.ToString(); 
//            }

            //Load Card Number.
            int CountUpToSix = 1;
            int TempCardNumber = mGetInfo.FirstCardNumber;
            ClearAllTextInCardNumber();
            // clearCardSN();
             bool IsCardActive = false;
             int countActiveCard = 0;

            if (SelectedB4Game != "TimeBomb")
            {
               
                 countActiveCard = 0;
                 pnlDisputeResolutionTimeBomb.SendToBack();

                    while (CountUpToSix != (6 + 1))
                {
                    //Lets see if the first card number is enabled.

                    IsCardActive = false;
                    sc.Open();
                    try
                    {
                        using (SqlCommand cmd = new SqlCommand("select betplaced_card_" + CountUpToSix.ToString() + " from dbo." + mGetInfo.B4Games.ToString() + "_GameJournal  where creditacctnum = @creditacctnum and gamenum = @gamenum", sc))
                        {
                            cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                            cmd.Parameters.AddWithValue("gamenum", mGetInfo.GameNumber);
                            if (Convert.ToString(cmd.ExecuteScalar()) == "T")
                            {
                                IsCardActive = true;
                            }
                            else
                            {
                                IsCardActive = false;
                            }
                        }
                    }
                    catch (Exception ex) { MessageBox.Show(ex.Message); }
                    finally { sc.Close(); }

                 if (IsCardActive == true)
                {
                    countActiveCard = countActiveCard + 1;

                    GetCardNumber gcn = new GetCardNumber(TempCardNumber);
                    LoadCard(CountUpToSix);

                    if (CountUpToSix == 1)
                    {
                        lblSerialN1.Text = TempCardNumber.ToString();
                    }
                    else if (CountUpToSix == 2)
                    {
                        lblSerialN2.Text = TempCardNumber.ToString();
                    }
                    else if (CountUpToSix == 3)
                    {
                        lblSerialN3.Text = TempCardNumber.ToString();
                    }
                    else if (CountUpToSix == 4)
                    {
                        lblSerialN4.Text = TempCardNumber.ToString();
                    }
                    else if (CountUpToSix == 5)
                    {
                        lblSerialN5.Text = TempCardNumber.ToString();
                    }
                    else if (CountUpToSix == 6)
                    {
                        lblSerialN6.Text = TempCardNumber.ToString();
                    }

                }//if its false let us hide the bingo cards
                else
                {
                    HideCardsIfNotEnable(CountUpToSix);

                    if (CountUpToSix == 1)
                    {
                        lblSerialN1.Text = string.Empty;
                    }
                    else if (CountUpToSix == 2)
                    {
                        lblSerialN2.Text = string.Empty;
                    }
                    else if (CountUpToSix == 3)
                    {
                        lblSerialN3.Text = string.Empty;
                    }
                    else if (CountUpToSix == 4)
                    {
                        lblSerialN4.Text = string.Empty;
                    }
                    else if (CountUpToSix == 5)
                    {
                        lblSerialN5.Text = string.Empty;
                    }
                    else if (CountUpToSix == 6)
                    {
                        lblSerialN6.Text = string.Empty;
                    }
                }

                TempCardNumber++;
                CountUpToSix = CountUpToSix + 1;
            
                }
            }
            else//TimeBomb
            {

                bool isDefused = false;
                bool isExploded = false;
                string lblCardStatus = "";

                pnlDisputeResolutionTimeBomb.BringToFront();
                if (pnlDisputeResolutionTimeBomb.Visible != true)
                {
                    pnlDisputeResolutionTimeBomb.Visible = true;
                }

                CountUpToSix = 1; 
                while (CountUpToSix != (4 + 1))
                {
                    //Lets see if the first card number is enabled.

                    IsCardActive = false;
                    sc.Open();
                    try
                    {
                        using (SqlCommand cmd = new SqlCommand(
                          "select "
                          + "betplaced_card_" + CountUpToSix.ToString()
                          + " ,bombcard_" + CountUpToSix.ToString() + "_defused"
                          + " ,cardpair_" + CountUpToSix.ToString() + "_exploded" +
                          " from dbo." + mGetInfo.B4Games.ToString() + "_GameJournal  where creditacctnum = @creditacctnum and gamenum = @gamenum", sc))
                        {
                            cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                            cmd.Parameters.AddWithValue("gamenum", mGetInfo.GameNumber);

                            SqlDataReader reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                if ((reader.GetString(0)) == "T")
                                {
                                    IsCardActive = true;
                                }
                                else
                                {
                                    IsCardActive = false;
                                }

                                if ((reader.GetString(1)) == "T")
                                {
                                    isDefused = true;
                                }
                                else
                                {
                                    isDefused = false;
                                }

                                if ((reader.GetString(2)) == "T")
                                {
                                    isExploded = true;
                                }
                                else
                                {
                                    isExploded = false;
                                }

                            }


                        }
                    }
                    catch (Exception ex) { MessageBox.Show(ex.Message); }
                    finally { sc.Close(); }


                    if (IsCardActive == true)
                    {
                        countActiveCard = countActiveCard + 1;
                        Panel pnlCurrent = new Panel();
                        Panel pnlCurrentBonus = new Panel();
                        lblCardStatus = "";
     

                                if (CountUpToSix + 4 == 5)
                                {                        
                                    pnlCurrent = pnlRegRedCard;
                                    pnlCurrentBonus = pnlTimeBombRed;                                                                          
                                }
                                else if (CountUpToSix + 4 == 6)
                                {                                  
                                    pnlCurrent = pnlRegPurpCard;
                                    pnlCurrentBonus = pnlTimeBombPurple;
                                                                                        
                                }
                                else if (CountUpToSix + 4 == 7)
                                {                                  
                                    pnlCurrent = pnlRegGreenCard;
                                    pnlCurrentBonus = pnlTimeBombGreen;
                                                           
                                }
                                else if (CountUpToSix + 4 == 8)
                                {                                 
                                   pnlCurrent = pnlRegBlueCard;
                                    pnlCurrentBonus = pnlTimeBombBlue;                                                     
                                }

                              

                                if (isDefused)
                                {
                                    lblCardStatus = "(Defused)";
                                }
                                else
                                    if (isExploded)
                                    {
                                        lblCardStatus = "(Exploded)";
                                    }
                                    else
                                { lblCardStatus = "(Not Activated)"; }


                        gcn = new GetCardNumber2(TempCardNumber);
                        LoadCardTimeBomb(CountUpToSix);
                        StampBingoN(pnlCurrent);


                        int TempCardNumberDefusedCard = TempCardNumber + 4;
                        gcn = new GetCardNumber2(TempCardNumberDefusedCard);
                        LoadCardTimeBomb(CountUpToSix + 4);
                        StampBingoN(pnlCurrentBonus);

                       
                        if (CountUpToSix == 1)
                        {
                            lblTimeBombRedRegCard.Text = TempCardNumber.ToString() + (lblCardStatus == "(Exploded)" ? lblCardStatus : ""); 
                            lblTimeBombRedBonusCard.Text = (TempCardNumber + 4).ToString() + lblCardStatus;
                        }
                        else if (CountUpToSix == 2)
                        {
                            lblTimeBombPurpleRegCard.Text = TempCardNumber.ToString() + (lblCardStatus == "(Exploded)" ? lblCardStatus : ""); 
                            lblTimeBombPurpleBonusCard.Text = (TempCardNumber + 4).ToString() + lblCardStatus;
                        }
                        else if (CountUpToSix == 3)
                        {
                            lblTimeBombGreenRegCard.Text = TempCardNumber.ToString() + (lblCardStatus == "(Exploded)" ? lblCardStatus : ""); 
                            lblTimeBombGreenBonusCard.Text = (TempCardNumber + 4).ToString() + lblCardStatus;
                        }
                        else if (CountUpToSix == 4)
                        {
                            lblTimeBombBlueRegCard.Text = TempCardNumber.ToString() + (lblCardStatus == "(Exploded)" ? lblCardStatus : ""); 
                            lblTimeBombBlueBonusCard.Text = (TempCardNumber + 4).ToString() + lblCardStatus;
                        }
                      
                    }//if its false let us hide the bingo cards
                    else
                    {
                        HideCardsIfNotEnable(CountUpToSix);

                        if (CountUpToSix == 1)
                        {
                            lblSerialN1.Text = string.Empty;
                        }
                        else if (CountUpToSix == 2)
                        {
                            lblSerialN2.Text = string.Empty;
                        }
                        else if (CountUpToSix == 3)
                        {
                            lblSerialN3.Text = string.Empty;
                        }
                        else if (CountUpToSix == 4)
                        {
                            lblSerialN4.Text = string.Empty;
                        }
                    }

                    TempCardNumber++;
                    CountUpToSix = CountUpToSix + 1;
                    }
           }


            if (SelectedB4Game == "JailBreak")
            {
                int PatternN = GetBallCall.GetBonusPatternNForJailBreak(PlayTime, AccountNumber);
                if (PatternN != 0)
                {
                    string Pattern = ListPatternPayTable.listpatternpaytable[12 - PatternN].PatterName.ToString();
                    // if (test == "") { }
                    label11.Text = "Bonus trigger : " + Pattern;
                    label11.Visible = true;
                }
            }

            if (FMayaMoney == 0 && mGetInfo.WinAmount != 0)
            {
                label11.Visible = true;

                label11.Text = "Extra Bonus";

            }
            else
            {

            }


            bool IsConsolationGame = false;
            if (countBall > 30)
            {
                label11.Visible = true;
                label11.Text = "Extra Bonus";
                IsConsolationGame = true;
            }


            if (SelectedB4Game == "MayaMoney")
            {
                if (countActiveCard == 6 && IsConsolationGame == false)
                {
                    if (MayaMoneyCardTypeImage != 2)
                    {
                        MayaMoneyCardTypeImage = 2;
                        pictureBox1.Image = Properties.Resources.card_blue;
                        pictureBox10.Image = Properties.Resources.card_blue;
                        pictureBox2.Image = Properties.Resources.card_blue;
                        pictureBox3.Image = Properties.Resources.card_orange_serial;
                        pictureBox4.Image = Properties.Resources.card_orange_serial;
                        pictureBox5.Image = Properties.Resources.card_red_serial;
                    }
                }
                else
                {
                    if (MayaMoneyCardTypeImage != 1)
                    {
                        pictureBox1.Image = Properties.Resources.Card;
                        pictureBox10.Image = Properties.Resources.Card;
                        pictureBox2.Image = Properties.Resources.Card;
                        pictureBox3.Image = Properties.Resources.Card;
                        pictureBox4.Image = Properties.Resources.Card;
                        pictureBox5.Image = Properties.Resources.Card;
                        MayaMoneyCardTypeImage = 1;
                    }
                }

                int TWinAmount = mGetInfo.WinAmount + mGetInfo.BonusWinAmount;
                if (FMayaMoney != TWinAmount && FMayaMoney != 0)
                {
                    label11.Visible = true;
                    int Multiplier = TWinAmount / FMayaMoney;
                    if (Multiplier == 3)
                    {
                        label11.Text = "3X JAGUAR Level Winner";
                    }
                    else
                        if (Multiplier == 5)
                        {
                            label11.Text = "5X SERPENT Level Winner";
                        }
                        else
                            if (Multiplier == 10)
                            {
                                label11.Text = "10X EAGLE Level Winner";
                            }
                }
            }
            else
            {
                if (MayaMoneyCardTypeImage != 0)
                {
                    pictureBox1.Image = Properties.Resources.Card;
                    pictureBox10.Image = Properties.Resources.Card;
                    pictureBox2.Image = Properties.Resources.Card;
                    pictureBox3.Image = Properties.Resources.Card;
                    pictureBox4.Image = Properties.Resources.Card;
                    pictureBox5.Image = Properties.Resources.Card;
                    MayaMoneyCardTypeImage = 0;
                }
            }

            //HotBall
            if (SelectedB4Game == "WildBall" && mGetInfo.FirstBonusCardNumber == 0)
            {
                GetBallCall.GetHotBall(PlayTime, AccountNumber);
                int HotBall = GetBallCall.HotBall;
                label8.Text = "Ball Call with Hotball " + HotBall.ToString();
            }
            else
            { label8.Text = "Ball Call"; }
        }


        private void GetCardStartNumber()
        {
            cmbxCardNumberStart.Items.Clear();

            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetCardNumStart
                                                            @spAcctNbr  = @AccountNumber
                                                            ,@spB4Games = @SelectedB4Game 
                                                             ,@spGameStartNbr = @GameNumStart
                                                                ,@spGameEndNbr = @GameNumEnd
                                                                    ", sc))
                {
                    cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                    cmd.Parameters.AddWithValue("SelectedB4Game", SelectedB4Game);

                    int GameNumStart2 = 0;
                    int GameNumEnd2 = 0;
                    if (chkbxGameNumber.Checked == false)
                    {
                        //GameNumEnd2 = 
                        int indexofGameNum2 = cmbxGameNumberStart.Items.Count - 1;
                        GameNumEnd2 = Convert.ToInt32(cmbxGameNumberStart.Items[indexofGameNum2].ToString());
                        GameNumStart2 = Convert.ToInt32(cmbxGameNumberStart.Items[0].ToString());
                    }
                    else
                    {
                        GameNumStart2 = GameNumStart;
                        GameNumEnd2 = GameNumEnd;
                    }
                    cmd.Parameters.AddWithValue("GameNumStart", GameNumStart2);
                    cmd.Parameters.AddWithValue("GameNumEnd", GameNumEnd2);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        cmbxCardNumberStart.Items.Add(reader.GetInt32(0));
                    }
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sc.Close();
            }

            if (chkbxCardNumber.Checked == true)//error
            {
                if (GameNumStart <= GameNumEnd)
                {
                    cmbxCardNumberStart.SelectedIndex = 0;
                }
            }
        }


        private void loadGameStartAndEndNumber()
        {
            if (chkbxGameNumber.Checked == true)
            {
                groupBox2.Enabled = true;

                cmbxGameNumberStart.Items.Clear();
                GameNumEnd = 0;
                CardNumEnd = 0;

                GetGameNumber getGameNumber = new GetGameNumber(AccountNumber, SelectedB4Game);
                List<gamenumber> gn = new List<gamenumber>();
                gn = listgamenumber.lgamenumber;

                foreach (gamenumber g_n in gn)
                {
                    cmbxGameNumberStart.Items.Add(g_n.gamenum);
                }
                //                try
                //                {
                //                    sc.Open();
                //                    using (SqlCommand cmd = new SqlCommand(@"exec usp_management_DisputeResolution_GetGameNumStart @spCreditAccountNumber  = @AccountNumber,
                //                                                            @spB4Games = @SelectedB4Game ", sc))
                //                    {
                //                        cmd.Parameters.AddWithValue("AccountNumber", AccountNumber);
                //                        cmd.Parameters.AddWithValue("SelectedB4Game", SelectedB4Game);
                //                        SqlDataReader reader = cmd.ExecuteReader();
                //                        while (reader.Read())
                //                        {
                //                            cmbxGameNumberStart.Items.Add(reader.GetInt32(0));
                //                        }
                //                    }
                //                }
                //                catch (Exception ex)
                //                {
                //                    MessageBox.Show(ex.Message);
                //                }
                //                finally
                //                {
                //                    sc.Close();
                //                }

                if (cmbxGameNumberStart.Items.Count > 10)
                {
                    cmbxGameNumberStart.SelectedIndex = cmbxGameNumberStart.Items.Count - 10; //0;
                }
                else
                {
                    cmbxGameNumberStart.SelectedIndex = 0;
                }
                cmbxGameNumberStart.Enabled = true;
                cmbxGameNumberEnd.Enabled = true;
            }
            else
            {
                groupBox2.Enabled = false;
                cmbxGameNumberStart.SelectedIndex = -1;
                GameNumStart = 0;
                GameNumEnd = 0;
            }
        }



        private void TurnOnNotInPlayImages()
        {
            pictureBox6.Visible = true;
            pictureBox11.Visible = true;
            pictureBox12.Visible = true;
            pictureBox13.Visible = true;
            pictureBox14.Visible = true;
            pictureBox15.Visible = true;
        }

        private void TurnOffNotInPlayImages()
        {
            pictureBox6.Visible = false;
            pictureBox11.Visible = false;
            pictureBox12.Visible = false;
            pictureBox13.Visible = false;
            pictureBox14.Visible = false;
            pictureBox15.Visible = false;
        }

        private void ShowCardPanel()
        {
            pnlRegularGames.Visible = true;
            panel5.Visible = true;
            panel6.Visible = true;
            panel7.Visible = true;
            panel8.Visible = true;
            panel9.Visible = true;
            panel10.Visible = true;
        }

        private void DontShowCardPanel()
        {
            pnlRegularGames.Visible = false;
            panel5.Visible = false;
            panel6.Visible = false;
            panel7.Visible = false;
            panel8.Visible = false;
            panel9.Visible = false;
            panel10.Visible = false;
        }



        private void clearAllLblMessage()
        {
            lblMessageLastGameReach.Visible = false;
        }



        private void EnableControlInPanel2()
        {
            txtbxAccountNumber.Enabled = true;
            cmbxGameName.Enabled = true;
            imgbtnLookUp.Enabled = true;
            if (chkbxGameNumber.Checked == true)
            {
                chkbxGameNumber.Enabled = true;
                cmbxGameNumberStart.Enabled = true;
                cmbxGameNumberEnd.Enabled = true;

            }

        }

        private void ClearInfo()
        {
            if (lblStartingCrdtAmt.Text != string.Empty) { lblStartingCrdtAmt.Text = string.Empty; }
            if (lblEndingCreditAmt.Text != string.Empty) { lblEndingCreditAmt.Text = string.Empty; }
            if (lblWinAmt.Text != string.Empty) { lblWinAmt.Text = string.Empty; }
            lblBonusWinAmt.Text = string.Empty;
            lblBetAmount.Text = string.Empty;
            lblBetLevel.Text = string.Empty;
            lblBetDenom.Text = string.Empty;
            lblB4Games.Text = string.Empty;
        }

        private void DisableControlsInPanel2()
        {
            imgbtnLookUp.Enabled = false;
            txtbxAccountNumber.Enabled = false;
            cmbxGameName.Enabled = false;
            chkbxGameNumber.Enabled = false;
            cmbxGameNumberStart.Enabled = false;
            cmbxGameNumberEnd.Enabled = false;
        }


        private void DisableControlsInPanel1()
        {
            imgbtnBack.Enabled = false;
            imgbtnEnd.Enabled = false;
            imgbtnNext.Enabled = false;
            richTextBox1.Text = string.Empty;
        }


        private void EnableControlInPanel1()
        {
            imgbtnNext.Enabled = true;
            imgbtnBack.Enabled = true;
            imgbtnEnd.Enabled = true;
        }

        private void BonusRound()
        {           
            pictureBox1.Visible = false;
            pictureBox2.Visible = false;
            pictureBox3.Visible = false;
            pictureBox4.Visible = false;
            pictureBox5.Visible = false;
            pictureBox7.Visible = true;
            pictureBox8.Visible = true;
            pictureBox9.Visible = true;
            label12.Visible = true;
        }

        private void NonBonusRound()
        {
            pictureBox1.Visible = true;
            pictureBox2.Visible = true;
            pictureBox3.Visible = true;
            pictureBox4.Visible = true;
            pictureBox5.Visible = true;
            pictureBox7.Visible = false;
            pictureBox8.Visible = false;
            pictureBox9.Visible = false;
            label12.Visible = false;
        }


        private bool IsThisAccountPlayedAnyGames(int acctNum)
        {
            bool result = false;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand("select dbo.b3_fnCheckAccountifPlayed(@acctNum)", sc))
                {
                    cmd.Parameters.AddWithValue("acctNum", acctNum);
                    result = Convert.ToBoolean(cmd.ExecuteScalar());
                }

            }
            catch (Exception ex)
            { MessageBox.Show(ex.Message); }
            finally
            {
                sc.Close();
            }
            return result;
        }

        private bool IsAccountNumberValid(int acctNum)
        {
            bool IsValid = false;
            try
            {
                sc.Open();
                using (SqlCommand cmd = new SqlCommand("select count(*) from dbo.B3_CreditJournal where creditacctnum = @acctNum ", sc))
                {
                    cmd.Parameters.AddWithValue("acctNum", acctNum);
                    IsValid = (int)cmd.ExecuteScalar() > 0;
                }

            }
            catch (Exception ex)
            { MessageBox.Show(ex.Message); }
            finally
            {
                sc.Close();
            }

            return IsValid;
        }




        private void ClearErrorProvider()
        {
            errorProvider1.Clear();
            errorProvider1.SetError(txtbxAccountNumber, string.Empty);
        }

        #endregion
    }
}
