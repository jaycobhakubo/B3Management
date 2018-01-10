namespace GameTech.B3Reports.Forms
{
    partial class GameSettingMayaMoney
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GameSettingMayaMoney));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.comboBoxMaxBetLevel = new System.Windows.Forms.ComboBox();
            this.comboBoxMaxCard = new System.Windows.Forms.ComboBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.numCallSpeedMax = new System.Windows.Forms.NumericUpDown();
            this.numCallSpeedMin = new System.Windows.Forms.NumericUpDown();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.chkbxDenom5d = new System.Windows.Forms.CheckBox();
            this.chkbxDenom1 = new System.Windows.Forms.CheckBox();
            this.chkbxDenom5 = new System.Windows.Forms.CheckBox();
            this.chkbxDenom10 = new System.Windows.Forms.CheckBox();
            this.chkbxDenom2d = new System.Windows.Forms.CheckBox();
            this.chkbxDenom50 = new System.Windows.Forms.CheckBox();
            this.chkbxDenom1d = new System.Windows.Forms.CheckBox();
            this.chkbxDenom25 = new System.Windows.Forms.CheckBox();
            this.chkbxAutoCall = new System.Windows.Forms.CheckBox();
            this.chkbxAutoPlay = new System.Windows.Forms.CheckBox();
            this.chkbxHideCardSerialNumber = new System.Windows.Forms.CheckBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numCallSpeedMax)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCallSpeedMin)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.comboBoxMaxBetLevel);
            this.groupBox1.Controls.Add(this.comboBoxMaxCard);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.numCallSpeedMax);
            this.groupBox1.Controls.Add(this.numCallSpeedMin);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.groupBox2);
            this.groupBox1.Controls.Add(this.chkbxAutoCall);
            this.groupBox1.Controls.Add(this.chkbxAutoPlay);
            this.groupBox1.Controls.Add(this.chkbxHideCardSerialNumber);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(24, 25);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(771, 602);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Maya Money Game Settings";
            // 
            // comboBoxMaxBetLevel
            // 
            this.comboBoxMaxBetLevel.FormattingEnabled = true;
            this.comboBoxMaxBetLevel.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4"});
            this.comboBoxMaxBetLevel.Location = new System.Drawing.Point(274, 94);
            this.comboBoxMaxBetLevel.Name = "comboBoxMaxBetLevel";
            this.comboBoxMaxBetLevel.Size = new System.Drawing.Size(120, 30);
            this.comboBoxMaxBetLevel.TabIndex = 78;
            this.comboBoxMaxBetLevel.SelectedIndexChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // comboBoxMaxCard
            // 
            this.comboBoxMaxCard.FormattingEnabled = true;
            this.comboBoxMaxCard.Items.AddRange(new object[] {
            "4",
            "6"});
            this.comboBoxMaxCard.Location = new System.Drawing.Point(274, 54);
            this.comboBoxMaxCard.Name = "comboBoxMaxCard";
            this.comboBoxMaxCard.Size = new System.Drawing.Size(120, 30);
            this.comboBoxMaxCard.TabIndex = 77;
            this.comboBoxMaxCard.SelectedIndexChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(23, 551);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(420, 46);
            this.textBox1.TabIndex = 76;
            this.textBox1.Text = resources.GetString("textBox1.Text");
            this.textBox1.Visible = false;
            // 
            // numCallSpeedMax
            // 
            this.numCallSpeedMax.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numCallSpeedMax.Location = new System.Drawing.Point(274, 177);
            this.numCallSpeedMax.Maximum = new decimal(new int[] {
            5000,
            0,
            0,
            0});
            this.numCallSpeedMax.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numCallSpeedMax.Name = "numCallSpeedMax";
            this.numCallSpeedMax.Size = new System.Drawing.Size(120, 26);
            this.numCallSpeedMax.TabIndex = 11;
            this.numCallSpeedMax.Tag = "6";
            this.numCallSpeedMax.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numCallSpeedMax.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            this.numCallSpeedMax.Leave += new System.EventHandler(this.numMaxCards_Leave);
            // 
            // numCallSpeedMin
            // 
            this.numCallSpeedMin.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numCallSpeedMin.Location = new System.Drawing.Point(274, 137);
            this.numCallSpeedMin.Maximum = new decimal(new int[] {
            5000,
            0,
            0,
            0});
            this.numCallSpeedMin.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numCallSpeedMin.Name = "numCallSpeedMin";
            this.numCallSpeedMin.Size = new System.Drawing.Size(120, 26);
            this.numCallSpeedMin.TabIndex = 9;
            this.numCallSpeedMin.Tag = "5";
            this.numCallSpeedMin.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numCallSpeedMin.ValueChanged += new System.EventHandler(this.ModifiedSettings);
            this.numCallSpeedMin.Leave += new System.EventHandler(this.numMaxCards_Leave);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label7.Location = new System.Drawing.Point(58, 179);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(131, 22);
            this.label7.TabIndex = 10;
            this.label7.Text = "Call Speed (max)";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label6.Location = new System.Drawing.Point(58, 139);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(128, 22);
            this.label6.TabIndex = 8;
            this.label6.Text = "Call Speed (min)";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.chkbxDenom5d);
            this.groupBox2.Controls.Add(this.chkbxDenom1);
            this.groupBox2.Controls.Add(this.chkbxDenom5);
            this.groupBox2.Controls.Add(this.chkbxDenom10);
            this.groupBox2.Controls.Add(this.chkbxDenom2d);
            this.groupBox2.Controls.Add(this.chkbxDenom50);
            this.groupBox2.Controls.Add(this.chkbxDenom1d);
            this.groupBox2.Controls.Add(this.chkbxDenom25);
            this.groupBox2.Location = new System.Drawing.Point(506, 217);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(192, 352);
            this.groupBox2.TabIndex = 71;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Denom";
            // 
            // chkbxDenom5d
            // 
            this.chkbxDenom5d.AutoSize = true;
            this.chkbxDenom5d.Checked = true;
            this.chkbxDenom5d.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom5d.Location = new System.Drawing.Point(48, 312);
            this.chkbxDenom5d.Name = "chkbxDenom5d";
            this.chkbxDenom5d.Size = new System.Drawing.Size(88, 26);
            this.chkbxDenom5d.TabIndex = 7;
            this.chkbxDenom5d.Text = "5 dollars";
            this.chkbxDenom5d.UseVisualStyleBackColor = true;
            this.chkbxDenom5d.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom1
            // 
            this.chkbxDenom1.AutoSize = true;
            this.chkbxDenom1.Location = new System.Drawing.Point(48, 32);
            this.chkbxDenom1.Name = "chkbxDenom1";
            this.chkbxDenom1.Size = new System.Drawing.Size(73, 26);
            this.chkbxDenom1.TabIndex = 0;
            this.chkbxDenom1.Tag = "5";
            this.chkbxDenom1.Text = "1 cent";
            this.chkbxDenom1.UseVisualStyleBackColor = true;
            this.chkbxDenom1.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom5
            // 
            this.chkbxDenom5.AutoSize = true;
            this.chkbxDenom5.Checked = true;
            this.chkbxDenom5.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom5.Location = new System.Drawing.Point(48, 72);
            this.chkbxDenom5.Name = "chkbxDenom5";
            this.chkbxDenom5.Size = new System.Drawing.Size(79, 26);
            this.chkbxDenom5.TabIndex = 1;
            this.chkbxDenom5.Text = "5 cents";
            this.chkbxDenom5.UseVisualStyleBackColor = true;
            this.chkbxDenom5.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom10
            // 
            this.chkbxDenom10.AutoSize = true;
            this.chkbxDenom10.Checked = true;
            this.chkbxDenom10.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom10.Location = new System.Drawing.Point(48, 112);
            this.chkbxDenom10.Name = "chkbxDenom10";
            this.chkbxDenom10.Size = new System.Drawing.Size(87, 26);
            this.chkbxDenom10.TabIndex = 2;
            this.chkbxDenom10.Text = "10 cents";
            this.chkbxDenom10.UseVisualStyleBackColor = true;
            this.chkbxDenom10.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom2d
            // 
            this.chkbxDenom2d.AutoSize = true;
            this.chkbxDenom2d.Checked = true;
            this.chkbxDenom2d.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom2d.Location = new System.Drawing.Point(48, 272);
            this.chkbxDenom2d.Name = "chkbxDenom2d";
            this.chkbxDenom2d.Size = new System.Drawing.Size(88, 26);
            this.chkbxDenom2d.TabIndex = 6;
            this.chkbxDenom2d.Text = "2 dollars";
            this.chkbxDenom2d.UseVisualStyleBackColor = true;
            this.chkbxDenom2d.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom50
            // 
            this.chkbxDenom50.AutoSize = true;
            this.chkbxDenom50.Checked = true;
            this.chkbxDenom50.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom50.Location = new System.Drawing.Point(48, 192);
            this.chkbxDenom50.Name = "chkbxDenom50";
            this.chkbxDenom50.Size = new System.Drawing.Size(87, 26);
            this.chkbxDenom50.TabIndex = 4;
            this.chkbxDenom50.Text = "50 cents";
            this.chkbxDenom50.UseVisualStyleBackColor = true;
            this.chkbxDenom50.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom1d
            // 
            this.chkbxDenom1d.AutoSize = true;
            this.chkbxDenom1d.Checked = true;
            this.chkbxDenom1d.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom1d.Location = new System.Drawing.Point(48, 232);
            this.chkbxDenom1d.Name = "chkbxDenom1d";
            this.chkbxDenom1d.Size = new System.Drawing.Size(82, 26);
            this.chkbxDenom1d.TabIndex = 5;
            this.chkbxDenom1d.Text = "1 dollar";
            this.chkbxDenom1d.UseVisualStyleBackColor = true;
            this.chkbxDenom1d.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxDenom25
            // 
            this.chkbxDenom25.AutoSize = true;
            this.chkbxDenom25.Checked = true;
            this.chkbxDenom25.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkbxDenom25.Location = new System.Drawing.Point(48, 152);
            this.chkbxDenom25.Name = "chkbxDenom25";
            this.chkbxDenom25.Size = new System.Drawing.Size(87, 26);
            this.chkbxDenom25.TabIndex = 3;
            this.chkbxDenom25.Text = "25 cents";
            this.chkbxDenom25.UseVisualStyleBackColor = true;
            this.chkbxDenom25.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxAutoCall
            // 
            this.chkbxAutoCall.AutoSize = true;
            this.chkbxAutoCall.Location = new System.Drawing.Point(496, 55);
            this.chkbxAutoCall.Name = "chkbxAutoCall";
            this.chkbxAutoCall.Size = new System.Drawing.Size(92, 26);
            this.chkbxAutoCall.TabIndex = 12;
            this.chkbxAutoCall.Text = "Auto Call";
            this.chkbxAutoCall.UseVisualStyleBackColor = true;
            this.chkbxAutoCall.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxAutoPlay
            // 
            this.chkbxAutoPlay.AutoSize = true;
            this.chkbxAutoPlay.Location = new System.Drawing.Point(496, 95);
            this.chkbxAutoPlay.Name = "chkbxAutoPlay";
            this.chkbxAutoPlay.Size = new System.Drawing.Size(95, 26);
            this.chkbxAutoPlay.TabIndex = 13;
            this.chkbxAutoPlay.Text = "Auto Play";
            this.chkbxAutoPlay.UseVisualStyleBackColor = true;
            this.chkbxAutoPlay.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // chkbxHideCardSerialNumber
            // 
            this.chkbxHideCardSerialNumber.AutoSize = true;
            this.chkbxHideCardSerialNumber.Location = new System.Drawing.Point(496, 135);
            this.chkbxHideCardSerialNumber.Name = "chkbxHideCardSerialNumber";
            this.chkbxHideCardSerialNumber.Size = new System.Drawing.Size(205, 26);
            this.chkbxHideCardSerialNumber.TabIndex = 14;
            this.chkbxHideCardSerialNumber.Text = "Hide Card Serial Number";
            this.chkbxHideCardSerialNumber.UseVisualStyleBackColor = true;
            this.chkbxHideCardSerialNumber.CheckedChanged += new System.EventHandler(this.ModifiedSettings);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label1.Location = new System.Drawing.Point(58, 97);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(110, 22);
            this.label1.TabIndex = 2;
            this.label1.Text = "Max Bet Level";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label2.Location = new System.Drawing.Point(58, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(86, 22);
            this.label2.TabIndex = 0;
            this.label2.Text = "Max  Cards";
            // 
            // GameSettingMayaMoney
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupBox1);
            this.Name = "GameSettingMayaMoney";
            this.Size = new System.Drawing.Size(810, 644);
            this.Tag = "5";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numCallSpeedMax)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCallSpeedMin)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckBox chkbxDenom5d;
        private System.Windows.Forms.CheckBox chkbxDenom1;
        private System.Windows.Forms.CheckBox chkbxDenom5;
        private System.Windows.Forms.CheckBox chkbxDenom10;
        private System.Windows.Forms.CheckBox chkbxDenom2d;
        private System.Windows.Forms.CheckBox chkbxDenom50;
        private System.Windows.Forms.CheckBox chkbxDenom1d;
        private System.Windows.Forms.CheckBox chkbxDenom25;
        private System.Windows.Forms.CheckBox chkbxAutoCall;
        private System.Windows.Forms.CheckBox chkbxAutoPlay;
        private System.Windows.Forms.CheckBox chkbxHideCardSerialNumber;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        public System.Windows.Forms.NumericUpDown numCallSpeedMax;
        public System.Windows.Forms.NumericUpDown numCallSpeedMin;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.ComboBox comboBoxMaxBetLevel;
        private System.Windows.Forms.ComboBox comboBoxMaxCard;
    }
}
