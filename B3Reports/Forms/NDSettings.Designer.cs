namespace GameTech.B3Reports.Forms
{
    partial class NDSettings
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
            this.grpBxNDSettings = new System.Windows.Forms.GroupBox();
            this.numPlayerPinLenght = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.chkbxNdSalesMode = new System.Windows.Forms.CheckBox();
            this.grpBxNDSettings.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numPlayerPinLenght)).BeginInit();
            this.SuspendLayout();
            // 
            // grpBxNDSettings
            // 
            this.grpBxNDSettings.Controls.Add(this.numPlayerPinLenght);
            this.grpBxNDSettings.Controls.Add(this.label2);
            this.grpBxNDSettings.Controls.Add(this.chkbxNdSalesMode);
            this.grpBxNDSettings.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.grpBxNDSettings.Location = new System.Drawing.Point(24, 25);
            this.grpBxNDSettings.Name = "grpBxNDSettings";
            this.grpBxNDSettings.Size = new System.Drawing.Size(771, 602);
            this.grpBxNDSettings.TabIndex = 0;
            this.grpBxNDSettings.TabStop = false;
            this.grpBxNDSettings.Text = "North Dakota Settings";
            // 
            // numPlayerPinLenght
            // 
            this.numPlayerPinLenght.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.numPlayerPinLenght.Location = new System.Drawing.Point(526, 40);
            this.numPlayerPinLenght.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.numPlayerPinLenght.Minimum = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.numPlayerPinLenght.Name = "numPlayerPinLenght";
            this.numPlayerPinLenght.Size = new System.Drawing.Size(120, 26);
            this.numPlayerPinLenght.TabIndex = 20;
            this.numPlayerPinLenght.Tag = "1";
            this.numPlayerPinLenght.Value = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.numPlayerPinLenght.Leave += new System.EventHandler(this.numPlayerPinLenght_Leave);
            this.numPlayerPinLenght.Validating += new System.ComponentModel.CancelEventHandler(this.numPlayerPinLenght_Validating);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            this.label2.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label2.Location = new System.Drawing.Point(76, 44);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(135, 22);
            this.label2.TabIndex = 19;
            this.label2.Text = "Player PIN Length";
            // 
            // chkbxNdSalesMode
            // 
            this.chkbxNdSalesMode.AutoSize = true;
            this.chkbxNdSalesMode.Location = new System.Drawing.Point(76, 87);
            this.chkbxNdSalesMode.Name = "chkbxNdSalesMode";
            this.chkbxNdSalesMode.Size = new System.Drawing.Size(132, 26);
            this.chkbxNdSalesMode.TabIndex = 0;
            this.chkbxNdSalesMode.Text = "ND Sales Mode";
            this.chkbxNdSalesMode.UseVisualStyleBackColor = true;
            this.chkbxNdSalesMode.Visible = false;
            // 
            // NDSettings
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.grpBxNDSettings);
            this.Name = "NDSettings";
            this.Size = new System.Drawing.Size(810, 644);
            this.grpBxNDSettings.ResumeLayout(false);
            this.grpBxNDSettings.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numPlayerPinLenght)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        public System.Windows.Forms.NumericUpDown numPlayerPinLenght;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox chkbxNdSalesMode;
        public System.Windows.Forms.GroupBox grpBxNDSettings;

    }
}
