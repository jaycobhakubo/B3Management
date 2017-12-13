namespace GameTech.B3Reports.Forms
{
    partial class LoginFullWin
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LoginFullWin));
            this.txtUsername = new System.Windows.Forms.TextBox();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.btnClose = new System.Windows.Forms.Button();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.btnLogin = new System.Windows.Forms.Button();
            this.lblYourPasswordOrUsernameX = new System.Windows.Forms.Label();
            this.pnlLogIn = new System.Windows.Forms.Panel();
            this.myChkShowVKeyBoard = new MyCheckBox();
            this.pnlChangePassword = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.txtBxVerifyNewPassword = new System.Windows.Forms.TextBox();
            this.txtBxEnterNewPassword = new System.Windows.Forms.TextBox();
            this.txtBxEntCurrPassword = new System.Windows.Forms.TextBox();
            this.imgBtnSaveNewPassword = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnCancelPasswordChange = new GameTech.B3Reports.Forms.ImageButton();
            this.myChkShowVKeyBoard2 = new MyCheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.virtualKeyboard1 = new GameTech.B3Reports.Forms.VirtualKeyboard();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.pnlLogIn.SuspendLayout();
            this.pnlChangePassword.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtUsername
            // 
            this.txtUsername.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold);
            this.txtUsername.Location = new System.Drawing.Point(392, 95);
            this.txtUsername.MaxLength = 15;
            this.txtUsername.Name = "txtUsername";
            this.txtUsername.Size = new System.Drawing.Size(354, 31);
            this.txtUsername.TabIndex = 0;
            this.txtUsername.Tag = "1";
            this.txtUsername.Click += new System.EventHandler(this.txtUsername_Click);
            this.txtUsername.TextChanged += new System.EventHandler(this.txtUsername_TextChanged);
            this.txtUsername.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPassword_KeyPress);
            this.txtUsername.Validating += new System.ComponentModel.CancelEventHandler(this.txtUsername_Validating);
            // 
            // txtPassword
            // 
            this.txtPassword.BackColor = System.Drawing.Color.Gray;
            this.txtPassword.Enabled = false;
            this.txtPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold);
            this.txtPassword.Location = new System.Drawing.Point(392, 159);
            this.txtPassword.MaxLength = 15;
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = '*';
            this.txtPassword.Size = new System.Drawing.Size(354, 38);
            this.txtPassword.TabIndex = 1;
            this.txtPassword.Tag = "2";
            this.txtPassword.UseSystemPasswordChar = true;
            this.txtPassword.Click += new System.EventHandler(this.txtUsername_Click);
            this.txtPassword.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPassword_KeyPress);
            this.txtPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtPassword_Validating);
            // 
            // btnClose
            // 
            this.btnClose.BackColor = System.Drawing.Color.Transparent;
            this.btnClose.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnClose.BackgroundImage")));
            this.btnClose.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnClose.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.btnClose.FlatAppearance.BorderSize = 0;
            this.btnClose.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnClose.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Location = new System.Drawing.Point(936, 664);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(56, 56);
            this.btnClose.TabIndex = 4;
            this.btnClose.Tag = "2";
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.button2_Click);
            this.btnClose.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnMouseDown);
            this.btnClose.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnMouseUp);
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // btnLogin
            // 
            this.btnLogin.BackColor = System.Drawing.Color.Transparent;
            this.btnLogin.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnLogin.BackgroundImage")));
            this.btnLogin.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.btnLogin.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(255)))));
            this.btnLogin.FlatAppearance.BorderSize = 0;
            this.btnLogin.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnLogin.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnLogin.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLogin.Location = new System.Drawing.Point(498, 263);
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.Size = new System.Drawing.Size(248, 64);
            this.btnLogin.TabIndex = 2;
            this.btnLogin.Tag = "1";
            this.btnLogin.UseVisualStyleBackColor = false;
            this.btnLogin.Click += new System.EventHandler(this.button1_Click);
            this.btnLogin.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnMouseDown);
            this.btnLogin.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnMouseUp);
            // 
            // lblYourPasswordOrUsernameX
            // 
            this.lblYourPasswordOrUsernameX.BackColor = System.Drawing.Color.Transparent;
            this.lblYourPasswordOrUsernameX.Image = ((System.Drawing.Image)(resources.GetObject("lblYourPasswordOrUsernameX.Image")));
            this.lblYourPasswordOrUsernameX.Location = new System.Drawing.Point(384, 226);
            this.lblYourPasswordOrUsernameX.Name = "lblYourPasswordOrUsernameX";
            this.lblYourPasswordOrUsernameX.Size = new System.Drawing.Size(376, 34);
            this.lblYourPasswordOrUsernameX.TabIndex = 6;
            this.lblYourPasswordOrUsernameX.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.lblYourPasswordOrUsernameX.Visible = false;
            // 
            // pnlLogIn
            // 
            this.pnlLogIn.BackColor = System.Drawing.Color.Transparent;
            this.pnlLogIn.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pnlLogIn.BackgroundImage")));
            this.pnlLogIn.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.pnlLogIn.Controls.Add(this.txtUsername);
            this.pnlLogIn.Controls.Add(this.lblYourPasswordOrUsernameX);
            this.pnlLogIn.Controls.Add(this.txtPassword);
            this.pnlLogIn.Controls.Add(this.myChkShowVKeyBoard);
            this.pnlLogIn.Controls.Add(this.btnLogin);
            this.pnlLogIn.Location = new System.Drawing.Point(118, 68);
            this.pnlLogIn.Name = "pnlLogIn";
            this.pnlLogIn.Size = new System.Drawing.Size(793, 358);
            this.pnlLogIn.TabIndex = 7;
            this.pnlLogIn.Tag = "1";
            // 
            // myChkShowVKeyBoard
            // 
            this.myChkShowVKeyBoard.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.myChkShowVKeyBoard.Location = new System.Drawing.Point(49, 303);
            this.myChkShowVKeyBoard.Name = "myChkShowVKeyBoard";
            this.myChkShowVKeyBoard.Size = new System.Drawing.Size(156, 24);
            this.myChkShowVKeyBoard.TabIndex = 5;
            this.myChkShowVKeyBoard.Tag = "1";
            this.myChkShowVKeyBoard.Text = "Show Keyboard";
            this.myChkShowVKeyBoard.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.myChkShowVKeyBoard.UseVisualStyleBackColor = true;
            this.myChkShowVKeyBoard.CheckedChanged += new System.EventHandler(this.chkHideKeyBoard_CheckedChanged);
            // 
            // pnlChangePassword
            // 
            this.pnlChangePassword.BackColor = System.Drawing.Color.Transparent;
            this.pnlChangePassword.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pnlChangePassword.BackgroundImage")));
            this.pnlChangePassword.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.pnlChangePassword.Controls.Add(this.label1);
            this.pnlChangePassword.Controls.Add(this.txtBxVerifyNewPassword);
            this.pnlChangePassword.Controls.Add(this.txtBxEnterNewPassword);
            this.pnlChangePassword.Controls.Add(this.txtBxEntCurrPassword);
            this.pnlChangePassword.Controls.Add(this.imgBtnSaveNewPassword);
            this.pnlChangePassword.Controls.Add(this.imgBtnCancelPasswordChange);
            this.pnlChangePassword.Controls.Add(this.myChkShowVKeyBoard2);
            this.pnlChangePassword.Location = new System.Drawing.Point(120, 67);
            this.pnlChangePassword.Name = "pnlChangePassword";
            this.pnlChangePassword.Size = new System.Drawing.Size(788, 268);
            this.pnlChangePassword.TabIndex = 8;
            this.pnlChangePassword.Tag = "2";
            this.pnlChangePassword.Visible = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Red;
            this.label1.Location = new System.Drawing.Point(44, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(127, 13);
            this.label1.TabIndex = 12;
            this.label1.Text = "Your password is expired.";
            // 
            // txtBxVerifyNewPassword
            // 
            this.txtBxVerifyNewPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBxVerifyNewPassword.Location = new System.Drawing.Point(329, 140);
            this.txtBxVerifyNewPassword.MaxLength = 15;
            this.txtBxVerifyNewPassword.Name = "txtBxVerifyNewPassword";
            this.txtBxVerifyNewPassword.PasswordChar = '*';
            this.txtBxVerifyNewPassword.Size = new System.Drawing.Size(395, 35);
            this.txtBxVerifyNewPassword.TabIndex = 11;
            this.txtBxVerifyNewPassword.Tag = "5";
            this.txtBxVerifyNewPassword.UseSystemPasswordChar = true;
            this.txtBxVerifyNewPassword.Click += new System.EventHandler(this.txtBxEntCurrPassword_Click);
            this.txtBxVerifyNewPassword.TextChanged += new System.EventHandler(this.txtBxEntCurrPassword_TextChanged);
            // 
            // txtBxEnterNewPassword
            // 
            this.txtBxEnterNewPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBxEnterNewPassword.Location = new System.Drawing.Point(329, 93);
            this.txtBxEnterNewPassword.MaxLength = 15;
            this.txtBxEnterNewPassword.Name = "txtBxEnterNewPassword";
            this.txtBxEnterNewPassword.PasswordChar = '*';
            this.txtBxEnterNewPassword.Size = new System.Drawing.Size(395, 35);
            this.txtBxEnterNewPassword.TabIndex = 10;
            this.txtBxEnterNewPassword.Tag = "4";
            this.txtBxEnterNewPassword.UseSystemPasswordChar = true;
            this.txtBxEnterNewPassword.Click += new System.EventHandler(this.txtBxEntCurrPassword_Click);
            this.txtBxEnterNewPassword.TextChanged += new System.EventHandler(this.txtBxEntCurrPassword_TextChanged);
            // 
            // txtBxEntCurrPassword
            // 
            this.txtBxEntCurrPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F);
            this.txtBxEntCurrPassword.Location = new System.Drawing.Point(329, 46);
            this.txtBxEntCurrPassword.MaxLength = 15;
            this.txtBxEntCurrPassword.Name = "txtBxEntCurrPassword";
            this.txtBxEntCurrPassword.PasswordChar = '*';
            this.txtBxEntCurrPassword.Size = new System.Drawing.Size(395, 35);
            this.txtBxEntCurrPassword.TabIndex = 9;
            this.txtBxEntCurrPassword.Tag = "3";
            this.txtBxEntCurrPassword.UseSystemPasswordChar = true;
            this.txtBxEntCurrPassword.Click += new System.EventHandler(this.txtBxEntCurrPassword_Click);
            this.txtBxEntCurrPassword.TextChanged += new System.EventHandler(this.txtBxEntCurrPassword_TextChanged);
            // 
            // imgBtnSaveNewPassword
            // 
            this.imgBtnSaveNewPassword.FocusColor = System.Drawing.Color.Black;
            this.imgBtnSaveNewPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.imgBtnSaveNewPassword.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtnSaveNewPassword.ImageNormal")));
            this.imgBtnSaveNewPassword.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtnSaveNewPassword.ImagePressed")));
            this.imgBtnSaveNewPassword.Location = new System.Drawing.Point(334, 207);
            this.imgBtnSaveNewPassword.MinimumSize = new System.Drawing.Size(30, 30);
            this.imgBtnSaveNewPassword.Name = "imgBtnSaveNewPassword";
            this.imgBtnSaveNewPassword.Size = new System.Drawing.Size(105, 40);
            this.imgBtnSaveNewPassword.TabIndex = 8;
            this.imgBtnSaveNewPassword.Tag = "1";
            this.imgBtnSaveNewPassword.Text = "Save";
            this.imgBtnSaveNewPassword.Click += new System.EventHandler(this.imgBtnSaveNewPassword_Click);
            // 
            // imgBtnCancelPasswordChange
            // 
            this.imgBtnCancelPasswordChange.FocusColor = System.Drawing.Color.Black;
            this.imgBtnCancelPasswordChange.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.imgBtnCancelPasswordChange.ImageNormal = ((System.Drawing.Image)(resources.GetObject("imgBtnCancelPasswordChange.ImageNormal")));
            this.imgBtnCancelPasswordChange.ImagePressed = ((System.Drawing.Image)(resources.GetObject("imgBtnCancelPasswordChange.ImagePressed")));
            this.imgBtnCancelPasswordChange.Location = new System.Drawing.Point(619, 207);
            this.imgBtnCancelPasswordChange.MinimumSize = new System.Drawing.Size(30, 30);
            this.imgBtnCancelPasswordChange.Name = "imgBtnCancelPasswordChange";
            this.imgBtnCancelPasswordChange.Size = new System.Drawing.Size(105, 40);
            this.imgBtnCancelPasswordChange.TabIndex = 7;
            this.imgBtnCancelPasswordChange.Tag = "2";
            this.imgBtnCancelPasswordChange.Text = "Cancel";
            this.imgBtnCancelPasswordChange.Click += new System.EventHandler(this.imageButton1_Click);
            // 
            // myChkShowVKeyBoard2
            // 
            this.myChkShowVKeyBoard2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.myChkShowVKeyBoard2.ForeColor = System.Drawing.Color.White;
            this.myChkShowVKeyBoard2.Location = new System.Drawing.Point(47, 226);
            this.myChkShowVKeyBoard2.Name = "myChkShowVKeyBoard2";
            this.myChkShowVKeyBoard2.Size = new System.Drawing.Size(156, 24);
            this.myChkShowVKeyBoard2.TabIndex = 6;
            this.myChkShowVKeyBoard2.Tag = "2";
            this.myChkShowVKeyBoard2.Text = "Show Keyboard";
            this.myChkShowVKeyBoard2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.myChkShowVKeyBoard2.UseVisualStyleBackColor = true;
            this.myChkShowVKeyBoard2.CheckedChanged += new System.EventHandler(this.chkHideKeyBoard_CheckedChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.Transparent;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.White;
            this.label2.Location = new System.Drawing.Point(6, 751);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(0, 12);
            this.label2.TabIndex = 9;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.Transparent;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.White;
            this.label3.Location = new System.Drawing.Point(792, 751);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(0, 12);
            this.label3.TabIndex = 10;
            // 
            // virtualKeyboard1
            // 
            this.virtualKeyboard1.BackColor = System.Drawing.Color.White;
            this.virtualKeyboard1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.virtualKeyboard1.ButtonForeColor = System.Drawing.Color.Blue;
            this.virtualKeyboard1.ForeColor = System.Drawing.Color.Magenta;
            this.virtualKeyboard1.Location = new System.Drawing.Point(136, 432);
            this.virtualKeyboard1.Name = "virtualKeyboard1";
            this.virtualKeyboard1.Size = new System.Drawing.Size(750, 250);
            this.virtualKeyboard1.TabIndex = 3;
            this.virtualKeyboard1.Visible = false;
            this.virtualKeyboard1.KeyPressed += new GameTech.B3Reports.Forms.KeyboardEventHandler(this.virtualKeyboard1_KeyPressed);
            // 
            // LoginFullWin
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.pnlLogIn);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.virtualKeyboard1);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.pnlChangePassword);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "LoginFullWin";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.LoginFullWin_FormClosing);
            this.LocationChanged += new System.EventHandler(this.LoginFullWin_LocationChanged);
            this.VisibleChanged += new System.EventHandler(this.LoginFullWin_VisibleChanged);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.pnlLogIn.ResumeLayout(false);
            this.pnlLogIn.PerformLayout();
            this.pnlChangePassword.ResumeLayout(false);
            this.pnlChangePassword.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtUsername;
        private System.Windows.Forms.TextBox txtPassword;
        private VirtualKeyboard virtualKeyboard1;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.Button btnLogin;
        private MyCheckBox myChkShowVKeyBoard;
        private System.Windows.Forms.Label lblYourPasswordOrUsernameX;
        private MyCheckBox myChkShowVKeyBoard2;
        private ImageButton imgBtnCancelPasswordChange;
        private System.Windows.Forms.TextBox txtBxVerifyNewPassword;
        private System.Windows.Forms.TextBox txtBxEnterNewPassword;
        private System.Windows.Forms.TextBox txtBxEntCurrPassword;
        private ImageButton imgBtnSaveNewPassword;
        public System.Windows.Forms.Button btnClose;
        public System.Windows.Forms.Label label1;
        public System.Windows.Forms.Panel pnlChangePassword;
        public System.Windows.Forms.Panel pnlLogIn;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
    }
}