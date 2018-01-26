namespace GameTech.B3Reports.Forms
{
    partial class NewMenu
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NewMenu));
            this.label2 = new System.Windows.Forms.Label();
            this.btnExit = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.CheckIdleTimer = new System.Windows.Forms.Timer(this.components);
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.AccountRecoveryButton = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtn_Reports = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnSecurity = new GameTech.B3Reports.Forms.ImageButton();
            this.imageButton1 = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnChangePassword = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnSettings = new GameTech.B3Reports.Forms.ImageButton();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.label2, "label2");
            this.label2.ForeColor = System.Drawing.Color.White;
            this.label2.Name = "label2";
            // 
            // btnExit
            // 
            this.btnExit.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnExit, "btnExit");
            this.btnExit.FlatAppearance.BorderColor = System.Drawing.Color.Gray;
            this.btnExit.FlatAppearance.BorderSize = 0;
            this.btnExit.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnExit.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnExit.Name = "btnExit";
            this.btnExit.Tag = "5";
            this.btnExit.UseVisualStyleBackColor = false;
            this.btnExit.Click += new System.EventHandler(this.btnLogout);
            this.btnExit.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnMouseDown);
            this.btnExit.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnMouseUp);
            // 
            // label3
            // 
            this.label3.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.label3, "label3");
            this.label3.ForeColor = System.Drawing.Color.White;
            this.label3.Name = "label3";
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.pictureBox1, "pictureBox1");
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.TabStop = false;
            // 
            // label4
            // 
            this.label4.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.label4, "label4");
            this.label4.ForeColor = System.Drawing.Color.White;
            this.label4.Name = "label4";
            // 
            // label5
            // 
            this.label5.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.label5, "label5");
            this.label5.ForeColor = System.Drawing.Color.White;
            this.label5.Name = "label5";
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.label1, "label1");
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Name = "label1";
            // 
            // AccountRecoveryButton
            // 
            this.AccountRecoveryButton.BackColor = System.Drawing.Color.Transparent;
            this.AccountRecoveryButton.FocusColor = System.Drawing.Color.Black;
            this.AccountRecoveryButton.ImageIcon = global::GameTech.B3Reports.Properties.Resources.Unlock80x80;
            this.AccountRecoveryButton.ImageNormal = ((System.Drawing.Image)(resources.GetObject("AccountRecoveryButton.ImageNormal")));
            this.AccountRecoveryButton.ImagePressed = ((System.Drawing.Image)(resources.GetObject("AccountRecoveryButton.ImagePressed")));
            resources.ApplyResources(this.AccountRecoveryButton, "AccountRecoveryButton");
            this.AccountRecoveryButton.Name = "AccountRecoveryButton";
            this.AccountRecoveryButton.Tag = "Account Recovery";
            this.AccountRecoveryButton.UseVisualStyleBackColor = false;
            this.AccountRecoveryButton.Click += new System.EventHandler(this.AccountRecoveryButton_Click);
            // 
            // imgBtn_Reports
            // 
            this.imgBtn_Reports.BackColor = System.Drawing.Color.Transparent;
            this.imgBtn_Reports.FocusColor = System.Drawing.Color.Black;
            this.imgBtn_Reports.ImageIcon = ((System.Drawing.Image)(resources.GetObject("imgBtn_Reports.ImageIcon")));
            this.imgBtn_Reports.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtn_Reports.ImageNormal")));
            this.imgBtn_Reports.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtn_Reports.ImagePressed")));
            resources.ApplyResources(this.imgBtn_Reports, "imgBtn_Reports");
            this.imgBtn_Reports.Name = "imgBtn_Reports";
            this.imgBtn_Reports.Tag = "Reports";
            this.imgBtn_Reports.UseVisualStyleBackColor = false;
            this.imgBtn_Reports.Click += new System.EventHandler(this.imgBtn_Reports_Click);
            // 
            // imgBtnSecurity
            // 
            this.imgBtnSecurity.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnSecurity.FocusColor = System.Drawing.Color.Black;
            this.imgBtnSecurity.ImageIcon = ((System.Drawing.Image)(resources.GetObject("imgBtnSecurity.ImageIcon")));
            this.imgBtnSecurity.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtnSecurity.ImageNormal")));
            this.imgBtnSecurity.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtnSecurity.ImagePressed")));
            resources.ApplyResources(this.imgBtnSecurity, "imgBtnSecurity");
            this.imgBtnSecurity.Name = "imgBtnSecurity";
            this.imgBtnSecurity.Tag = "Security";
            this.imgBtnSecurity.UseVisualStyleBackColor = false;
            this.imgBtnSecurity.Click += new System.EventHandler(this.imgBtn_Settings_Click);
            // 
            // imageButton1
            // 
            this.imageButton1.BackColor = System.Drawing.Color.Transparent;
            this.imageButton1.FocusColor = System.Drawing.Color.Black;
            this.imageButton1.ImageIcon = ((System.Drawing.Image)(resources.GetObject("imageButton1.ImageIcon")));
            this.imageButton1.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imageButton1.ImageNormal")));
            this.imageButton1.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imageButton1.ImagePressed")));
            resources.ApplyResources(this.imageButton1, "imageButton1");
            this.imageButton1.Name = "imageButton1";
            this.imageButton1.Tag = "Dispute Resolution";
            this.imageButton1.UseVisualStyleBackColor = false;
            this.imageButton1.Click += new System.EventHandler(this.imageButton1_Click);
            // 
            // imgBtnChangePassword
            // 
            this.imgBtnChangePassword.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnChangePassword.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnChangePassword, "imgBtnChangePassword");
            this.imgBtnChangePassword.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtnChangePassword.ImageNormal")));
            this.imgBtnChangePassword.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtnChangePassword.ImagePressed")));
            this.imgBtnChangePassword.Name = "imgBtnChangePassword";
            this.imgBtnChangePassword.UseVisualStyleBackColor = false;
            this.imgBtnChangePassword.Click += new System.EventHandler(this.imgBtnChangePassword_Click);
            // 
            // imgBtnSettings
            // 
            this.imgBtnSettings.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnSettings.FocusColor = System.Drawing.Color.Black;
            this.imgBtnSettings.ImageIcon = ((System.Drawing.Image)(resources.GetObject("imgBtnSettings.ImageIcon")));
            this.imgBtnSettings.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtnSettings.ImageNormal")));
            this.imgBtnSettings.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtnSettings.ImagePressed")));
            resources.ApplyResources(this.imgBtnSettings, "imgBtnSettings");
            this.imgBtnSettings.Name = "imgBtnSettings";
            this.imgBtnSettings.Tag = "System Settings";
            this.imgBtnSettings.UseVisualStyleBackColor = false;
            this.imgBtnSettings.Click += new System.EventHandler(this.imgBtnSettings_Click);
            // 
            // NewMenu
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            resources.ApplyResources(this, "$this");
            this.Controls.Add(this.label1);
            this.Controls.Add(this.AccountRecoveryButton);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.imgBtn_Reports);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.imageButton1);
            this.Controls.Add(this.imgBtnChangePassword);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.imgBtnSettings);
            this.Controls.Add(this.btnExit);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.imgBtnSecurity);
            this.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "NewMenu";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.NewMenu_FormClosing);
            this.Load += new System.EventHandler(this.NewMenu_Load);
            this.LocationChanged += new System.EventHandler(this.LoginFullWin_LocationChanged);
            this.VisibleChanged += new System.EventHandler(this.NewMenu_VisibleChanged);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private ImageButton imgBtnSecurity;
        private ImageButton imgBtn_Reports;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnExit;
        private ImageButton imgBtnSettings;
        private System.Windows.Forms.Label label3;
        public System.Windows.Forms.Timer CheckIdleTimer;
        private System.Windows.Forms.PictureBox pictureBox1;
        private ImageButton imgBtnChangePassword;
        private ImageButton imageButton1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private ImageButton AccountRecoveryButton;
        private System.Windows.Forms.Label label1;
    }
}

