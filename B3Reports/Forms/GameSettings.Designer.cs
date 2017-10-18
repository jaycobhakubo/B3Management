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
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.txtbxGameRecallPassword = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.numWaitCountdownTimerOP = new System.Windows.Forms.NumericUpDown();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.numericTextBoxWDecimal1 = new GameTech.B3Reports.CustomControls.NumericTextBoxWDecimal();
            this.numCountdownTimer = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.numMinimumPlayer = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.txtbxGameRecallPassword);
            this.groupBox1.Controls.Add(this.label8);
            this.groupBox1.Controls.Add(this.numWaitCountdownTimerOP);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.numericTextBoxWDecimal1);
            this.groupBox1.Controls.Add(this.numCountdownTimer);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
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
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(6, 343);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(310, 265);
            this.textBox1.TabIndex = 39;
            this.textBox1.Text = "Group Box\r\n24, 25\r\n771, 602\r\n\r\nContent\r\n76, 44\t\t526, 40\r\n76, 87(43)\t\t526, 83(43)\r" +
    "\n76, 130(43)\t526, 126(43)\r\n76, 173(43)\t526, 169(43)\r\n76, 216(43)\t526, 212(43)\t\r\n" +
    "76, 259(43)";
            this.textBox1.Visible = false;
            // 
            // txtbxGameRecallPassword
            // 
            this.txtbxGameRecallPassword.Location = new System.Drawing.Point(526, 212);
            this.txtbxGameRecallPassword.MaxLength = 15;
            this.txtbxGameRecallPassword.Name = "txtbxGameRecallPassword";
            this.txtbxGameRecallPassword.Size = new System.Drawing.Size(120, 26);
            this.txtbxGameRecallPassword.TabIndex = 38;
            this.txtbxGameRecallPassword.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.txtbxGameRecallPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtbxGameRecallPassword_Validating);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.BackColor = System.Drawing.Color.White;
            this.label8.Location = new System.Drawing.Point(594, 84);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(33, 22);
            this.label8.TabIndex = 37;
            this.label8.Text = "sec";
            // 
            // numWaitCountdownTimerOP
            // 
            this.numWaitCountdownTimerOP.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numWaitCountdownTimerOP.Location = new System.Drawing.Point(526, 83);
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
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label7.Location = new System.Drawing.Point(76, 87);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(288, 22);
            this.label7.TabIndex = 35;
            this.label7.Text = "Minimum Number of Players Wait Time";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label6.Location = new System.Drawing.Point(76, 216);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(169, 22);
            this.label6.TabIndex = 34;
            this.label6.Text = "Game Recall Password";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.Color.White;
            this.label5.Location = new System.Drawing.Point(594, 170);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(33, 22);
            this.label5.TabIndex = 33;
            this.label5.Text = "sec";
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.SystemColors.Control;
            this.label1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.label1.Location = new System.Drawing.Point(526, 126);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(20, 26);
            this.label1.TabIndex = 32;
            this.label1.Text = "$";
            // 
            // numericTextBoxWDecimal1
            // 
            this.numericTextBoxWDecimal1.AllowSpace = false;
            this.numericTextBoxWDecimal1.Location = new System.Drawing.Point(547, 126);
            this.numericTextBoxWDecimal1.MaxLength = 7;
            this.numericTextBoxWDecimal1.Name = "numericTextBoxWDecimal1";
            this.numericTextBoxWDecimal1.ReadOnly = true;
            this.numericTextBoxWDecimal1.Size = new System.Drawing.Size(99, 26);
            this.numericTextBoxWDecimal1.TabIndex = 31;
            this.numericTextBoxWDecimal1.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numericTextBoxWDecimal1.Validating += new System.ComponentModel.CancelEventHandler(this.numericTextBoxWDecimal1_Validating);
            // 
            // numCountdownTimer
            // 
            this.numCountdownTimer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numCountdownTimer.Location = new System.Drawing.Point(526, 169);
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
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label4.Location = new System.Drawing.Point(76, 173);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(137, 22);
            this.label4.TabIndex = 29;
            this.label4.Text = "Countdown Timer";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label3.Location = new System.Drawing.Point(76, 130);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(92, 22);
            this.label3.TabIndex = 27;
            this.label3.Text = "Extra Bonus";
            // 
            // numMinimumPlayer
            // 
            this.numMinimumPlayer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numMinimumPlayer.Location = new System.Drawing.Point(526, 40);
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
            this.numMinimumPlayer.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numMinimumPlayer.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label2.Location = new System.Drawing.Point(76, 44);
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
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.NumericUpDown numCountdownTimer;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private CustomControls.NumericTextBoxWDecimal numericTextBoxWDecimal1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.NumericUpDown numWaitCountdownTimerOP;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtbxGameRecallPassword;
        public System.Windows.Forms.NumericUpDown numMinimumPlayer;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox textBox1;

    }
}
