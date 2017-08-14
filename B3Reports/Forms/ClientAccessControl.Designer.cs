namespace GameTech.B3Reports.Forms
{
    partial class ClientAccessControl
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dgClientAccess = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dgClientAccess)).BeginInit();
            this.SuspendLayout();
            // 
            // dgClientAccess
            // 
            this.dgClientAccess.AllowUserToAddRows = false;
            this.dgClientAccess.AllowUserToDeleteRows = false;
            this.dgClientAccess.AllowUserToResizeColumns = false;
            this.dgClientAccess.AllowUserToResizeRows = false;
            this.dgClientAccess.BackgroundColor = System.Drawing.Color.White;
            this.dgClientAccess.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgClientAccess.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgClientAccess.ColumnHeadersHeight = 33;
            this.dgClientAccess.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.dgClientAccess.Location = new System.Drawing.Point(34, 31);
            this.dgClientAccess.MultiSelect = false;
            this.dgClientAccess.Name = "dgClientAccess";
            this.dgClientAccess.RowHeadersVisible = false;
            this.dgClientAccess.Size = new System.Drawing.Size(748, 585);
            this.dgClientAccess.TabIndex = 0;
            // 
            // ClientAccessControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.dgClientAccess);
            this.Name = "ClientAccessControl";
            this.Size = new System.Drawing.Size(810, 644);
            ((System.ComponentModel.ISupportInitialize)(this.dgClientAccess)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        public System.Windows.Forms.DataGridView dgClientAccess;

    }
}
