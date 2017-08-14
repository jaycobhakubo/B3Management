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

        public DisputeResolution()
        {
            InitializeComponent();
            AdjustWindowSize.adjust(this);
        }

        private void imageButton4_Click(object sender, EventArgs e)//Return
        {
            if (lblTotalWin2.Text != string.Empty)
            {
                lblTotalWin2.Text = string.Empty;
            }

            label18.Text = string.Empty;
            cmbxGameNumberStart.Text = string.Empty; // DontShowCardPanel();
            //.SelectedItem = "";
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
            panel3.Visible = false;
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

        private void imgbtnEnd_Click(object sender, EventArgs e)
        {

            lblTotalWin2.Text = string.Empty;

            if (checkBox1.Checked != false)
            {checkBox1.Checked = false;}

            if (checkBox1.Visible != false)
            { checkBox1.Visible = false; }
            
            TurnOffNotInPlayImages();
            DontShowCardPanel();
            panel3.Visible = false;
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


            if (cmbxGameName.SelectedIndex != -1 && cmbxGameName.SelectedItem.ToString() != "ALL")
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

        }

        private void txtbxAccountNumber_MouseLeave(object sender, EventArgs e)
        {
        }

        private void txtbxAccountNumber_Leave(object sender, EventArgs e)
        {
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



        private void ClearErrorProvider()
        {
            errorProvider1.Clear();
            errorProvider1.SetError(txtbxAccountNumber, string.Empty);
        }

        private void txtbxAccountNumber_Click(object sender, EventArgs e)
        {
            ClearErrorProvider();
        }

        private void cmbxGameName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearErrorProvider();
            if (cmbxGameName.SelectedIndex != -1 && cmbxGameName.SelectedItem.ToString() != "ALL")
            {
                cmbxGameNumberStart.Items.Clear();
                GameNumEnd = 0;
                CardNumEnd = 0;
                if (cmbxGameName.SelectedItem.ToString() == "Crazy Bout")
                {
                    SelectedB4Game = "CrazyBout";
                }else
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
            else if (cmbxGameName.SelectedItem.ToString() == "ALL")
            {
                chkbxGameNumber.Checked = false;
                chkbxCardNumber.Checked = false;
                chkbxGameNumber.Enabled = false;
                chkbxCardNumber.Enabled = false;
                SelectedB4Game = "ALL";
            }
            else if (cmbxGameName.SelectedIndex == -1)
            {
                chkbxGameNumber.Checked = false;
                chkbxCardNumber.Checked = false;
                chkbxGameNumber.Enabled = false;
                chkbxCardNumber.Enabled = false;
            }
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

                    //How to get the first value in the combobox

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
                        //cmbxGameNumberEnd.Items.Add(reader.GetInt32(0));
                        cmbxCardNumberStart.Items.Add(reader.GetInt32(0));
                    }
                    // cmbxCardNumberStart.SelectedIndex = 0;
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
                ShowCardPanel();
                if (SelectedB4Game == "ALL" || cmbxGameName.Items.Count == 1)
                {
                    GetInfoALL();
                }
                else
                { GetInfoALL(); }
                DisableControlsInPanel2();
                EnableControlInPanel1();
                TurnOnNotInPlayImages();
            }
            else
            {
                errorProvider1.SetError(txtbxAccountNumber, "Account number is empty.");
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
            panel4.Visible = true;
            panel5.Visible = true;
            panel6.Visible = true;
            panel7.Visible = true;
            panel8.Visible = true;
            panel9.Visible = true;
            panel10.Visible = true;
        }

        private void DontShowCardPanel()
        {
            panel4.Visible = false;
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
            //txtbxStartingCrdtAmnt.Text = string.Empty;
            if (lblStartingCrdtAmt.Text != string.Empty) { lblStartingCrdtAmt.Text = string.Empty; }
            //txtbxEndingCrdtAmnt.Text = string.Empty;
            if (lblEndingCreditAmt.Text != string.Empty) { lblEndingCreditAmt.Text = string.Empty; }
            // txtbxWinAmount.Text = string.Empty;
             if (lblWinAmt.Text != string.Empty) { lblWinAmt.Text = string.Empty; }
            
            //txtbxBonusWinAmount.Text = string.Empty;
            lblBonusWinAmt.Text = string.Empty;
            //txtbxBetAmount.Text = string.Empty;
            lblBetAmount.Text = string.Empty;
            //txtbxBetLevel.Text = string.Empty;
            lblBetLevel.Text = string.Empty;
            //txtbxBetDenom.Text = string.Empty;
            lblBetDenom.Text = string.Empty;
            //txtbxB4Games.Text = string.Empty;
            lblB4Games.Text = string.Empty;
        }

        private void DisableControlsInPanel2()
        {
            imgbtnLookUp.Enabled = false;
            txtbxAccountNumber.Enabled = false;
            cmbxGameName.Enabled = false;
            //  chkbxGameNumber.Checked = false;
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

        private void imgbtnBack_Click(object sender, EventArgs e)
        {

            if (checkBox1.Checked != false)
            {
                checkBox1.Checked = false;
            }

                Status = 2;

            if (SelectedB4Game == "ALL" || cmbxGameName.Items.Count == 1)
            {
                GetInfoALL();
            }
            else
            { 
                GetInfoALL(); 
            }
        }

        private void imgbtnNext_Click(object sender, EventArgs e)
        {
            Status = 1;
            if (SelectedB4Game == "All" || cmbxGameName.Items.Count == 1)
            {
                GetInfoALL();
            }
            else
            { GetInfoALL(); }
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

            GetInfo x = new GetInfo(AccountNumber, PlayTime, Status, SelectedB4Game, GameNumStart, GameNumEnd, IsGameNumber);

            if (PlayTime != GetInfo.DateTimePlay)
            {
                PlayTime = GetInfo.DateTimePlay;
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
            lblStartingCrdtAmt.Text = ConvertIntToMoneyFormat.convert_(GetInfo.StartingCrdAmnt);
            lblEndingCreditAmt.Text = ConvertIntToMoneyFormat.convert_(GetInfo.EndingCrdAmnt);

            if (GetInfo.WinAmount == 0)
            {
                lblWinAmt.Text = string.Empty;
            }
            else
            {
                lblWinAmt.Text = ConvertIntToMoneyFormat.convert_(GetInfo.WinAmount);
            }

            if (GetInfo.BonusWinAmount == 0)
            {
                lblBonusWinAmt.Text = string.Empty;
            }
            else
            {
                lblBonusWinAmt.Text = ConvertIntToMoneyFormat.convert_(GetInfo.BonusWinAmount);
            }

            lblBetAmount.Text = ConvertIntToMoneyFormat.convert_(GetInfo.BetAmount);
            label18.Text = "Game #: " + GetInfo.GameNumber.ToString();

            if (GetInfo.FirstBonusCardNumber != 0)
            {
                if (GetInfo.WinAmount == 0)
                {
                    checkBox1.Visible = false;
                }
                else
                {
                    checkBox1.Visible = true;
                }
                    if (GetInfo.B4Games == "Spirit76")
                {
                    SpiritBR = true;
                }
            }
            else
            {
                checkBox1.Visible = false;
            }



            lblBetLevel.Text = GetInfo.BetLevel.ToString();
            lblBetDenom.Text = ConvertIntToMoneyFormat.convert_(GetInfo.BetDenom);
            lblB4Games.Text = GetInfo.B4Games.ToString();
            SelectedB4Game = GetInfo.B4Games.ToString();


            //GetBallCall
            GetBallCall y = new GetBallCall(PlayTime, GetInfo.B4Games.ToString(), AccountNumber, GetInfo.BallCount , GetInfo.GameNumber);
            BallCall = GetBallCall.BallCall;
            BallCall = BallCall.Remove(BallCall.Length - 1);
            richTextBox1.Text = BallCall;

            int countBall = BallCall.Split(',').Length - 1;//If BallCall is more than 30


            GetNWinningPattern gnwn = new GetNWinningPattern(AccountNumber, PlayTime, GetInfo.B4Games);

            //PatternPayTable 
            lstviewPatterListTable.Items.Clear();
            CurrentDenom = GetInfo.BetDenom;
            GetPatternPayTable getPatternPayTable = new GetPatternPayTable(CurrentDenom, GetInfo.B4Games);

            List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
            listPatternTable = ListPatternPayTable.listpatternpaytable;

          
            int FMayaMoney = 0;
            foreach (PatternPayTable ppt in listPatternTable)
            {
                ListViewItem lvi = new ListViewItem(ppt.PatterName);
                lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * GetInfo.BetLevel));//ppt.Pay.ToString());
                string NH = (ppt.NH == 0) ? string.Empty : (ppt.NH).ToString();
                lvi.SubItems.Add(NH);
                lstviewPatterListTable.Items.Add(lvi);
                //ForMayaMoney Bonus Round
                FMayaMoney = FMayaMoney + (ppt.Pay * GetInfo.BetLevel * ppt.NH);
            }
   
            //Get the total win for dual accounting
            if (GetDualAccountSetting == true)
            {
                int TotalWinDA = GetTotalWinForDualAccount.getTotalWinForDualAccount(AccountNumber, GetInfo.B4Games, /*GetInfo.GameNumber*/PlayTime);
                if (TotalWinDA == 0)
                {
                    lblTotalWin2.Text = string.Empty;
                }
                else
                {
                    lblTotalWin2.Text = ConvertIntToMoneyFormat.convert_(TotalWinDA);
                }
                lblEndingCreditAmt.Text = ConvertIntToMoneyFormat.convert_(GetInfo.StartingCrdAmnt - GetInfo.BetAmount);
            }

            //Check if the game played is ClassII or ClassIII
            sClass2 = IsClass2.GetStatus(GetInfo.B4Games, GetInfo.GameNumber, GetInfo.DateTimePlay);
            if (sClass2 == true)
            { label18.Text = "Game #: " + GetInfo.ServerGameNumber.ToString(); }

            //Load Card Number.
            int CountUpToSix = 1;
            int TempCardNumber = GetInfo.FirstCardNumber;
            ClearAllTextInCardNumber();
           // clearCardSN();

            int countActiveCard = 0;
            while (CountUpToSix != (6 + 1))
            {
                //Lets see if the first card number is enabled.

                bool IsCardActive = false;
                sc.Open();
                try
                {
                    using (SqlCommand cmd = new SqlCommand("select betplaced_card_" + CountUpToSix.ToString() + " from dbo." + GetInfo.B4Games.ToString() + "_GameJournal  where creditacctnum = @creditacctnum and gamenum = @gamenum", sc))
                    {
                        cmd.Parameters.AddWithValue("creditacctnum", AccountNumber);
                        cmd.Parameters.AddWithValue("gamenum", GetInfo.GameNumber);
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
                    else if(CountUpToSix == 2)
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
                    TempCardNumber = TempCardNumber + 1;

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
                //TempCardNumber = TempCardNumber + 1;
                CountUpToSix = CountUpToSix + 1;
            }

            //Bonus Pattern Trigger on JailBreak 
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

            //Display if it won consolation prize.
            if (FMayaMoney == 0 && GetInfo.WinAmount != 0)
            {
                label11.Visible = true;
     
                label11.Text = "Extra Bonus";
                
            }
            else
            {

            }

            //If its a cover all game
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

                int TWinAmount = GetInfo.WinAmount + GetInfo.BonusWinAmount;
                if (FMayaMoney != TWinAmount && FMayaMoney != 0)
                {
                    label11.Visible = true;
                    int Multiplier = TWinAmount / FMayaMoney;
                    if (Multiplier == 3)
                    {
                      //  label11.Text = "3X JAGUAR Multiplier Activated";
                        label11.Text = "3X JAGUAR Level Winner";
                    }
                    else
                        if (Multiplier == 5)
                        {
                            //label11.Text = "5X SERPENT Multiplier Activated";
                            label11.Text = "5X SERPENT Level Winner";
                        }
                        else
                            if (Multiplier == 10)
                            {
                                //label11.Text = "10X EAGLE Multiplier Activated";
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
            //}

            //HotBall
            if (SelectedB4Game == "WildBall" && GetInfo.FirstBonusCardNumber == 0)
            {
                GetBallCall.GetHotBall(PlayTime, AccountNumber);
                int HotBall = GetBallCall.HotBall;
                label8.Text = "Ball Call with Hotball " + HotBall.ToString();
            }
            else
            { label8.Text = "Ball Call"; }

         
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkbxShowBonusCard = (CheckBox)sender;
            if (chkbxShowBonusCard.Checked == true)
            {
                panel4.Visible = false;
                panel3.Visible = true;

                if (SelectedB4Game != "WildBall")
                {
                    panel14.Visible = false;
                }
                else
                {
                    panel14.Visible = true;
                }

                GetBallCall.GetBonusBallCall_(PlayTime, GetInfo.B4Games.ToString(), AccountNumber, GetInfo.BonusBallCount);
                BallCall = GetBallCall.BonusBallCall;
                BallCall = BallCall.Remove(BallCall.Length - 1);
                richTextBox1.Clear();
                richTextBox1.Text = BallCall;



                //PatternPayTable 
                GetNWinningPattern.GetNBonusWinningPattern(AccountNumber, PlayTime, GetInfo.B4Games);
                lstviewPatterListTable.Items.Clear();
                CurrentDenom = GetInfo.BetDenom;
                GetPatternBonusPayTable getPatternBonusPayTable = new GetPatternBonusPayTable(CurrentDenom, GetInfo.B4Games);

                List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
                listPatternTable = ListPatternPayTable.listpatternpaytable;

                foreach (PatternPayTable ppt in listPatternTable)
                {
                    ListViewItem lvi = new ListViewItem(ppt.PatterName);
                    lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * GetInfo.BetLevel));
                    string NH = (ppt.NH == 0) ? string.Empty : ppt.NH.ToString();
                    lvi.SubItems.Add(NH);
                    lstviewPatterListTable.Items.Add(lvi);
                }



                OfferAccepted();

                int TempCardNumber = GetInfo.FirstBonusCardNumber;
                int Count = 7;
                while (TempCardNumber != GetInfo.LastBonusCardNumber + 1)
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
                panel4.Visible = true;
                panel3.Visible = false;
                richTextBox1.Clear();
                GetBallCall y = new GetBallCall(PlayTime, GetInfo.B4Games.ToString(), AccountNumber, GetInfo.BallCount, GetInfo.GameNumber);
                BallCall = GetBallCall.BallCall;
                BallCall = BallCall.Remove(BallCall.Length - 1);
                richTextBox1.Text = BallCall;


                GetNWinningPattern gnwn = new GetNWinningPattern(AccountNumber, PlayTime, GetInfo.B4Games);
                lstviewPatterListTable.Items.Clear();
                CurrentDenom = GetInfo.BetDenom;
                GetPatternPayTable getPatternPayTable = new GetPatternPayTable(CurrentDenom, GetInfo.B4Games);

                List<PatternPayTable> listPatternTable = new List<PatternPayTable>();
                listPatternTable = ListPatternPayTable.listpatternpaytable;




                foreach (PatternPayTable ppt in listPatternTable)
                {
                    ListViewItem lvi = new ListViewItem(ppt.PatterName);
                    lvi.SubItems.Add(ConvertIntToMoneyFormat.convert_(ppt.Pay * GetInfo.BetLevel));
                    string NH = (ppt.NH == 0) ? string.Empty : ppt.NH.ToString();
                    lvi.SubItems.Add(NH);
                    lstviewPatterListTable.Items.Add(lvi);
                }


            }
        }

        private void OfferAccepted()
        {
            if (GetInfo.BonusOfferAccepted == 1)
            {
                label12.Text = "First Offer Accepted";
            }
            else
                if (GetInfo.BonusOfferAccepted == 2)
                {
                    label12.Text = "Second Offer Accepted";
                }
                else if (GetInfo.BonusOfferAccepted == 3)
                {
                    label12.Text = "Third Offer Accepted";
                }
                else if (GetInfo.BonusOfferAccepted == 4)
                {
                    label12.Text = "Final Offer Accepted";
                }
        }

        private void HideCardsIfNotEnable(int NCard)
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

                ////SAVE
                //check if this card won
                //if (SelectedB4Game == "MayaMoney")
                //{
                //    bool mmp = IWC.IWC_(NCardDubbed);
                //    if (mmp == true)
                //    {
                //        MayaMoneyPattern = MayaMoneyPattern + "1";
                //    }
                //}
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


                    //SAVE
                    //if (SelectedB4Game == "MayaMoney" && MayaMoneyPattern == "1")
                    //{
                    //    bool mmp = IWC.IWC_(NCardDubbed);
                    //    if (mmp == true)
                    //    {
                    //        MayaMoneyPattern = MayaMoneyPattern + "2";
                    //    }
                    //}

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

                        //SAVE
                        //if (SelectedB4Game == "MayaMoney" && MayaMoneyPattern == "12")
                        //{
                        //    bool mmp = IWC.IWC_(NCardDubbed);
                        //    if (mmp == true)
                        //    {
                        //        MayaMoneyPattern = MayaMoneyPattern + "3";
                        //    }
                        //}
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

                            //SAVE
                            //if (SelectedB4Game == "MayaMoney" && MayaMoneyPattern == "123")
                            //{
                            //    bool mmp = IWC.IWC_(NCardDubbed);
                            //    if (mmp == true)
                            //    {
                            //        MayaMoneyPattern = MayaMoneyPattern + "4";
                            //    }
                            //}
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

                                //SAVE
                                //if (SelectedB4Game == "MayaMoney" && MayaMoneyPattern == "1234")
                                //{
                                //    bool mmp = IWC.IWC_(NCardDubbed);
                                //    if (mmp == true)
                                //    {
                                //        MayaMoneyPattern = MayaMoneyPattern + "5";
                                //    }
                                //}

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

                                    //SAVE
                                    //if (SelectedB4Game == "MayaMoney" && MayaMoneyPattern == "12345")
                                    //{
                                    //    bool mmp = IWC.IWC_(NCardDubbed);
                                    //    if (mmp == true)
                                    //    {
                                    //        MayaMoneyPattern = MayaMoneyPattern + "6";
                                    //    }
                                    //}
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
                                            // panel10.Visible = true;
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
                                                // panel10.Visible = true;
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
                                                    // panel10.Visible = true;
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

        private void lblBingoCard1_TextChanged(object sender, EventArgs e)
        {
            Label x = (Label)sender;
            //test

            if (IsDubbed.Dubbed(x.Text, BallCall) == true)
            {
                x.BackColor = Color.LimeGreen;
            }
            else { x.BackColor = Color.White; }




            if ((SelectedB4Game == "Spirit76" && SpiritBR == true) && checkBox1.Checked == true)
            {
                string ballfreq = "," + GetBallCall.GetBallFreqFor76Games(PlayTime, AccountNumber);
                if (ballfreq.IndexOf("," + x.Tag.ToString() + ",") != -1)
                {
                    x.BackColor = Color.LimeGreen;
                }
            }


        }

        private void SetFreeBackColor()
        {
            lblBingoCard13.BackColor = Color.LimeGreen;
            lbl2BingoCard13.BackColor = Color.LimeGreen;
            lbl3BingoCard13.BackColor = Color.LimeGreen;
            lbl4BingoCard13.BackColor = Color.LimeGreen;
            lbl5BingoCard13.BackColor = Color.LimeGreen;
            lbl6BingoCard13.BackColor = Color.LimeGreen;
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
                                    reader.GetString(0) == "MayaMoney")

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
                        //     cmbxGameName.SelectedIndex = 0;
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
            panel3.Visible = false;
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

        //private void panel4_Paint(object sender, PaintEventArgs e)
        //{

        //}
    }
}
