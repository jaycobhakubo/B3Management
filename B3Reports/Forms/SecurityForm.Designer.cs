namespace GameTech.B3Reports.Forms
{
    partial class SecurityForm
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SecurityForm));
            this.printDocument1 = new System.Drawing.Printing.PrintDocument();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.txtBxUserName = new System.Windows.Forms.TextBox();
            this.txtBxConfirmPaswrd = new System.Windows.Forms.TextBox();
            this.txtBxPasswrd = new System.Windows.Forms.TextBox();
            this.lstViewUserLogIn = new System.Windows.Forms.ListView();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.rdoUserActive = new System.Windows.Forms.RadioButton();
            this.rdoUserInactive = new System.Windows.Forms.RadioButton();
            this.rdoUserAll = new System.Windows.Forms.RadioButton();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.txtbxFirstName = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtbxLastName = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.chkIsLock = new MyCheckBox();
            this.chkIsActive = new MyCheckBox();
            this.label8 = new System.Windows.Forms.Label();
            this.imgBtnCancel = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnNew = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnReturn = new GameTech.B3Reports.Forms.ImageButton();
            this.imgBtnSave = new GameTech.B3Reports.Forms.ImageButton();
            this.label9 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // txtBxUserName
            // 
            this.txtBxUserName.BackColor = System.Drawing.Color.White;
            resources.ApplyResources(this.txtBxUserName, "txtBxUserName");
            this.txtBxUserName.Name = "txtBxUserName";
            this.txtBxUserName.Tag = "1";
            this.txtBxUserName.Click += new System.EventHandler(this.txtBxClick);
            this.txtBxUserName.TextChanged += new System.EventHandler(this.txtBxTextChanged);
            this.txtBxUserName.Validating += new System.ComponentModel.CancelEventHandler(this.txtBxUserName_Validating);
            // 
            // txtBxConfirmPaswrd
            // 
            this.txtBxConfirmPaswrd.BackColor = System.Drawing.Color.Silver;
            resources.ApplyResources(this.txtBxConfirmPaswrd, "txtBxConfirmPaswrd");
            this.txtBxConfirmPaswrd.Name = "txtBxConfirmPaswrd";
            this.txtBxConfirmPaswrd.Tag = "3";
            this.txtBxConfirmPaswrd.UseSystemPasswordChar = true;
            this.txtBxConfirmPaswrd.Click += new System.EventHandler(this.txtBxClick);
            this.txtBxConfirmPaswrd.Validating += new System.ComponentModel.CancelEventHandler(this.txtBxConfirmPaswrd_Validating);
            // 
            // txtBxPasswrd
            // 
            this.txtBxPasswrd.BackColor = System.Drawing.Color.White;
            resources.ApplyResources(this.txtBxPasswrd, "txtBxPasswrd");
            this.txtBxPasswrd.Name = "txtBxPasswrd";
            this.txtBxPasswrd.Tag = "2";
            this.txtBxPasswrd.UseSystemPasswordChar = true;
            this.txtBxPasswrd.Click += new System.EventHandler(this.txtBxClick);
            this.txtBxPasswrd.TextChanged += new System.EventHandler(this.txtBxTextChanged);
            this.txtBxPasswrd.Validating += new System.ComponentModel.CancelEventHandler(this.txtBxPasswrd_Validating);
            // 
            // lstViewUserLogIn
            // 
            this.lstViewUserLogIn.Activation = System.Windows.Forms.ItemActivation.OneClick;
            this.lstViewUserLogIn.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(255)))));
            this.lstViewUserLogIn.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.lstViewUserLogIn.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1});
            resources.ApplyResources(this.lstViewUserLogIn, "lstViewUserLogIn");
            this.lstViewUserLogIn.ForeColor = System.Drawing.Color.Black;
            this.lstViewUserLogIn.FullRowSelect = true;
            this.lstViewUserLogIn.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
            this.lstViewUserLogIn.HideSelection = false;
            this.lstViewUserLogIn.MultiSelect = false;
            this.lstViewUserLogIn.Name = "lstViewUserLogIn";
            this.lstViewUserLogIn.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.lstViewUserLogIn.UseCompatibleStateImageBehavior = false;
            this.lstViewUserLogIn.View = System.Windows.Forms.View.Details;
            this.lstViewUserLogIn.ColumnWidthChanging += new System.Windows.Forms.ColumnWidthChangingEventHandler(this.lstViewUserLogIn_ColumnWidthChanging);
            this.lstViewUserLogIn.SelectedIndexChanged += new System.EventHandler(this.lstViewUserLogIn_SelectedIndexChanged);
            this.lstViewUserLogIn.Click += new System.EventHandler(this.lstViewUserLogIn_Click);
            // 
            // columnHeader1
            // 
            resources.ApplyResources(this.columnHeader1, "columnHeader1");
            // 
            // rdoUserActive
            // 
            this.rdoUserActive.BackColor = System.Drawing.Color.Transparent;
            this.rdoUserActive.Checked = true;
            this.rdoUserActive.ForeColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.rdoUserActive, "rdoUserActive");
            this.rdoUserActive.Name = "rdoUserActive";
            this.rdoUserActive.TabStop = true;
            this.rdoUserActive.Tag = "1";
            this.rdoUserActive.UseVisualStyleBackColor = false;
            this.rdoUserActive.CheckedChanged += new System.EventHandler(this.rdoUserbtn_CheckedChanged);
            // 
            // rdoUserInactive
            // 
            this.rdoUserInactive.BackColor = System.Drawing.Color.Transparent;
            this.rdoUserInactive.ForeColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.rdoUserInactive, "rdoUserInactive");
            this.rdoUserInactive.Name = "rdoUserInactive";
            this.rdoUserInactive.Tag = "2";
            this.rdoUserInactive.UseVisualStyleBackColor = false;
            this.rdoUserInactive.CheckedChanged += new System.EventHandler(this.rdoUserbtn_CheckedChanged);
            // 
            // rdoUserAll
            // 
            this.rdoUserAll.BackColor = System.Drawing.Color.Transparent;
            this.rdoUserAll.ForeColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.rdoUserAll, "rdoUserAll");
            this.rdoUserAll.Name = "rdoUserAll";
            this.rdoUserAll.Tag = "3";
            this.rdoUserAll.UseVisualStyleBackColor = false;
            this.rdoUserAll.CheckedChanged += new System.EventHandler(this.rdoUserbtn_CheckedChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.rdoUserActive);
            this.groupBox1.Controls.Add(this.rdoUserAll);
            this.groupBox1.Controls.Add(this.rdoUserInactive);
            resources.ApplyResources(this.groupBox1, "groupBox1");
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.pictureBox1, "pictureBox1");
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.TabStop = false;
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Name = "label1";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.BackColor = System.Drawing.Color.Transparent;
            this.label2.Name = "label2";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.BackColor = System.Drawing.Color.Transparent;
            this.label3.Name = "label3";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.BackColor = System.Drawing.Color.Transparent;
            this.label4.Name = "label4";
            // 
            // txtbxFirstName
            // 
            this.txtbxFirstName.BackColor = System.Drawing.Color.White;
            resources.ApplyResources(this.txtbxFirstName, "txtbxFirstName");
            this.txtbxFirstName.Name = "txtbxFirstName";
            this.txtbxFirstName.Tag = "1";
            this.txtbxFirstName.Click += new System.EventHandler(this.txtBxClick);
            this.txtbxFirstName.Validating += new System.ComponentModel.CancelEventHandler(this.txtbxFirstName_Validating);
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.BackColor = System.Drawing.Color.Transparent;
            this.label5.Name = "label5";
            // 
            // txtbxLastName
            // 
            this.txtbxLastName.BackColor = System.Drawing.Color.White;
            resources.ApplyResources(this.txtbxLastName, "txtbxLastName");
            this.txtbxLastName.Name = "txtbxLastName";
            this.txtbxLastName.Tag = "1";
            this.txtbxLastName.Click += new System.EventHandler(this.txtBxClick);
            // 
            // groupBox2
            // 
            this.groupBox2.BackColor = System.Drawing.Color.Transparent;
            this.groupBox2.Controls.Add(this.dataGridView1);
            this.groupBox2.Controls.Add(this.label7);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.txtbxFirstName);
            this.groupBox2.Controls.Add(this.txtbxLastName);
            this.groupBox2.Controls.Add(this.txtBxPasswrd);
            this.groupBox2.Controls.Add(this.chkIsLock);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.chkIsActive);
            this.groupBox2.Controls.Add(this.txtBxConfirmPaswrd);
            this.groupBox2.Controls.Add(this.txtBxUserName);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label2);
            resources.ApplyResources(this.groupBox2, "groupBox2");
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.TabStop = false;
            this.groupBox2.Enter += new System.EventHandler(this.groupBox2_Enter);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToResizeColumns = false;
            this.dataGridView1.AllowUserToResizeRows = false;
            this.dataGridView1.BackgroundColor = System.Drawing.Color.White;
            this.dataGridView1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Trebuchet MS", 12F);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            resources.ApplyResources(this.dataGridView1, "dataGridView1");
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.dataGridView1.MultiSelect = false;
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellClick);
            // 
            // label7
            // 
            resources.ApplyResources(this.label7, "label7");
            this.label7.Name = "label7";
            // 
            // label6
            // 
            resources.ApplyResources(this.label6, "label6");
            this.label6.Name = "label6";
            // 
            // chkIsLock
            // 
            this.chkIsLock.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.chkIsLock, "chkIsLock");
            this.chkIsLock.Name = "chkIsLock";
            this.chkIsLock.UseVisualStyleBackColor = false;
            this.chkIsLock.Click += new System.EventHandler(this.chkIsActive_Click);
            // 
            // chkIsActive
            // 
            this.chkIsActive.BackColor = System.Drawing.Color.Transparent;
            this.chkIsActive.Checked = true;
            this.chkIsActive.CheckState = System.Windows.Forms.CheckState.Checked;
            resources.ApplyResources(this.chkIsActive, "chkIsActive");
            this.chkIsActive.Name = "chkIsActive";
            this.chkIsActive.UseVisualStyleBackColor = false;
            this.chkIsActive.CheckedChanged += new System.EventHandler(this.chkIsActive_CheckedChanged_1);
            this.chkIsActive.Click += new System.EventHandler(this.chkIsActive_Click);
            // 
            // label8
            // 
            resources.ApplyResources(this.label8, "label8");
            this.label8.BackColor = System.Drawing.Color.Transparent;
            this.label8.Name = "label8";
            // 
            // imgBtnCancel
            // 
            this.imgBtnCancel.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnCancel.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnCancel, "imgBtnCancel");
            this.imgBtnCancel.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnCancel.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnCancel.Name = "imgBtnCancel";
            this.imgBtnCancel.UseVisualStyleBackColor = false;
            this.imgBtnCancel.Click += new System.EventHandler(this.imgBtnCancel_Click);
            // 
            // imgBtnNew
            // 
            this.imgBtnNew.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnNew.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnNew, "imgBtnNew");
            this.imgBtnNew.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnNew.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnNew.Name = "imgBtnNew";
            this.imgBtnNew.UseVisualStyleBackColor = false;
            this.imgBtnNew.Click += new System.EventHandler(this.imgBtnNew_Click);
            // 
            // imgBtnReturn
            // 
            this.imgBtnReturn.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnReturn.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnReturn, "imgBtnReturn");
            this.imgBtnReturn.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnReturn.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnReturn.Name = "imgBtnReturn";
            this.imgBtnReturn.UseVisualStyleBackColor = false;
            this.imgBtnReturn.Click += new System.EventHandler(this.imgBtnReturn_Click);
            // 
            // imgBtnSave
            // 
            this.imgBtnSave.BackColor = System.Drawing.Color.Transparent;
            this.imgBtnSave.FocusColor = System.Drawing.Color.Black;
            resources.ApplyResources(this.imgBtnSave, "imgBtnSave");
            this.imgBtnSave.ImageNormal = global::GameTech.B3Reports.Properties.Resources.BlueButtonUp;
            this.imgBtnSave.ImagePressed = global::GameTech.B3Reports.Properties.Resources.BlueButtonDown;
            this.imgBtnSave.Name = "imgBtnSave";
            this.imgBtnSave.UseVisualStyleBackColor = false;
            this.imgBtnSave.Click += new System.EventHandler(this.imgBtnSave_Click);
            // 
            // label9
            // 
            resources.ApplyResources(this.label9, "label9");
            this.label9.BackColor = System.Drawing.Color.Transparent;
            this.label9.Name = "label9";
            // 
            // SecurityForm
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.BackColor = System.Drawing.SystemColors.Control;
            resources.ApplyResources(this, "$this");
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.imgBtnCancel);
            this.Controls.Add(this.imgBtnNew);
            this.Controls.Add(this.imgBtnReturn);
            this.Controls.Add(this.imgBtnSave);
            this.Controls.Add(this.lstViewUserLogIn);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "SecurityForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.SecurityForm_FormClosing);
            this.Load += new System.EventHandler(this.SecurityForm_Load);
            this.LocationChanged += new System.EventHandler(this.LoginFullWin_LocationChanged);
            this.VisibleChanged += new System.EventHandler(this.SecurityForm_VisibleChanged);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Drawing.Printing.PrintDocument printDocument1;
        //private VirtualKeyboard virtualKeyboard1;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox txtBxPasswrd;
        private System.Windows.Forms.TextBox txtBxConfirmPaswrd;
        private System.Windows.Forms.TextBox txtBxUserName;
        private System.Windows.Forms.ListView lstViewUserLogIn;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private ImageButton imgBtnNew;
        private ImageButton imgBtnReturn;
        private ImageButton imgBtnSave;
        private ImageButton imgBtnCancel;
        private MyCheckBox chkIsActive;
        private MyCheckBox chkIsLock;
        private System.Windows.Forms.RadioButton rdoUserActive;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton rdoUserAll;
        private System.Windows.Forms.RadioButton rdoUserInactive;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtbxFirstName;
        private System.Windows.Forms.TextBox txtbxLastName;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Label label9;
    }
}