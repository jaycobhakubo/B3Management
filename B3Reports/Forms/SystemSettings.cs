using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GameTech.B3Reports.Properties;
using System.ServiceProcess;
using System.Management;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports.Forms
{
    //public partial class SystemSettings : Form//GradientForm
    public partial class SystemSettings : GradientForm
    {

        #region VARIABLES

        private const string GameSettingsString = "{0} Settings";

        GetSystemConfig SystemConfig;
        SettingsControl m_activeControl = null;
        SettingsControl m_previousControl = null;
        bool m_bResetPreviousControl = false;
        bool IsSecuritySettings = false;
        bool IsGameSettings = false;
        bool IsCrazyBoutGameSettings = false;
        bool IsJailBreakGameSettings = false;
        bool IsMayaMoneyGameSettings = false;
        bool IsPlayerSettings = false;
        bool IsClientAccessControl = false;
        bool IsNDSettings = false;
        bool IsUserAccessControl = false;
        private bool m_isWildBallGameSettings;
        private bool m_isSpirit76GameSettings;
        private bool m_isTimeBombGameSettings;

        private List<string> m_activeGameList;

        #endregion


        public SystemSettings()
        {
            InitializeComponent();
            SystemConfig = new GetSystemConfig();
            CreateNodes();
            AdjustWindowSize.adjust(this);
            pictureBox1.BringToFront();
            // clientAccessControl1.dgClientAccess.CellClick += dgClientAccessCellClick;
            //SetStyle(ControlStyles.OptimizedDoubleBuffer, true);
            gameSettings1.EnableGameCheckedEvent += EnableGameCheckedEvent;
        }

        private void SystemSettings_Load(object sender, EventArgs e)
        {
            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);
        }


        #region METHODS

        private void clearImage()
        {
            picBxSaved.Visible = false;
        }

        private void clearErrorP()
        {
            SecuritySettings x = new SecuritySettings();//?
            x.clearError();
        }



        private void reset()
        {
            if (IsSecuritySettings == true)
            {                //Lets save the changes
                securitySettings1.LoadSettings();
            }
            else if (IsGameSettings == true)
            {
                gameSettings1.LoadSettings();
            }
            else if (IsCrazyBoutGameSettings == true)
            {
                gameSettingCrazyBout1.LoadSettings();
            }
            else if (IsJailBreakGameSettings == true)
            {
                gameSettingJailBreak1.LoadSettings();
            }
            else if (IsMayaMoneyGameSettings == true)
            {
                gameSettingMayaMoney1.LoadSettings();
            }
            else if (m_isWildBallGameSettings)
            {
                gameSettingWildBall1.LoadSettings();
            }
            else if (IsClientAccessControl == true)
            {
                clientAccessControl1.LoadSettings();
            }
            else if (m_isSpirit76GameSettings)
            {
                gameSettingSpirit761.LoadSettings();
            }
            else if (m_isTimeBombGameSettings)
            {
                gameSettingTimeBomb1.LoadSettings();
            }
            else if (IsNDSettings)
            {
                ndSettings1.LoadSettings();
            }

            clearErrorP();
            clearImage();
        }

        private void EnableGameCheckedEvent(object sender, EventArgs eventArgs)
        {
            var checkBox = sender as CheckBox;
            if (checkBox == null)
            {
                return;
            }

            var gameInfo = checkBox.Tag as B3GamesInfo;
            if (gameInfo == null)
            {
                return;
            }
            var node = treeView1.Nodes.Find(string.Format(GameSettingsString, gameInfo.DisplayName), true).FirstOrDefault();
            if (node == null)
            {
                return;
            }

            switch (gameInfo.GameIconName)
            {
                case GameIconNameEnum.CRAZYBOUT:
                    {
                        node.ForeColor = gameSettings1.IsCrazyBoutEnabled ? Color.Black : Color.DarkGray;
                        gameSettingCrazyBout1.EnableControls(gameSettings1.IsCrazyBoutEnabled);
                    }
                    break;
                case GameIconNameEnum.JAILBREAK:
                    {
                        node.ForeColor = gameSettings1.IsJailBreakEnabled ? Color.Black : Color.DarkGray;
                        gameSettingJailBreak1.EnableControls(gameSettings1.IsJailBreakEnabled);
                    }
                    break;
                case GameIconNameEnum.MAYAMONEY:
                    {
                        node.ForeColor = gameSettings1.IsMayaMoneyEnabled ? Color.Black : Color.DarkGray;
                        gameSettingMayaMoney1.EnableControls(gameSettings1.IsMayaMoneyEnabled);
                    }
                    break;
                case GameIconNameEnum.SPIRIT76:
                    {
                        node.ForeColor = gameSettings1.IsSpirit76Enabled ? Color.Black : Color.DarkGray;
                        gameSettingSpirit761.EnableControls(gameSettings1.IsSpirit76Enabled);
                    }
                    break;
                case GameIconNameEnum.WILDBALL:
                    {
                        node.ForeColor = gameSettings1.IsWildBallEnabled ? Color.Black : Color.DarkGray;
                        gameSettingWildBall1.EnableControls(gameSettings1.IsWildBallEnabled);
                    }
                    break;
                case GameIconNameEnum.TIMEBOMB:
                    {
                        node.ForeColor = gameSettings1.IsTimeBombEnabled ? Color.Black : Color.DarkGray;
                        gameSettingTimeBomb1.EnableControls(gameSettings1.IsTimeBombEnabled);
                    }
                    break;
            }
        }

        private void setSettingToFalse()
        {
            IsClientAccessControl = false;
            IsSecuritySettings = false;
            IsGameSettings = false;
            IsCrazyBoutGameSettings = false;
            IsJailBreakGameSettings = false;
            IsMayaMoneyGameSettings = false;
            IsPlayerSettings = false;
            IsNDSettings = false;
            m_isWildBallGameSettings = false;
            m_isSpirit76GameSettings = false;
            m_isTimeBombGameSettings = false;
        }

        private void CreateNodes()
        {
            TreeNode nodeParent;
            TreeNode nodeChild;
            treeView1.Nodes.Clear();

            CurrentLoginID clid = new CurrentLoginID();
            clid.Get();
            IsUserAccessControl = GetStaffMgmtPermissions.UserAccessPermission(CurrentLoginID.LoginID);
            if (IsUserAccessControl == true)
            {
                nodeParent = new TreeNode("Client Access Control", 0, 1);
                nodeParent.Tag = clientAccessControl1;
                treeView1.Nodes.Add(nodeParent);
            }

            //North Dakota Settings 


            if (SystemConfig.IsND)
            {
                SystemConfig = new GetSystemConfig();
                nodeParent = new TreeNode("North Dakota Settings", 0, 1);
                ndSettings1.PlayerPinLength = SystemConfig.PinPlayerLen;
                nodeParent.Tag = ndSettings1;
                treeView1.Nodes.Add(nodeParent);
                //ndSettings1.grpBxNDSettings.Enabled = true;      
            }
            else
            {
                //ndSettings1.grpBxNDSettings.Enabled = false;
            }

            nodeParent = new TreeNode("Game Settings", 0, 1);
            nodeParent.Tag = gameSettings1;

            var b3Games = GetAvailableGames.GamesList;
            foreach (var b3GamesInfo in b3Games)
            {
                nodeChild = nodeParent.Nodes.Add(string.Format(GameSettingsString, b3GamesInfo.DisplayName));
                nodeChild.Name = string.Format(GameSettingsString, b3GamesInfo.DisplayName);
                switch (b3GamesInfo.GameIconName)
                {
                    case GameIconNameEnum.CRAZYBOUT:
                        nodeChild.Tag = gameSettingCrazyBout1;
                        break;
                    case GameIconNameEnum.JAILBREAK:
                        nodeChild.Tag = gameSettingJailBreak1;
                        break;
                    case GameIconNameEnum.MAYAMONEY:
                        nodeChild.Tag = gameSettingMayaMoney1;
                        break;
                    case GameIconNameEnum.WILDBALL:
                        nodeChild.Tag = gameSettingWildBall1;
                        break;
                    case GameIconNameEnum.SPIRIT76:
                        nodeChild.Tag = gameSettingSpirit761;
                        break;
                    case GameIconNameEnum.TIMEBOMB:
                        nodeChild.Tag = gameSettingTimeBomb1;
                        break;
                }
            }

            treeView1.Nodes.Add(nodeParent);

            nodeParent = new TreeNode("Security Settings", 0, 1);
            nodeParent.Tag = securitySettings1;
            treeView1.Nodes.Add(nodeParent);
        }
        
        #endregion

        #region EVENTS

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            setSettingToFalse();
            if (imgBtnRefreshSystemSettings.Visible != false)
            {
                imgBtnRefreshSystemSettings.Visible = false;
            }

            if (m_bResetPreviousControl)
            {
                m_activeControl.LoadSettings();
                m_bResetPreviousControl = false;
            }
            //END FIX RALLY DE2661

            // Get the selected node and display its panel
            m_previousControl = m_activeControl;
            m_activeControl = (SettingsControl)(treeView1.SelectedNode.Tag);
            m_activeControl.OnActivate(treeView1.SelectedNode);

            m_activeControl.BringToFront();
            m_activeControl.LoadSettings();
            treeView1.SelectedNode = e.Node;

            int x = Convert.ToInt32(m_activeControl.Tag);
            if (x == 1)//SecuritySettings
            {
                IsSecuritySettings = true;
                IsGameSettings = false;
                if (pnlWarning.Visible != false)
                {
                    pnlWarning.Visible = false;
                }
            }
            else if (x == 2)//Gamesettings
            {
                IsGameSettings = true;
                if (pnlWarning.Visible != true)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 3)
            {
                IsCrazyBoutGameSettings = true;
                if (pnlWarning.Visible != true)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 4)
            {
                IsJailBreakGameSettings = true;
                if (pnlWarning.Visible != true)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 5)
            {
                IsMayaMoneyGameSettings = true;
                if (pnlWarning.Visible != true)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 6)//client access
            {

                IsClientAccessControl = true;
                if (pnlWarning.Visible != false)
                {
                    pnlWarning.Visible = false;
                }

                if (imgBtnRefreshSystemSettings.Visible != true)
                {
                    imgBtnRefreshSystemSettings.Visible = true;
                }
            }
            else if (x == 7) //player settings
            {
                IsPlayerSettings = true;
                if (pnlWarning.Visible != false)
                {
                    pnlWarning.Visible = false;
                }

                if (imgBtnRefreshSystemSettings.Visible != true)
                {
                    imgBtnRefreshSystemSettings.Visible = true;
                }
            }
            else if (x == 8)
            {
                IsNDSettings = true;
                if (pnlWarning.Visible != false)
                {
                    pnlWarning.Visible = false;
                }
            }
            else if (x == 9)
            {
                m_isWildBallGameSettings = true;

                if (!pnlWarning.Visible)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 10)
            {
                m_isSpirit76GameSettings = true;

                if (!pnlWarning.Visible)
                {
                    pnlWarning.Visible = true;
                }
            }
            else if (x == 11)
            {
                m_isTimeBombGameSettings = true;

                if (!pnlWarning.Visible)
                {
                    pnlWarning.Visible = true;
                }
            }

            //treeView1.Update();

            Application.DoEvents();
        }

        private void treeView1_BeforeSelect(object sender, TreeViewCancelEventArgs e)
        {
            // Prompt to save if modified
            if (m_activeControl != null)
            {
                if (m_activeControl.IsModified)
                {
                    DialogResult result = MessageBox.Show(this, Resources.SaveChangesMessage, Resources.SaveChangesHeader, MessageBoxButtons.YesNoCancel);
                    // DialogResult result = MessageForm.Show(this, Resources.SaveChangesMessage, Resources.SaveChangesHeader, MessageFormTypes.YesNoCancel);
                    this.Refresh();
                    switch (result)
                    {
                        case DialogResult.Yes:
                            // If save fails remain on current tab
                            if (!m_activeControl.SaveSettings())
                            {
                                e.Cancel = true;
                            }
                            break;
                        case DialogResult.Cancel:
                            e.Cancel = true;
                            break;
                        default:
                            m_activeControl.IsModified = false; ;
                            m_bResetPreviousControl = true;
                            break;
                    }
                }
            }

            clearImage();
        }


        private void imgBtnSaveSystemSettings_Click(object sender, EventArgs e)
        {
            //setSettingToFalse();

            clearErrorP();
            var result = false;
            Cursor.Current = Cursors.WaitCursor;
            if (IsClientAccessControl && clientAccessControl1.IsModified)
            {
                result = clientAccessControl1.SaveClientAccessControl(clientAccessControl1.dgClientAccess);
            }
            else if (IsSecuritySettings && securitySettings1.IsModified)
            {                //Lets save the changes
                result = securitySettings1.SaveSettings();
            }
            else if (IsNDSettings && ndSettings1.IsModified)
            {
                result = ndSettings1.SaveSettings();
            }
            else if (IsGameSettings && gameSettings1.IsModified)
            {
                bool vresult = gameSettings1.ValidateInput();
                if (vresult)
                {
                    result = gameSettings1.SaveSettings();
                }
            }
            else if (IsCrazyBoutGameSettings && gameSettingCrazyBout1.IsModified)
            {
                result = gameSettingCrazyBout1.SaveSettings();
            }
            else if (IsJailBreakGameSettings && gameSettingJailBreak1.IsModified)
            {
                result = gameSettingJailBreak1.SaveSettings();
            }
            else if (IsMayaMoneyGameSettings && gameSettingMayaMoney1.IsModified)
            {
                result = gameSettingMayaMoney1.SaveSettings();
            }
            else if (m_isWildBallGameSettings && gameSettingWildBall1.IsModified)
            {
                result = gameSettingWildBall1.SaveSettings();
            }
            else if (m_isSpirit76GameSettings && gameSettingSpirit761.IsModified)
            {
                result = gameSettingSpirit761.SaveSettings();
            }
            else if (m_isTimeBombGameSettings && gameSettingTimeBomb1.IsModified)
            {
                result = gameSettingTimeBomb1.SaveSettings();
            }

            if (GetSecuritySettings.LogoutInactivity != 0)
            {
                IdleTimeStart start = new IdleTimeStart();
                start.StartTimer(this);
            }
            
            Cursor.Current = Cursors.Default;

            if (result)
            {
                picBxSaved.Visible = true;
                picBxSaved.BringToFront();
            }
        }

        private void imgBtnReturn_Click(object sender, EventArgs e)
        {
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
                //MessageForm.Show(this, mstrFormName + "fixUnitToolStripMenuItem_Click....Exception: " + ex.Message, "Game Management Main");
            }

            clearImage();
        }

        private void SystemSettings_VisibleChanged(object sender, EventArgs e)
        {

            CreateNodes();
            Form x = (Form)sender;
            if (x.Visible == true)
            {
                securitySettings1.LoadSettings();
                treeView1.Select();
                TreeNode y = treeView1.TopNode;
                treeView1.SelectedNode = y;
                treeView1.Focus();
                clearErrorP();
                gameSettings1.LoadSettings();
            }
        }

        private void imgBtnResetSystemSettings_Click(object sender, EventArgs e)
        {
            reset();
            //   if (IsSecuritySettings == true)
            //   {                //Lets save the changes
            //       securitySettings1.LoadSettings();
            //   }
            //   else if (IsGameSettings == true)
            //   {
            //       gameSettings1.LoadSettings();
            //   }
            //   else if (IsCrazyBoutGameSettings == true)
            //   {
            //       gameSettingCrazyBout1.LoadSettings();
            //   }
            //   else if (IsJailBreakGameSettings == true)
            //   {
            //       gameSettingJailBreak1.LoadSettings();
            //   }
            //   else if (IsMayaMoneyGameSettings == true)
            //   {
            //       gameSettingMayaMoney1.LoadSettings();
            //   }


            ////   securitySettings1.LoadSettings();
            // //  gameSettings1.LoadSettings();
            //   clearErrorP();
            clearImage();
        }

        private void gameSettings1_Enter(object sender, EventArgs e)
        {
            clearImage();
        }

        private void SystemSettings_Move(object sender, EventArgs e)
        {

        }

        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }

        private void SystemSettings_FormClosing(object sender, FormClosingEventArgs e)
        {
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
                //MessageForm.Show(this, mstrFormName + "fixUnitToolStripMenuItem_Click....Exception: " + ex.Message, "Game Management Main");
            }

            clearImage();
        }
        
        private void imgBtnRefreshSystemSettings_Click(object sender, EventArgs e)
        {
            clientAccessControl1.LoadClientAccessControl_(clientAccessControl1.dgClientAccess);
            clearImage();
            clearErrorP();
        }

        #endregion

    }
}
