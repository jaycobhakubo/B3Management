namespace GameTech.B3Reports.Forms
{
    partial class GameSettings
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.numericUpDownGameThreads = new System.Windows.Forms.NumericUpDown();
            this.label9 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.txtbxGameRecallPassword = new System.Windows.Forms.TextBox();
            this.lblMinimumNumOfPlayersSec = new System.Windows.Forms.Label();
            this.numWaitCountdownTimerOP = new System.Windows.Forms.NumericUpDown();
            this.lblMinNumPlayersTime = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.lblCountdownTimerSec = new System.Windows.Forms.Label();
            this.lblExtraBonusDollarSign = new System.Windows.Forms.Label();
            this.numericTextBoxWDecimal1 = new GameTech.B3Reports.CustomControls.NumericTextBoxWDecimal();
            this.numCountdownTimer = new System.Windows.Forms.NumericUpDown();
            this.lblCountdownTimer = new System.Windows.Forms.Label();
            this.lblExtraBonus = new System.Windows.Forms.Label();
            this.numMinimumPlayer = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGameThreads)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.numericUpDownGameThreads);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.txtbxGameRecallPassword);
            this.groupBox1.Controls.Add(this.lblMinimumNumOfPlayersSec);
            this.groupBox1.Controls.Add(this.numWaitCountdownTimerOP);
            this.groupBox1.Controls.Add(this.lblMinNumPlayersTime);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.lblCountdownTimerSec);
            this.groupBox1.Controls.Add(this.lblExtraBonusDollarSign);
            this.groupBox1.Controls.Add(this.numericTextBoxWDecimal1);
            this.groupBox1.Controls.Add(this.numCountdownTimer);
            this.groupBox1.Controls.Add(this.lblCountdownTimer);
            this.groupBox1.Controls.Add(this.lblExtraBonus);
            this.groupBox1.Controls.Add(this.numMinimumPlayer);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(24, 25);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(771, 602);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Server Game Settings";
            // 
            // numericUpDownGameThreads
            // 
            this.numericUpDownGameThreads.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numericUpDownGameThreads.Location = new System.Drawing.Point(504, 144);
            this.numericUpDownGameThreads.Maximum = new decimal(new int[] {
            16,
            0,
            0,
            0});
            this.numericUpDownGameThreads.Minimum = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.numericUpDownGameThreads.Name = "numericUpDownGameThreads";
            this.numericUpDownGameThreads.Size = new System.Drawing.Size(120, 26);
            this.numericUpDownGameThreads.TabIndex = 41;
            this.numericUpDownGameThreads.Tag = "1";
            this.numericUpDownGameThreads.Value = new decimal(new int[] {
            5,
            0,
            0,
            0});
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label9.Location = new System.Drawing.Point(76, 144);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(112, 22);
            this.label9.TabIndex = 40;
            this.label9.Text = "Game Threads";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(6, 536);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(310, 72);
            this.textBox1.TabIndex = 39;
            this.textBox1.Text = "Group Box\r\n24, 25\r\n771, 602\r\n\r\nContent\r\n76, 44\t\t526, 40\r\n76, 87(43)\t\t526, 83(43)\r" +
    "\n76, 130(43)\t526, 126(43)\r\n76, 173(43)\t526, 169(43)\r\n76, 216(43)\t526, 212(43)\t\r\n" +
    "76, 259(43)";
            this.textBox1.Visible = false;
            // 
            // txtbxGameRecallPassword
            // 
            this.txtbxGameRecallPassword.Location = new System.Drawing.Point(504, 96);
            this.txtbxGameRecallPassword.MaxLength = 15;
            this.txtbxGameRecallPassword.Name = "txtbxGameRecallPassword";
            this.txtbxGameRecallPassword.Size = new System.Drawing.Size(120, 26);
            this.txtbxGameRecallPassword.TabIndex = 38;
            this.txtbxGameRecallPassword.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.txtbxGameRecallPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtbxGameRecallPassword_Validating);
            // 
            // lblMinimumNumOfPlayersSec
            // 
            this.lblMinimumNumOfPlayersSec.AutoSize = true;
            this.lblMinimumNumOfPlayersSec.BackColor = System.Drawing.Color.White;
            this.lblMinimumNumOfPlayersSec.Location = new System.Drawing.Point(624, 241);
            this.lblMinimumNumOfPlayersSec.Name = "lblMinimumNumOfPlayersSec";
            this.lblMinimumNumOfPlayersSec.Size = new System.Drawing.Size(33, 22);
            this.lblMinimumNumOfPlayersSec.TabIndex = 37;
            this.lblMinimumNumOfPlayersSec.Text = "sec";
            // 
            // numWaitCountdownTimerOP
            // 
            this.numWaitCountdownTimerOP.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numWaitCountdownTimerOP.Location = new System.Drawing.Point(504, 240);
            this.numWaitCountdownTimerOP.Name = "numWaitCountdownTimerOP";
            this.numWaitCountdownTimerOP.Size = new System.Drawing.Size(120, 26);
            this.numWaitCountdownTimerOP.TabIndex = 36;
            this.numWaitCountdownTimerOP.Tag = "2";
            this.numWaitCountdownTimerOP.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numWaitCountdownTimerOP.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numWaitCountdownTimerOP.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // lblMinNumPlayersTime
            // 
            this.lblMinNumPlayersTime.AutoSize = true;
            this.lblMinNumPlayersTime.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblMinNumPlayersTime.Location = new System.Drawing.Point(76, 240);
            this.lblMinNumPlayersTime.Name = "lblMinNumPlayersTime";
            this.lblMinNumPlayersTime.Size = new System.Drawing.Size(288, 22);
            this.lblMinNumPlayersTime.TabIndex = 35;
            this.lblMinNumPlayersTime.Text = "Minimum Number of Players Wait Time";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label6.Location = new System.Drawing.Point(76, 96);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(169, 22);
            this.label6.TabIndex = 34;
            this.label6.Text = "Game Recall Password";
            // 
            // lblCountdownTimerSec
            // 
            this.lblCountdownTimerSec.AutoSize = true;
            this.lblCountdownTimerSec.BackColor = System.Drawing.Color.White;
            this.lblCountdownTimerSec.Location = new System.Drawing.Point(624, 194);
            this.lblCountdownTimerSec.Name = "lblCountdownTimerSec";
            this.lblCountdownTimerSec.Size = new System.Drawing.Size(33, 22);
            this.lblCountdownTimerSec.TabIndex = 33;
            this.lblCountdownTimerSec.Text = "sec";
            // 
            // lblExtraBonusDollarSign
            // 
            this.lblExtraBonusDollarSign.BackColor = System.Drawing.SystemColors.Control;
            this.lblExtraBonusDollarSign.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lblExtraBonusDollarSign.Location = new System.Drawing.Point(504, 288);
            this.lblExtraBonusDollarSign.Name = "lblExtraBonusDollarSign";
            this.lblExtraBonusDollarSign.Size = new System.Drawing.Size(20, 26);
            this.lblExtraBonusDollarSign.TabIndex = 32;
            this.lblExtraBonusDollarSign.Text = "$";
            // 
            // numericTextBoxWDecimal1
            // 
            this.numericTextBoxWDecimal1.AllowSpace = false;
            this.numericTextBoxWDecimal1.BackColor = System.Drawing.SystemColors.Window;
            this.numericTextBoxWDecimal1.Location = new System.Drawing.Point(528, 288);
            this.numericTextBoxWDecimal1.MaxLength = 7;
            this.numericTextBoxWDecimal1.Name = "numericTextBoxWDecimal1";
            this.numericTextBoxWDecimal1.ReadOnly = true;
            this.numericTextBoxWDecimal1.Size = new System.Drawing.Size(96, 26);
            this.numericTextBoxWDecimal1.TabIndex = 31;
            this.numericTextBoxWDecimal1.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numericTextBoxWDecimal1.Validating += new System.ComponentModel.CancelEventHandler(this.numericTextBoxWDecimal1_Validating);
            // 
            // numCountdownTimer
            // 
            this.numCountdownTimer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numCountdownTimer.Location = new System.Drawing.Point(504, 192);
            this.numCountdownTimer.Name = "numCountdownTimer";
            this.numCountdownTimer.Size = new System.Drawing.Size(120, 26);
            this.numCountdownTimer.TabIndex = 30;
            this.numCountdownTimer.Tag = "3";
            this.numCountdownTimer.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numCountdownTimer.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numCountdownTimer.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // lblCountdownTimer
            // 
            this.lblCountdownTimer.AutoSize = true;
            this.lblCountdownTimer.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblCountdownTimer.Location = new System.Drawing.Point(76, 192);
            this.lblCountdownTimer.Name = "lblCountdownTimer";
            this.lblCountdownTimer.Size = new System.Drawing.Size(137, 22);
            this.lblCountdownTimer.TabIndex = 29;
            this.lblCountdownTimer.Text = "Countdown Timer";
            // 
            // lblExtraBonus
            // 
            this.lblExtraBonus.AutoSize = true;
            this.lblExtraBonus.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblExtraBonus.Location = new System.Drawing.Point(76, 288);
            this.lblExtraBonus.Name = "lblExtraBonus";
            this.lblExtraBonus.Size = new System.Drawing.Size(92, 22);
            this.lblExtraBonus.TabIndex = 27;
            this.lblExtraBonus.Text = "Extra Bonus";
            // 
            // numMinimumPlayer
            // 
            this.numMinimumPlayer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numMinimumPlayer.Location = new System.Drawing.Point(504, 48);
            this.numMinimumPlayer.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.numMinimumPlayer.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numMinimumPlayer.Name = "numMinimumPlayer";
            this.numMinimumPlayer.Size = new System.Drawing.Size(120, 26);
            this.numMinimumPlayer.TabIndex = 26;
            this.numMinimumPlayer.Tag = "1";
            this.numMinimumPlayer.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.numMinimumPlayer.ValueChanged += new System.EventHandler(this.numMinimumPlayer_ValueChanged);
            this.numMinimumPlayer.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numMinimumPlayer.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label2.Location = new System.Drawing.Point(76, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(208, 22);
            this.label2.TabIndex = 25;
            this.label2.Text = "Minimum Number of Players";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // GameSettings
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupBox1);
            this.Name = "GameSettings";
            this.Size = new System.Drawing.Size(810, 644);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGameThreads)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.NumericUpDown numCountdownTimer;
        private System.Windows.Forms.Label lblCountdownTimer;
        private System.Windows.Forms.Label lblExtraBonus;
        private CustomControls.NumericTextBoxWDecimal numericTextBoxWDecimal1;
        private System.Windows.Forms.Label lblCountdownTimerSec;
        private System.Windows.Forms.Label lblExtraBonusDollarSign;
        private System.Windows.Forms.Label lblMinimumNumOfPlayersSec;
        private System.Windows.Forms.NumericUpDown numWaitCountdownTimerOP;
        private System.Windows.Forms.Label lblMinNumPlayersTime;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtbxGameRecallPassword;
        public System.Windows.Forms.NumericUpDown numMinimumPlayer;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox textBox1;
        public System.Windows.Forms.NumericUpDown numericUpDownGameThreads;
        private System.Windows.Forms.Label label9;

    }
}
