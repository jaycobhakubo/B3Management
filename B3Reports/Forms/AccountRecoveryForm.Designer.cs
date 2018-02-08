namespace GameTech.B3Reports.Forms
{
    partial class AccountRecoveryForm
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
            this.label1 = new System.Windows.Forms.Label();
            this.AccountNumberTextBox = new System.Windows.Forms.TextBox();
            this.RecoverButton = new GameTech.B3Reports.Forms.ImageButton();
            this.CancelButton = new GameTech.B3Reports.Forms.ImageButton();
            this.StatusLabel = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(47, 72);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(126, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Account Number";
            // 
            // AccountNumberTextBox
            // 
            this.AccountNumberTextBox.Font = new System.Drawing.Font("Trebuchet MS", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.AccountNumberTextBox.Location = new System.Drawing.Point(179, 69);
            this.AccountNumberTextBox.Name = "AccountNumberTextBox";
            this.AccountNumberTextBox.Size = new System.Drawing.Size(130, 26);
            this.AccountNumberTextBox.TabIndex = 1;
            this.AccountNumberTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.AccountNumberKeyPress);
            // 
            // RecoverButton
            // 
            this.RecoverButton.BackColor = System.Drawing.Color.Transparent;
            this.RecoverButton.FocusColor = System.Drawing.Color.Black;
            this.RecoverButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.RecoverButton.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.RecoverButton.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.RecoverButton.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.RecoverButton.Location = new System.Drawing.Point(46, 180);
            this.RecoverButton.MinimumSize = new System.Drawing.Size(30, 30);
            this.RecoverButton.Name = "RecoverButton";
            this.RecoverButton.Size = new System.Drawing.Size(125, 40);
            this.RecoverButton.TabIndex = 30;
            this.RecoverButton.Text = "Recover";
            this.RecoverButton.UseVisualStyleBackColor = false;
            this.RecoverButton.Click += new System.EventHandler(this.RecoverButtonClick);
            // 
            // CancelButton
            // 
            this.CancelButton.BackColor = System.Drawing.Color.Transparent;
            this.CancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.CancelButton.FocusColor = System.Drawing.Color.Black;
            this.CancelButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold);
            this.CancelButton.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.CancelButton.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.CancelButton.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.CancelButton.Location = new System.Drawing.Point(184, 180);
            this.CancelButton.MinimumSize = new System.Drawing.Size(30, 30);
            this.CancelButton.Name = "CancelButton";
            this.CancelButton.Size = new System.Drawing.Size(125, 40);
            this.CancelButton.TabIndex = 31;
            this.CancelButton.Text = "Close";
            this.CancelButton.UseVisualStyleBackColor = false;
            this.CancelButton.Click += new System.EventHandler(this.CancelButtonClick);
            // 
            // StatusLabel
            // 
            this.StatusLabel.BackColor = System.Drawing.Color.Transparent;
            this.StatusLabel.Font = new System.Drawing.Font("Trebuchet MS", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.StatusLabel.ForeColor = System.Drawing.Color.Red;
            this.StatusLabel.Location = new System.Drawing.Point(46, 99);
            this.StatusLabel.Name = "StatusLabel";
            this.StatusLabel.Size = new System.Drawing.Size(263, 50);
            this.StatusLabel.TabIndex = 32;
            this.StatusLabel.Text = "Account Number";
            this.StatusLabel.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // AccountRecoveryForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(359, 237);
            this.Controls.Add(this.StatusLabel);
            this.Controls.Add(this.CancelButton);
            this.Controls.Add(this.RecoverButton);
            this.Controls.Add(this.AccountNumberTextBox);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "AccountRecoveryForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Account Recovery";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox AccountNumberTextBox;
        protected ImageButton RecoverButton;
        protected ImageButton CancelButton;
        private System.Windows.Forms.Label StatusLabel;
    }
}