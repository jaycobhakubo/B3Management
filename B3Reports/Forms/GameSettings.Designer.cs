﻿namespace GameTech.B3Reports.Forms
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
            this.CheckBoxHandPayPerPattern = new System.Windows.Forms.CheckBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.numericUpDownExtraBonus = new System.Windows.Forms.NumericUpDown();
            this.singlePlayerPlayModeRadioButton = new System.Windows.Forms.RadioButton();
            this.numWaitCountdownTimerOP = new System.Windows.Forms.NumericUpDown();
            this.lblMinNumberOfPlayers = new System.Windows.Forms.Label();
            this.lblMinNumPlayersTime = new System.Windows.Forms.Label();
            this.numMinimumPlayer = new System.Windows.Forms.NumericUpDown();
            this.lblMinimumNumOfPlayersSec = new System.Windows.Forms.Label();
            this.lblCountdownTimerSec = new System.Windows.Forms.Label();
            this.lblExtraBonusDollarSign = new System.Windows.Forms.Label();
            this.lblExtraBonus = new System.Windows.Forms.Label();
            this.numCountdownTimer = new System.Windows.Forms.NumericUpDown();
            this.multiplayerPlayModeRadioButton = new System.Windows.Forms.RadioButton();
            this.lblCountdownTimer = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.GamesFlowPanel = new System.Windows.Forms.FlowLayoutPanel();
            this.numericUpDownGameThreads = new System.Windows.Forms.NumericUpDown();
            this.label9 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.txtbxGameRecallPassword = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.groupBox1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownExtraBonus)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).BeginInit();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGameThreads)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.CheckBoxHandPayPerPattern);
            this.groupBox1.Controls.Add(this.groupBox3);
            this.groupBox1.Controls.Add(this.groupBox2);
            this.groupBox1.Controls.Add(this.numericUpDownGameThreads);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.txtbxGameRecallPassword);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(24, 25);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(771, 602);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Server Game Settings";
            // 
            // CheckBoxHandPayPerPattern
            // 
            this.CheckBoxHandPayPerPattern.AutoSize = true;
            this.CheckBoxHandPayPerPattern.Location = new System.Drawing.Point(67, 425);
            this.CheckBoxHandPayPerPattern.Name = "CheckBoxHandPayPerPattern";
            this.CheckBoxHandPayPerPattern.Size = new System.Drawing.Size(249, 26);
            this.CheckBoxHandPayPerPattern.TabIndex = 47;
            this.CheckBoxHandPayPerPattern.Text = "Calculate hand pay per pattern";
            this.CheckBoxHandPayPerPattern.UseVisualStyleBackColor = true;
            this.CheckBoxHandPayPerPattern.Visible = false;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.numericUpDownExtraBonus);
            this.groupBox3.Controls.Add(this.singlePlayerPlayModeRadioButton);
            this.groupBox3.Controls.Add(this.numWaitCountdownTimerOP);
            this.groupBox3.Controls.Add(this.lblMinNumberOfPlayers);
            this.groupBox3.Controls.Add(this.lblMinNumPlayersTime);
            this.groupBox3.Controls.Add(this.numMinimumPlayer);
            this.groupBox3.Controls.Add(this.lblMinimumNumOfPlayersSec);
            this.groupBox3.Controls.Add(this.lblCountdownTimerSec);
            this.groupBox3.Controls.Add(this.lblExtraBonusDollarSign);
            this.groupBox3.Controls.Add(this.lblExtraBonus);
            this.groupBox3.Controls.Add(this.numCountdownTimer);
            this.groupBox3.Controls.Add(this.multiplayerPlayModeRadioButton);
            this.groupBox3.Controls.Add(this.lblCountdownTimer);
            this.groupBox3.Location = new System.Drawing.Point(58, 55);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(445, 270);
            this.groupBox3.TabIndex = 46;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Play Mode";
            // 
            // numericUpDownExtraBonus
            // 
            this.numericUpDownExtraBonus.DecimalPlaces = 2;
            this.numericUpDownExtraBonus.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numericUpDownExtraBonus.Increment = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.numericUpDownExtraBonus.Location = new System.Drawing.Point(273, 216);
            this.numericUpDownExtraBonus.Maximum = new decimal(new int[] {
            500,
            0,
            0,
            131072});
            this.numericUpDownExtraBonus.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.numericUpDownExtraBonus.Name = "numericUpDownExtraBonus";
            this.numericUpDownExtraBonus.Size = new System.Drawing.Size(120, 26);
            this.numericUpDownExtraBonus.TabIndex = 44;
            this.numericUpDownExtraBonus.Tag = "1";
            this.numericUpDownExtraBonus.Value = new decimal(new int[] {
            1,
            0,
            0,
            131072});
            this.numericUpDownExtraBonus.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // singlePlayerPlayModeRadioButton
            // 
            this.singlePlayerPlayModeRadioButton.AutoSize = true;
            this.singlePlayerPlayModeRadioButton.Location = new System.Drawing.Point(19, 28);
            this.singlePlayerPlayModeRadioButton.Name = "singlePlayerPlayModeRadioButton";
            this.singlePlayerPlayModeRadioButton.Size = new System.Drawing.Size(119, 26);
            this.singlePlayerPlayModeRadioButton.TabIndex = 42;
            this.singlePlayerPlayModeRadioButton.TabStop = true;
            this.singlePlayerPlayModeRadioButton.Text = "Single Player";
            this.singlePlayerPlayModeRadioButton.UseVisualStyleBackColor = true;
            this.singlePlayerPlayModeRadioButton.CheckedChanged += new System.EventHandler(this.RadioButtonPlayMode_CheckChanged);
            // 
            // numWaitCountdownTimerOP
            // 
            this.numWaitCountdownTimerOP.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numWaitCountdownTimerOP.Location = new System.Drawing.Point(273, 178);
            this.numWaitCountdownTimerOP.Name = "numWaitCountdownTimerOP";
            this.numWaitCountdownTimerOP.Size = new System.Drawing.Size(120, 26);
            this.numWaitCountdownTimerOP.TabIndex = 36;
            this.numWaitCountdownTimerOP.Tag = "2";
            this.numWaitCountdownTimerOP.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numWaitCountdownTimerOP.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            this.numWaitCountdownTimerOP.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numWaitCountdownTimerOP.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // lblMinNumberOfPlayers
            // 
            this.lblMinNumberOfPlayers.AutoSize = true;
            this.lblMinNumberOfPlayers.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblMinNumberOfPlayers.Location = new System.Drawing.Point(36, 106);
            this.lblMinNumberOfPlayers.Name = "lblMinNumberOfPlayers";
            this.lblMinNumberOfPlayers.Size = new System.Drawing.Size(208, 22);
            this.lblMinNumberOfPlayers.TabIndex = 25;
            this.lblMinNumberOfPlayers.Text = "Minimum Number of Players";
            // 
            // lblMinNumPlayersTime
            // 
            this.lblMinNumPlayersTime.AutoSize = true;
            this.lblMinNumPlayersTime.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblMinNumPlayersTime.Location = new System.Drawing.Point(36, 182);
            this.lblMinNumPlayersTime.Name = "lblMinNumPlayersTime";
            this.lblMinNumPlayersTime.Size = new System.Drawing.Size(134, 22);
            this.lblMinNumPlayersTime.TabIndex = 35;
            this.lblMinNumPlayersTime.Text = "Player Wait Time";
            // 
            // numMinimumPlayer
            // 
            this.numMinimumPlayer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numMinimumPlayer.Location = new System.Drawing.Point(273, 102);
            this.numMinimumPlayer.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.numMinimumPlayer.Minimum = new decimal(new int[] {
            2,
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
            this.numMinimumPlayer.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            this.numMinimumPlayer.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numMinimumPlayer.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // lblMinimumNumOfPlayersSec
            // 
            this.lblMinimumNumOfPlayersSec.AutoSize = true;
            this.lblMinimumNumOfPlayersSec.BackColor = System.Drawing.Color.Transparent;
            this.lblMinimumNumOfPlayersSec.Location = new System.Drawing.Point(393, 183);
            this.lblMinimumNumOfPlayersSec.Name = "lblMinimumNumOfPlayersSec";
            this.lblMinimumNumOfPlayersSec.Size = new System.Drawing.Size(33, 22);
            this.lblMinimumNumOfPlayersSec.TabIndex = 37;
            this.lblMinimumNumOfPlayersSec.Text = "sec";
            // 
            // lblCountdownTimerSec
            // 
            this.lblCountdownTimerSec.AutoSize = true;
            this.lblCountdownTimerSec.BackColor = System.Drawing.Color.Transparent;
            this.lblCountdownTimerSec.Location = new System.Drawing.Point(393, 146);
            this.lblCountdownTimerSec.Name = "lblCountdownTimerSec";
            this.lblCountdownTimerSec.Size = new System.Drawing.Size(33, 22);
            this.lblCountdownTimerSec.TabIndex = 33;
            this.lblCountdownTimerSec.Text = "sec";
            // 
            // lblExtraBonusDollarSign
            // 
            this.lblExtraBonusDollarSign.BackColor = System.Drawing.Color.Transparent;
            this.lblExtraBonusDollarSign.Location = new System.Drawing.Point(258, 217);
            this.lblExtraBonusDollarSign.Name = "lblExtraBonusDollarSign";
            this.lblExtraBonusDollarSign.Size = new System.Drawing.Size(20, 26);
            this.lblExtraBonusDollarSign.TabIndex = 32;
            this.lblExtraBonusDollarSign.Text = "$";
            // 
            // lblExtraBonus
            // 
            this.lblExtraBonus.AutoSize = true;
            this.lblExtraBonus.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblExtraBonus.Location = new System.Drawing.Point(36, 220);
            this.lblExtraBonus.Name = "lblExtraBonus";
            this.lblExtraBonus.Size = new System.Drawing.Size(92, 22);
            this.lblExtraBonus.TabIndex = 27;
            this.lblExtraBonus.Text = "Extra Bonus";
            // 
            // numCountdownTimer
            // 
            this.numCountdownTimer.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numCountdownTimer.Location = new System.Drawing.Point(273, 140);
            this.numCountdownTimer.Name = "numCountdownTimer";
            this.numCountdownTimer.Size = new System.Drawing.Size(120, 26);
            this.numCountdownTimer.TabIndex = 30;
            this.numCountdownTimer.Tag = "3";
            this.numCountdownTimer.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numCountdownTimer.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            this.numCountdownTimer.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.numCountdownTimer.Leave += new System.EventHandler(this.numMinimumPlayer_Leave);
            // 
            // multiplayerPlayModeRadioButton
            // 
            this.multiplayerPlayModeRadioButton.AutoSize = true;
            this.multiplayerPlayModeRadioButton.Location = new System.Drawing.Point(19, 69);
            this.multiplayerPlayModeRadioButton.Name = "multiplayerPlayModeRadioButton";
            this.multiplayerPlayModeRadioButton.Size = new System.Drawing.Size(106, 26);
            this.multiplayerPlayModeRadioButton.TabIndex = 43;
            this.multiplayerPlayModeRadioButton.TabStop = true;
            this.multiplayerPlayModeRadioButton.Text = "Multiplayer";
            this.multiplayerPlayModeRadioButton.UseVisualStyleBackColor = true;
            this.multiplayerPlayModeRadioButton.CheckedChanged += new System.EventHandler(this.RadioButtonPlayMode_CheckChanged);
            // 
            // lblCountdownTimer
            // 
            this.lblCountdownTimer.AutoSize = true;
            this.lblCountdownTimer.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblCountdownTimer.Location = new System.Drawing.Point(36, 144);
            this.lblCountdownTimer.Name = "lblCountdownTimer";
            this.lblCountdownTimer.Size = new System.Drawing.Size(137, 22);
            this.lblCountdownTimer.TabIndex = 29;
            this.lblCountdownTimer.Text = "Countdown Timer";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.GamesFlowPanel);
            this.groupBox2.Location = new System.Drawing.Point(525, 55);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(194, 272);
            this.groupBox2.TabIndex = 45;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Games";
            // 
            // GamesFlowPanel
            // 
            this.GamesFlowPanel.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.GamesFlowPanel.Location = new System.Drawing.Point(10, 25);
            this.GamesFlowPanel.Name = "GamesFlowPanel";
            this.GamesFlowPanel.Size = new System.Drawing.Size(178, 241);
            this.GamesFlowPanel.TabIndex = 0;
            // 
            // numericUpDownGameThreads
            // 
            this.numericUpDownGameThreads.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numericUpDownGameThreads.Location = new System.Drawing.Point(331, 384);
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
            this.numericUpDownGameThreads.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label9.Location = new System.Drawing.Point(63, 385);
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
            this.txtbxGameRecallPassword.Location = new System.Drawing.Point(331, 342);
            this.txtbxGameRecallPassword.MaxLength = 15;
            this.txtbxGameRecallPassword.Name = "txtbxGameRecallPassword";
            this.txtbxGameRecallPassword.Size = new System.Drawing.Size(120, 26);
            this.txtbxGameRecallPassword.TabIndex = 38;
            this.txtbxGameRecallPassword.Click += new System.EventHandler(this.numMinimumPlayer_Click);
            this.txtbxGameRecallPassword.TextChanged += new System.EventHandler(this.ModifiedSettings);
            this.txtbxGameRecallPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtbxGameRecallPassword_Validating);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label6.Location = new System.Drawing.Point(63, 345);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(169, 22);
            this.label6.TabIndex = 34;
            this.label6.Text = "Game Recall Password";
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
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownExtraBonus)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numWaitCountdownTimerOP)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPlayer)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCountdownTimer)).EndInit();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGameThreads)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.NumericUpDown numCountdownTimer;
        private System.Windows.Forms.Label lblCountdownTimer;
        private System.Windows.Forms.Label lblExtraBonus;
        private System.Windows.Forms.Label lblCountdownTimerSec;
        private System.Windows.Forms.Label lblExtraBonusDollarSign;
        private System.Windows.Forms.Label lblMinimumNumOfPlayersSec;
        private System.Windows.Forms.NumericUpDown numWaitCountdownTimerOP;
        private System.Windows.Forms.Label lblMinNumPlayersTime;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtbxGameRecallPassword;
        public System.Windows.Forms.NumericUpDown numMinimumPlayer;
        private System.Windows.Forms.Label lblMinNumberOfPlayers;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox textBox1;
        public System.Windows.Forms.NumericUpDown numericUpDownGameThreads;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.RadioButton multiplayerPlayModeRadioButton;
        private System.Windows.Forms.RadioButton singlePlayerPlayModeRadioButton;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        public System.Windows.Forms.NumericUpDown numericUpDownExtraBonus;
        private System.Windows.Forms.FlowLayoutPanel GamesFlowPanel;
        private System.Windows.Forms.CheckBox CheckBoxHandPayPerPattern;

    }
}
