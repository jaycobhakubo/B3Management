namespace GameTech.B3Reports.Forms
{
    partial class Main
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
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.rptCardImagesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.cards = new GameTech.B3Reports.Data.Cards();
            this.rptDetailTransBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.detailTrans = new GameTech.B3Reports.Data.DetailTrans();
            this.rptViewer = new Microsoft.Reporting.WinForms.ReportViewer();
            this.btnCardImages = new System.Windows.Forms.Button();
            this.btnDetailTrans = new System.Windows.Forms.Button();
            this.btnReturn = new System.Windows.Forms.Button();
            this.btnView = new System.Windows.Forms.Button();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.txt2 = new System.Windows.Forms.TextBox();
            this.txt1 = new System.Windows.Forms.TextBox();
            this.pnlParams = new System.Windows.Forms.Panel();
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.lbl2 = new System.Windows.Forms.Label();
            this.lbl1 = new System.Windows.Forms.Label();
            this.rptCardImagesTableAdapter = new GameTech.B3Reports.Data.CardsTableAdapters.rptCardImagesTableAdapter();
            this.rptDetailTransTableAdapter = new GameTech.B3Reports.Data.DetailTransTableAdapters.rptDetailTransTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.rptCardImagesBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cards)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptDetailTransBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailTrans)).BeginInit();
            this.pnlParams.SuspendLayout();
            this.SuspendLayout();
            // 
            // rptCardImagesBindingSource
            // 
            this.rptCardImagesBindingSource.DataMember = "rptCardImages";
            this.rptCardImagesBindingSource.DataSource = this.cards;
            // 
            // cards
            // 
            this.cards.DataSetName = "Cards";
            this.cards.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rptDetailTransBindingSource
            // 
            this.rptDetailTransBindingSource.DataMember = "rptDetailTrans";
            this.rptDetailTransBindingSource.DataSource = this.detailTrans;
            // 
            // detailTrans
            // 
            this.detailTrans.DataSetName = "DetailTrans";
            this.detailTrans.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rptViewer
            // 
            this.rptViewer.BorderStyle = System.Windows.Forms.BorderStyle.None;
            reportDataSource1.Name = "dsCards";
            reportDataSource1.Value = this.rptCardImagesBindingSource;
            this.rptViewer.LocalReport.DataSources.Add(reportDataSource1);
            this.rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.CardImages.rdlc";
            this.rptViewer.Location = new System.Drawing.Point(231, 52);
            this.rptViewer.Name = "rptViewer";
            this.rptViewer.Size = new System.Drawing.Size(712, 585);
            this.rptViewer.TabIndex = 0;
            this.rptViewer.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.PageWidth;
            // 
            // btnCardImages
            // 
            this.btnCardImages.BackColor = System.Drawing.Color.Transparent;
            this.btnCardImages.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnCardImages.BackgroundImage")));
            this.btnCardImages.FlatAppearance.BorderSize = 0;
            this.btnCardImages.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCardImages.Location = new System.Drawing.Point(44, 61);
            this.btnCardImages.Name = "btnCardImages";
            this.btnCardImages.Size = new System.Drawing.Size(160, 156);
            this.btnCardImages.TabIndex = 1;
            this.toolTip1.SetToolTip(this.btnCardImages, "View the Bingo Card Images Report");
            this.btnCardImages.UseVisualStyleBackColor = false;
            this.btnCardImages.Click += new System.EventHandler(this.btnCardImages_Click);
            // 
            // btnDetailTrans
            // 
            this.btnDetailTrans.BackColor = System.Drawing.Color.Transparent;
            this.btnDetailTrans.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnDetailTrans.BackgroundImage")));
            this.btnDetailTrans.FlatAppearance.BorderSize = 0;
            this.btnDetailTrans.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDetailTrans.Location = new System.Drawing.Point(44, 238);
            this.btnDetailTrans.Name = "btnDetailTrans";
            this.btnDetailTrans.Size = new System.Drawing.Size(160, 157);
            this.btnDetailTrans.TabIndex = 2;
            this.toolTip1.SetToolTip(this.btnDetailTrans, "View the Detailed Transactions Report");
            this.btnDetailTrans.UseVisualStyleBackColor = false;
            this.btnDetailTrans.Click += new System.EventHandler(this.btnDetailTrans_Click);
            // 
            // btnReturn
            // 
            this.btnReturn.BackColor = System.Drawing.Color.Transparent;
            this.btnReturn.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnReturn.BackgroundImage")));
            this.btnReturn.FlatAppearance.BorderSize = 0;
            this.btnReturn.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnReturn.Location = new System.Drawing.Point(231, 643);
            this.btnReturn.Name = "btnReturn";
            this.btnReturn.Size = new System.Drawing.Size(335, 78);
            this.btnReturn.TabIndex = 3;
            this.toolTip1.SetToolTip(this.btnReturn, "Quit and Return to Big Bad Bingo");
            this.btnReturn.UseVisualStyleBackColor = false;
            this.btnReturn.Click += new System.EventHandler(this.btnReturn_Click);
            // 
            // btnView
            // 
            this.btnView.BackColor = System.Drawing.Color.Transparent;
            this.btnView.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("btnView.BackgroundImage")));
            this.btnView.FlatAppearance.BorderSize = 0;
            this.btnView.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnView.Location = new System.Drawing.Point(608, 643);
            this.btnView.Name = "btnView";
            this.btnView.Size = new System.Drawing.Size(335, 78);
            this.btnView.TabIndex = 4;
            this.toolTip1.SetToolTip(this.btnView, "View the selected report");
            this.btnView.UseVisualStyleBackColor = false;
            this.btnView.Click += new System.EventHandler(this.btnView_Click);
            // 
            // txt2
            // 
            this.txt2.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt2.Location = new System.Drawing.Point(255, 120);
            this.txt2.Multiline = true;
            this.txt2.Name = "txt2";
            this.txt2.Size = new System.Drawing.Size(175, 40);
            this.txt2.TabIndex = 3;
            this.toolTip1.SetToolTip(this.txt2, "Leave blank if you want only one Bingo Card, or the ending number of a range of c" +
        "ards.");
            // 
            // txt1
            // 
            this.txt1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt1.Location = new System.Drawing.Point(255, 20);
            this.txt1.Multiline = true;
            this.txt1.Name = "txt1";
            this.txt1.Size = new System.Drawing.Size(175, 40);
            this.txt1.TabIndex = 2;
            this.toolTip1.SetToolTip(this.txt1, "The Bingo Card Number to search for, or the beginning of a range of cards.");
            // 
            // pnlParams
            // 
            this.pnlParams.BackColor = System.Drawing.Color.Transparent;
            this.pnlParams.Controls.Add(this.dtEnd);
            this.pnlParams.Controls.Add(this.dtStart);
            this.pnlParams.Controls.Add(this.txt2);
            this.pnlParams.Controls.Add(this.txt1);
            this.pnlParams.Controls.Add(this.lbl2);
            this.pnlParams.Controls.Add(this.lbl1);
            this.pnlParams.Location = new System.Drawing.Point(231, 52);
            this.pnlParams.Name = "pnlParams";
            this.pnlParams.Size = new System.Drawing.Size(712, 585);
            this.pnlParams.TabIndex = 5;
            this.pnlParams.Visible = false;
            // 
            // dtEnd
            // 
            this.dtEnd.Location = new System.Drawing.Point(255, 132);
            this.dtEnd.Name = "dtEnd";
            this.dtEnd.Size = new System.Drawing.Size(200, 20);
            this.dtEnd.TabIndex = 5;
            // 
            // dtStart
            // 
            this.dtStart.Location = new System.Drawing.Point(255, 32);
            this.dtStart.Name = "dtStart";
            this.dtStart.Size = new System.Drawing.Size(200, 20);
            this.dtStart.TabIndex = 4;
            // 
            // lbl2
            // 
            this.lbl2.AutoSize = true;
            this.lbl2.Font = new System.Drawing.Font("Segoe UI", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl2.Location = new System.Drawing.Point(24, 123);
            this.lbl2.Name = "lbl2";
            this.lbl2.Size = new System.Drawing.Size(179, 37);
            this.lbl2.TabIndex = 1;
            this.lbl2.Text = "Ending Card:";
            // 
            // lbl1
            // 
            this.lbl1.AutoSize = true;
            this.lbl1.Font = new System.Drawing.Font("Segoe UI", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl1.Location = new System.Drawing.Point(24, 20);
            this.lbl1.Name = "lbl1";
            this.lbl1.Size = new System.Drawing.Size(195, 37);
            this.lbl1.TabIndex = 0;
            this.lbl1.Text = "Starting Card:";
            // 
            // rptCardImagesTableAdapter
            // 
            this.rptCardImagesTableAdapter.ClearBeforeFill = true;
            // 
            // rptDetailTransTableAdapter
            // 
            this.rptDetailTransTableAdapter.ClearBeforeFill = true;
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ClientSize = new System.Drawing.Size(1023, 769);
            this.ControlBox = false;
            this.Controls.Add(this.pnlParams);
            this.Controls.Add(this.rptViewer);
            this.Controls.Add(this.btnView);
            this.Controls.Add(this.btnReturn);
            this.Controls.Add(this.btnDetailTrans);
            this.Controls.Add(this.btnCardImages);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Main";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.Main_Load);
            ((System.ComponentModel.ISupportInitialize)(this.rptCardImagesBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cards)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptDetailTransBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailTrans)).EndInit();
            this.pnlParams.ResumeLayout(false);
            this.pnlParams.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer rptViewer;
        private System.Windows.Forms.Button btnCardImages;
        private System.Windows.Forms.Button btnDetailTrans;
        private System.Windows.Forms.Button btnReturn;
        private System.Windows.Forms.Button btnView;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.Panel pnlParams;
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.DateTimePicker dtStart;
        private System.Windows.Forms.TextBox txt2;
        private System.Windows.Forms.TextBox txt1;
        private System.Windows.Forms.Label lbl2;
        private System.Windows.Forms.Label lbl1;
        private System.Windows.Forms.BindingSource rptCardImagesBindingSource;
        private Data.Cards cards;
        private Data.CardsTableAdapters.rptCardImagesTableAdapter rptCardImagesTableAdapter;
        private System.Windows.Forms.BindingSource rptDetailTransBindingSource;
        private Data.DetailTrans detailTrans;
        private Data.DetailTransTableAdapters.rptDetailTransTableAdapter rptDetailTransTableAdapter;
    }
}