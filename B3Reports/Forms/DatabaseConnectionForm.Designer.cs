namespace GameTech.B3Reports.Forms
{
    partial class DatabaseConnectionForm
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
            this.txtbxDatabasePassword = new System.Windows.Forms.TextBox();
            this.lblDatabasePassword = new System.Windows.Forms.Label();
            this.txtbxDatabaseUser = new System.Windows.Forms.TextBox();
            this.lblDatabaseUser = new System.Windows.Forms.Label();
            this.txtbxDatabaseName = new System.Windows.Forms.TextBox();
            this.lblDatabaseName = new System.Windows.Forms.Label();
            this.txtbxDatabaseServer = new System.Windows.Forms.TextBox();
            this.lblDatabaseServer = new System.Windows.Forms.Label();
            this.pnlWarning = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.lblB3DatabaseConnection = new System.Windows.Forms.Label();
            this.lblConnecting = new System.Windows.Forms.Label();
            this.imgBtnConnect = new GameTech.B3Reports.Forms.ImageButton();
            this.pnlWarning.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // txtbxDatabasePassword
            // 
            this.txtbxDatabasePassword.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.txtbxDatabasePassword.Location = new System.Drawing.Point(168, 144);
            this.txtbxDatabasePassword.MaxLength = 15;
            this.txtbxDatabasePassword.Name = "txtbxDatabasePassword";
            this.txtbxDatabasePassword.Size = new System.Drawing.Size(200, 26);
            this.txtbxDatabasePassword.TabIndex = 54;
            this.txtbxDatabasePassword.TextChanged += new System.EventHandler(this.txtbx_TextChanged);
            this.txtbxDatabasePassword.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtbx_PasswordKeyPress);
            // 
            // lblDatabasePassword
            // 
            this.lblDatabasePassword.AutoSize = true;
            this.lblDatabasePassword.BackColor = System.Drawing.Color.Transparent;
            this.lblDatabasePassword.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.lblDatabasePassword.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblDatabasePassword.Location = new System.Drawing.Point(17, 147);
            this.lblDatabasePassword.Name = "lblDatabasePassword";
            this.lblDatabasePassword.Size = new System.Drawing.Size(145, 22);
            this.lblDatabasePassword.TabIndex = 53;
            this.lblDatabasePassword.Text = "Database Password";
            // 
            // txtbxDatabaseUser
            // 
            this.txtbxDatabaseUser.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.txtbxDatabaseUser.Location = new System.Drawing.Point(168, 112);
            this.txtbxDatabaseUser.MaxLength = 15;
            this.txtbxDatabaseUser.Name = "txtbxDatabaseUser";
            this.txtbxDatabaseUser.Size = new System.Drawing.Size(200, 26);
            this.txtbxDatabaseUser.TabIndex = 52;
            this.txtbxDatabaseUser.TextChanged += new System.EventHandler(this.txtbx_TextChanged);
            this.txtbxDatabaseUser.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtbx_KeyPress);
            // 
            // lblDatabaseUser
            // 
            this.lblDatabaseUser.AutoSize = true;
            this.lblDatabaseUser.BackColor = System.Drawing.Color.Transparent;
            this.lblDatabaseUser.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.lblDatabaseUser.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblDatabaseUser.Location = new System.Drawing.Point(52, 115);
            this.lblDatabaseUser.Name = "lblDatabaseUser";
            this.lblDatabaseUser.Size = new System.Drawing.Size(110, 22);
            this.lblDatabaseUser.TabIndex = 51;
            this.lblDatabaseUser.Text = "Database User";
            // 
            // txtbxDatabaseName
            // 
            this.txtbxDatabaseName.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.txtbxDatabaseName.Location = new System.Drawing.Point(168, 80);
            this.txtbxDatabaseName.MaxLength = 15;
            this.txtbxDatabaseName.Name = "txtbxDatabaseName";
            this.txtbxDatabaseName.ReadOnly = true;
            this.txtbxDatabaseName.Size = new System.Drawing.Size(200, 26);
            this.txtbxDatabaseName.TabIndex = 50;
            this.txtbxDatabaseName.TextChanged += new System.EventHandler(this.txtbx_TextChanged);
            this.txtbxDatabaseName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtbx_KeyPress);
            // 
            // lblDatabaseName
            // 
            this.lblDatabaseName.AutoSize = true;
            this.lblDatabaseName.BackColor = System.Drawing.Color.Transparent;
            this.lblDatabaseName.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.lblDatabaseName.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblDatabaseName.Location = new System.Drawing.Point(43, 83);
            this.lblDatabaseName.Name = "lblDatabaseName";
            this.lblDatabaseName.Size = new System.Drawing.Size(119, 22);
            this.lblDatabaseName.TabIndex = 49;
            this.lblDatabaseName.Text = "Database Name";
            // 
            // txtbxDatabaseServer
            // 
            this.txtbxDatabaseServer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.txtbxDatabaseServer.Location = new System.Drawing.Point(168, 48);
            this.txtbxDatabaseServer.MaxLength = 15;
            this.txtbxDatabaseServer.Name = "txtbxDatabaseServer";
            this.txtbxDatabaseServer.Size = new System.Drawing.Size(200, 26);
            this.txtbxDatabaseServer.TabIndex = 48;
            this.txtbxDatabaseServer.TextChanged += new System.EventHandler(this.txtbx_TextChanged);
            this.txtbxDatabaseServer.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtbx_KeyPress);
            // 
            // lblDatabaseServer
            // 
            this.lblDatabaseServer.AutoSize = true;
            this.lblDatabaseServer.BackColor = System.Drawing.Color.Transparent;
            this.lblDatabaseServer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.lblDatabaseServer.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblDatabaseServer.Location = new System.Drawing.Point(36, 51);
            this.lblDatabaseServer.Name = "lblDatabaseServer";
            this.lblDatabaseServer.Size = new System.Drawing.Size(126, 22);
            this.lblDatabaseServer.TabIndex = 47;
            this.lblDatabaseServer.Text = "Database Server";
            // 
            // pnlWarning
            // 
            this.pnlWarning.BackColor = System.Drawing.Color.Transparent;
            this.pnlWarning.Controls.Add(this.label3);
            this.pnlWarning.Controls.Add(this.pictureBox1);
            this.pnlWarning.Location = new System.Drawing.Point(50, 188);
            this.pnlWarning.Name = "pnlWarning";
            this.pnlWarning.Size = new System.Drawing.Size(285, 42);
            this.pnlWarning.TabIndex = 57;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F);
            this.label3.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label3.Location = new System.Drawing.Point(48, 6);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(226, 30);
            this.label3.TabIndex = 31;
            this.label3.Text = "Unable to connect to the database using\r\n the credentials";
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.Warning3;
            this.pictureBox1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox1.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.pictureBox1.Location = new System.Drawing.Point(2, 4);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(40, 34);
            this.pictureBox1.TabIndex = 30;
            this.pictureBox1.TabStop = false;
            // 
            // lblB3DatabaseConnection
            // 
            this.lblB3DatabaseConnection.AutoSize = true;
            this.lblB3DatabaseConnection.BackColor = System.Drawing.Color.Transparent;
            this.lblB3DatabaseConnection.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.lblB3DatabaseConnection.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblB3DatabaseConnection.Location = new System.Drawing.Point(103, 12);
            this.lblB3DatabaseConnection.Name = "lblB3DatabaseConnection";
            this.lblB3DatabaseConnection.Size = new System.Drawing.Size(179, 22);
            this.lblB3DatabaseConnection.TabIndex = 58;
            this.lblB3DatabaseConnection.Text = "B3 Database connection";
            // 
            // lblConnecting
            // 
            this.lblConnecting.AutoSize = true;
            this.lblConnecting.BackColor = System.Drawing.Color.Transparent;
            this.lblConnecting.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F);
            this.lblConnecting.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblConnecting.Location = new System.Drawing.Point(157, 212);
            this.lblConnecting.Name = "lblConnecting";
            this.lblConnecting.Size = new System.Drawing.Size(76, 15);
            this.lblConnecting.TabIndex = 59;
            this.lblConnecting.Text = "connecting...";
            // 
            // imgBtnConnect
            // 
            this.imgBtnConnect.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnConnect.FocusColor = System.Drawing.Color.Black;
            this.imgBtnConnect.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold);
            this.imgBtnConnect.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnConnect.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnConnect.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.imgBtnConnect.Location = new System.Drawing.Point(117, 236);
            this.imgBtnConnect.MinimumSize = new System.Drawing.Size(30, 30);
            this.imgBtnConnect.Name = "imgBtnConnect";
            this.imgBtnConnect.Size = new System.Drawing.Size(150, 40);
            this.imgBtnConnect.TabIndex = 56;
            this.imgBtnConnect.Text = "Connect";
            this.imgBtnConnect.UseVisualStyleBackColor = false;
            this.imgBtnConnect.Click += new System.EventHandler(this.imgBtnConnect_Click);
            // 
            // DatabaseConnectionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(384, 292);
            this.Controls.Add(this.lblConnecting);
            this.Controls.Add(this.lblB3DatabaseConnection);
            this.Controls.Add(this.pnlWarning);
            this.Controls.Add(this.imgBtnConnect);
            this.Controls.Add(this.txtbxDatabasePassword);
            this.Controls.Add(this.lblDatabasePassword);
            this.Controls.Add(this.txtbxDatabaseUser);
            this.Controls.Add(this.lblDatabaseUser);
            this.Controls.Add(this.txtbxDatabaseName);
            this.Controls.Add(this.lblDatabaseName);
            this.Controls.Add(this.txtbxDatabaseServer);
            this.Controls.Add(this.lblDatabaseServer);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "DatabaseConnectionForm";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Database Connection";
            this.Load += new System.EventHandler(this.DatabaseConnectionForm_Load);
            this.pnlWarning.ResumeLayout(false);
            this.pnlWarning.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtbxDatabasePassword;
        private System.Windows.Forms.Label lblDatabasePassword;
        private System.Windows.Forms.TextBox txtbxDatabaseUser;
        private System.Windows.Forms.Label lblDatabaseUser;
        private System.Windows.Forms.TextBox txtbxDatabaseName;
        private System.Windows.Forms.Label lblDatabaseName;
        private System.Windows.Forms.TextBox txtbxDatabaseServer;
        private System.Windows.Forms.Label lblDatabaseServer;
        protected ImageButton imgBtnConnect;
        private System.Windows.Forms.Panel pnlWarning;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label lblB3DatabaseConnection;
        private System.Windows.Forms.Label lblConnecting;
    }
}