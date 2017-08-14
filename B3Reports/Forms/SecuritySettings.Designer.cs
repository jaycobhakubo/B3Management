namespace GameTech.B3Reports.Forms
{
    partial class SecuritySettings
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
            System.Windows.Forms.Label maxLoginLimitLabel;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SecuritySettings));
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.chkUsePasswordComplexity = new System.Windows.Forms.CheckBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label5 = new System.Windows.Forms.Label();
            this.numMinWaitTimeBeforeLogout = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.numPinExpireDays = new System.Windows.Forms.NumericUpDown();
            this.pinExpireDaysLabel = new System.Windows.Forms.Label();
            this.numPasswordLockOutAttempts = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.numPreviousPasswordReuse = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.numMinimumPasswordLength = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.numMaxLoginLimit = new System.Windows.Forms.NumericUpDown();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            maxLoginLimitLabel = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numMinWaitTimeBeforeLogout)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPinExpireDays)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPasswordLockOutAttempts)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPreviousPasswordReuse)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPasswordLength)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMaxLoginLimit)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // maxLoginLimitLabel
            // 
            resources.ApplyResources(maxLoginLimitLabel, "maxLoginLimitLabel");
            maxLoginLimitLabel.Name = "maxLoginLimitLabel";
            // 
            // chkUsePasswordComplexity
            // 
            resources.ApplyResources(this.chkUsePasswordComplexity, "chkUsePasswordComplexity");
            this.chkUsePasswordComplexity.Name = "chkUsePasswordComplexity";
            this.toolTip1.SetToolTip(this.chkUsePasswordComplexity, resources.GetString("chkUsePasswordComplexity.ToolTip"));
            this.chkUsePasswordComplexity.UseVisualStyleBackColor = true;
            this.chkUsePasswordComplexity.CheckedChanged += new System.EventHandler(this.chkUsePasswordComplexity_CheckedChanged);
            this.chkUsePasswordComplexity.MouseHover += new System.EventHandler(this.chkUsePasswordComplexity_MouseHover);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.numMinWaitTimeBeforeLogout);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.chkUsePasswordComplexity);
            this.groupBox1.Controls.Add(this.numPinExpireDays);
            this.groupBox1.Controls.Add(this.pinExpireDaysLabel);
            this.groupBox1.Controls.Add(this.numPasswordLockOutAttempts);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.numPreviousPasswordReuse);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.numMinimumPasswordLength);
            this.groupBox1.Controls.Add(this.label2);
            resources.ApplyResources(this.groupBox1, "groupBox1");
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.TabStop = false;
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.Name = "label5";
            // 
            // numMinWaitTimeBeforeLogout
            // 
            resources.ApplyResources(this.numMinWaitTimeBeforeLogout, "numMinWaitTimeBeforeLogout");
            this.numMinWaitTimeBeforeLogout.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.numMinWaitTimeBeforeLogout.Name = "numMinWaitTimeBeforeLogout";
            this.numMinWaitTimeBeforeLogout.Tag = "5";
            this.numMinWaitTimeBeforeLogout.ValueChanged += new System.EventHandler(this.numMinimumPasswordLength_ValueChanged);
            this.numMinWaitTimeBeforeLogout.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.numMinimumPasswordLength_KeyPress);
            this.numMinWaitTimeBeforeLogout.Leave += new System.EventHandler(this.numMinimumPasswordLength_Leave);
            this.numMinWaitTimeBeforeLogout.Validating += new System.ComponentModel.CancelEventHandler(this.numMinimumPasswordLength_Validating);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // numPinExpireDays
            // 
            resources.ApplyResources(this.numPinExpireDays, "numPinExpireDays");
            this.numPinExpireDays.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.numPinExpireDays.Name = "numPinExpireDays";
            this.numPinExpireDays.Tag = "4";
            this.numPinExpireDays.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numPinExpireDays.ValueChanged += new System.EventHandler(this.numMinimumPasswordLength_ValueChanged);
            this.numPinExpireDays.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.numMinimumPasswordLength_KeyPress);
            this.numPinExpireDays.Leave += new System.EventHandler(this.numMinimumPasswordLength_Leave);
            this.numPinExpireDays.Validating += new System.ComponentModel.CancelEventHandler(this.numMinimumPasswordLength_Validating);
            // 
            // pinExpireDaysLabel
            // 
            resources.ApplyResources(this.pinExpireDaysLabel, "pinExpireDaysLabel");
            this.pinExpireDaysLabel.Name = "pinExpireDaysLabel";
            // 
            // numPasswordLockOutAttempts
            // 
            resources.ApplyResources(this.numPasswordLockOutAttempts, "numPasswordLockOutAttempts");
            this.numPasswordLockOutAttempts.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.numPasswordLockOutAttempts.Name = "numPasswordLockOutAttempts";
            this.numPasswordLockOutAttempts.Tag = "3";
            this.numPasswordLockOutAttempts.ValueChanged += new System.EventHandler(this.numMinimumPasswordLength_ValueChanged);
            this.numPasswordLockOutAttempts.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.numMinimumPasswordLength_KeyPress);
            this.numPasswordLockOutAttempts.Leave += new System.EventHandler(this.numMinimumPasswordLength_Leave);
            this.numPasswordLockOutAttempts.Validating += new System.ComponentModel.CancelEventHandler(this.numMinimumPasswordLength_Validating);
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // numPreviousPasswordReuse
            // 
            resources.ApplyResources(this.numPreviousPasswordReuse, "numPreviousPasswordReuse");
            this.numPreviousPasswordReuse.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.numPreviousPasswordReuse.Name = "numPreviousPasswordReuse";
            this.numPreviousPasswordReuse.Tag = "2";
            this.numPreviousPasswordReuse.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numPreviousPasswordReuse.ValueChanged += new System.EventHandler(this.numMinimumPasswordLength_ValueChanged);
            this.numPreviousPasswordReuse.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.numMinimumPasswordLength_KeyPress);
            this.numPreviousPasswordReuse.Leave += new System.EventHandler(this.numMinimumPasswordLength_Leave);
            this.numPreviousPasswordReuse.Validating += new System.ComponentModel.CancelEventHandler(this.numMinimumPasswordLength_Validating);
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // numMinimumPasswordLength
            // 
            resources.ApplyResources(this.numMinimumPasswordLength, "numMinimumPasswordLength");
            this.numMinimumPasswordLength.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
            this.numMinimumPasswordLength.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numMinimumPasswordLength.Name = "numMinimumPasswordLength";
            this.numMinimumPasswordLength.Tag = "1";
            this.numMinimumPasswordLength.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numMinimumPasswordLength.ValueChanged += new System.EventHandler(this.numMinimumPasswordLength_ValueChanged);
            this.numMinimumPasswordLength.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.numMinimumPasswordLength_KeyPress);
            this.numMinimumPasswordLength.Leave += new System.EventHandler(this.numMinimumPasswordLength_Leave);
            this.numMinimumPasswordLength.Validating += new System.ComponentModel.CancelEventHandler(this.numMinimumPasswordLength_Validating);
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // numMaxLoginLimit
            // 
            resources.ApplyResources(this.numMaxLoginLimit, "numMaxLoginLimit");
            this.numMaxLoginLimit.Name = "numMaxLoginLimit";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // SecuritySettings
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(maxLoginLimitLabel);
            this.Controls.Add(this.numMaxLoginLimit);
            this.DoubleBuffered = true;
            resources.ApplyResources(this, "$this");
            this.Name = "SecuritySettings";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numMinWaitTimeBeforeLogout)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPinExpireDays)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPasswordLockOutAttempts)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numPreviousPasswordReuse)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMinimumPasswordLength)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numMaxLoginLimit)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.NumericUpDown numMaxLoginLimit;
        private System.Windows.Forms.CheckBox chkUsePasswordComplexity;
        private System.Windows.Forms.NumericUpDown numPinExpireDays;
        private System.Windows.Forms.Label pinExpireDaysLabel;
        private System.Windows.Forms.NumericUpDown numPasswordLockOutAttempts;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.NumericUpDown numPreviousPasswordReuse;
        private System.Windows.Forms.Label label3;
        public System.Windows.Forms.NumericUpDown numMinimumPasswordLength;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.NumericUpDown numMinWaitTimeBeforeLogout;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label2;
    }
}
