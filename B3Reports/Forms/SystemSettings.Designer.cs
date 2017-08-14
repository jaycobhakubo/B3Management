namespace GameTech.B3Reports.Forms
{
    partial class SystemSettings
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SystemSettings));
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.treeView1 = new System.Windows.Forms.TreeView();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.securitySettings1 = new GameTech.B3Reports.Forms.SecuritySettings();
            this.gameSettings1 = new GameTech.B3Reports.Forms.GameSettings();
            this.ndSettings1 = new GameTech.B3Reports.Forms.NDSettings();
            this.gameSettingMayaMoney1 = new GameTech.B3Reports.Forms.GameSettingMayaMoney();
            this.clientAccessControl1 = new GameTech.B3Reports.Forms.ClientAccessControl();
            this.picBxSaved = new System.Windows.Forms.PictureBox();
            this.playerSettings1 = new GameTech.B3Reports.Forms.PlayerSettings();
            this.gameSettingJailBreak1 = new GameTech.B3Reports.Forms.GameSettingJailBreak();
            this.gameSettingCrazyBout1 = new GameTech.B3Reports.Forms.GameSettingCrazyBout();
            this.imgBtnRefreshSystemSettings = new GameTech.B3Reports.Forms.ImageButton();
            this.pnlWarning = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.imgBtnReturn = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnResetSystemSettings = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnSaveSystemSettings = new GameTech.B3Reports.Forms.ImageButton();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picBxSaved)).BeginInit();
            this.pnlWarning.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            resources.ApplyResources(this.menuStrip1, "menuStrip1");
            this.menuStrip1.Name = "menuStrip1";
            // 
            // splitContainer1
            // 
            resources.ApplyResources(this.splitContainer1, "splitContainer1");
            this.splitContainer1.BackColor = System.Drawing.Color.Transparent;
            this.splitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.treeView1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.BackColor = System.Drawing.Color.Transparent;
            this.splitContainer1.Panel2.Controls.Add(this.splitContainer2);
            // 
            // treeView1
            // 
            this.treeView1.BackColor = System.Drawing.SystemColors.Window;
            resources.ApplyResources(this.treeView1, "treeView1");
            this.treeView1.HideSelection = false;
            this.treeView1.Name = "treeView1";
            this.treeView1.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.treeView1_BeforeSelect);
            this.treeView1.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.treeView1_AfterSelect);
            // 
            // splitContainer2
            // 
            this.splitContainer2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            resources.ApplyResources(this.splitContainer2, "splitContainer2");
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.securitySettings1);
            this.splitContainer2.Panel1.Controls.Add(this.gameSettings1);
            this.splitContainer2.Panel1.Controls.Add(this.ndSettings1);
            this.splitContainer2.Panel1.Controls.Add(this.gameSettingMayaMoney1);
            this.splitContainer2.Panel1.Controls.Add(this.clientAccessControl1);
            this.splitContainer2.Panel1.Controls.Add(this.picBxSaved);
            this.splitContainer2.Panel1.Controls.Add(this.playerSettings1);
            this.splitContainer2.Panel1.Controls.Add(this.gameSettingJailBreak1);
            this.splitContainer2.Panel1.Controls.Add(this.gameSettingCrazyBout1);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.imgBtnRefreshSystemSettings);
            this.splitContainer2.Panel2.Controls.Add(this.pnlWarning);
            this.splitContainer2.Panel2.Controls.Add(this.imgBtnReturn);
            this.splitContainer2.Panel2.Controls.Add(this.imgBtnResetSystemSettings);
            this.splitContainer2.Panel2.Controls.Add(this.imgBtnSaveSystemSettings);
            // 
            // securitySettings1
            // 
            this.securitySettings1.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            resources.ApplyResources(this.securitySettings1, "securitySettings1");
            this.securitySettings1.Name = "securitySettings1";
            this.securitySettings1.Tag = "1";
            this.securitySettings1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // gameSettings1
            // 
            resources.ApplyResources(this.gameSettings1, "gameSettings1");
            this.gameSettings1.Name = "gameSettings1";
            this.gameSettings1.Tag = "2";
            this.gameSettings1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // ndSettings1
            // 
            resources.ApplyResources(this.ndSettings1, "ndSettings1");
            this.ndSettings1.Name = "ndSettings1";
            this.ndSettings1.Tag = "8";
            this.ndSettings1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // gameSettingMayaMoney1
            // 
            resources.ApplyResources(this.gameSettingMayaMoney1, "gameSettingMayaMoney1");
            this.gameSettingMayaMoney1.Name = "gameSettingMayaMoney1";
            this.gameSettingMayaMoney1.Tag = "5";
            this.gameSettingMayaMoney1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // clientAccessControl1
            // 
            resources.ApplyResources(this.clientAccessControl1, "clientAccessControl1");
            this.clientAccessControl1.Name = "clientAccessControl1";
            this.clientAccessControl1.Tag = "6";
            this.clientAccessControl1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // picBxSaved
            // 
            resources.ApplyResources(this.picBxSaved, "picBxSaved");
            this.picBxSaved.Name = "picBxSaved";
            this.picBxSaved.TabStop = false;
            // 
            // playerSettings1
            // 
            resources.ApplyResources(this.playerSettings1, "playerSettings1");
            this.playerSettings1.Name = "playerSettings1";
            this.playerSettings1.Tag = "6";
            this.playerSettings1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // gameSettingJailBreak1
            // 
            resources.ApplyResources(this.gameSettingJailBreak1, "gameSettingJailBreak1");
            this.gameSettingJailBreak1.Name = "gameSettingJailBreak1";
            this.gameSettingJailBreak1.Tag = "4";
            this.gameSettingJailBreak1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // gameSettingCrazyBout1
            // 
            resources.ApplyResources(this.gameSettingCrazyBout1, "gameSettingCrazyBout1");
            this.gameSettingCrazyBout1.Name = "gameSettingCrazyBout1";
            this.gameSettingCrazyBout1.Tag = "3";
            this.gameSettingCrazyBout1.Enter += new System.EventHandler(this.gameSettings1_Enter);
            // 
            // imgBtnRefreshSystemSettings
            // 
            this.imgBtnRefreshSystemSettings.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnRefreshSystemSettings.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnRefreshSystemSettings, "imgBtnRefreshSystemSettings");
            this.imgBtnRefreshSystemSettings.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnRefreshSystemSettings.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnRefreshSystemSettings.Name = "imgBtnRefreshSystemSettings";
            this.imgBtnRefreshSystemSettings.UseVisualStyleBackColor = false;
            this.imgBtnRefreshSystemSettings.Click += new System.EventHandler(this.imgBtnRefreshSystemSettings_Click);
            // 
            // pnlWarning
            // 
            this.pnlWarning.BackColor = System.Drawing.Color.Transparent;
            this.pnlWarning.Controls.Add(this.label1);
            this.pnlWarning.Controls.Add(this.pictureBox1);
            resources.ApplyResources(this.pnlWarning, "pnlWarning");
            this.pnlWarning.Name = "pnlWarning";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.Warning3;
            resources.ApplyResources(this.pictureBox1, "pictureBox1");
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.TabStop = false;
            // 
            // imgBtnReturn
            // 
            this.imgBtnReturn.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnReturn.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnReturn, "imgBtnReturn");
            this.imgBtnReturn.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnReturn.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnReturn.Name = "imgBtnReturn";
            this.imgBtnReturn.UseVisualStyleBackColor = false;
            this.imgBtnReturn.Click += new System.EventHandler(this.imgBtnReturn_Click);
            // 
            // imgBtnResetSystemSettings
            // 
            this.imgBtnResetSystemSettings.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnResetSystemSettings.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnResetSystemSettings, "imgBtnResetSystemSettings");
            this.imgBtnResetSystemSettings.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnResetSystemSettings.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnResetSystemSettings.Name = "imgBtnResetSystemSettings";
            this.imgBtnResetSystemSettings.UseVisualStyleBackColor = false;
            this.imgBtnResetSystemSettings.Click += new System.EventHandler(this.imgBtnResetSystemSettings_Click);
            // 
            // imgBtnSaveSystemSettings
            // 
            this.imgBtnSaveSystemSettings.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnSaveSystemSettings.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnSaveSystemSettings, "imgBtnSaveSystemSettings");
            this.imgBtnSaveSystemSettings.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnSaveSystemSettings.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnSaveSystemSettings.Name = "imgBtnSaveSystemSettings";
            this.imgBtnSaveSystemSettings.UseVisualStyleBackColor = false;
            this.imgBtnSaveSystemSettings.Click += new System.EventHandler(this.imgBtnSaveSystemSettings_Click);
            // 
            // SystemSettings
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            resources.ApplyResources(this, "$this");
            this.Controls.Add(this.menuStrip1);
            this.Controls.Add(this.splitContainer1);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MainMenuStrip = this.menuStrip1;
            this.MaximizeBox = false;
            this.Name = "SystemSettings";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.SystemSettings_FormClosing);
            this.Load += new System.EventHandler(this.SystemSettings_Load);
            this.LocationChanged += new System.EventHandler(this.LoginFullWin_LocationChanged);
            this.VisibleChanged += new System.EventHandler(this.SystemSettings_VisibleChanged);
            this.Move += new System.EventHandler(this.SystemSettings_Move);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
            this.splitContainer2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.picBxSaved)).EndInit();
            this.pnlWarning.ResumeLayout(false);
            this.pnlWarning.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.TreeView treeView1;
        private ImageButton imgBtnResetSystemSettings;
        private ImageButton imgBtnSaveSystemSettings;
        private System.Windows.Forms.SplitContainer splitContainer2;
        public SecuritySettings securitySettings1;
        protected ImageButton imgBtnReturn;
       // private Test test1;
        private GameSettings gameSettings1;
        private System.Windows.Forms.PictureBox picBxSaved;
        private GameSettingCrazyBout gameSettingCrazyBout1;
        private GameSettingJailBreak gameSettingJailBreak1;
        private GameSettingMayaMoney gameSettingMayaMoney1;
        private PlayerSettings playerSettings1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel pnlWarning;
        private System.Windows.Forms.Label label1;
        private ClientAccessControl clientAccessControl1;
        private ImageButton imgBtnRefreshSystemSettings;
        private NDSettings ndSettings1;
    }
}