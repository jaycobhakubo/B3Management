namespace GameTech.B3Reports.Forms
{
    partial class WideForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(WideForm));
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource2 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.spRptBallCallSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.ballCallSet = new GameTech.B3Reports.Data.BallCallSet();
            this.rptDetailTransBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.detailTrans = new GameTech.B3Reports.Data.DetailTrans();
            this.rptCardImagesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.cards = new GameTech.B3Reports.Data.Cards();
            this.btnCommand = new System.Windows.Forms.Button();
            this.btnDetailTrans = new System.Windows.Forms.Button();
            this.pnlButtons = new System.Windows.Forms.Panel();
            this.btnRptAccountHistory = new System.Windows.Forms.Button();
            this.btnWinnersCard = new System.Windows.Forms.Button();
            this.btnDrawer = new System.Windows.Forms.Button();
            this.btnSession = new System.Windows.Forms.Button();
            this.btnVoid = new System.Windows.Forms.Button();
            this.btnSessionSummary = new System.Windows.Forms.Button();
            this.btnSessTranDtl = new System.Windows.Forms.Button();
            this.btnUserAccess = new System.Windows.Forms.Button();
            this.btnPayout = new System.Windows.Forms.Button();
            this.btnBallCallClass2 = new System.Windows.Forms.Button();
            this.btnAuditLog = new System.Windows.Forms.Button();
            this.btnBallCall = new System.Windows.Forms.Button();
            this.btnJackpot = new System.Windows.Forms.Button();
            this.btnDaily = new System.Windows.Forms.Button();
            this.btnCardImages = new System.Windows.Forms.Button();
            this.pnlParams = new System.Windows.Forms.Panel();
            this.lblAccountNumber = new System.Windows.Forms.Label();
            this.m_sessionComboBox = new System.Windows.Forms.ComboBox();
            this.btnView = new System.Windows.Forms.Button();
            this.pnlKeypad = new System.Windows.Forms.Panel();
            this.btnPlay = new System.Windows.Forms.Button();
            this.btnZero = new System.Windows.Forms.Button();
            this.btnZeroZero = new System.Windows.Forms.Button();
            this.btnNine = new System.Windows.Forms.Button();
            this.btnEight = new System.Windows.Forms.Button();
            this.btnSeven = new System.Windows.Forms.Button();
            this.btnSix = new System.Windows.Forms.Button();
            this.btnFive = new System.Windows.Forms.Button();
            this.btnFour = new System.Windows.Forms.Button();
            this.btnThree = new System.Windows.Forms.Button();
            this.btnTwo = new System.Windows.Forms.Button();
            this.btnOne = new System.Windows.Forms.Button();
            this.picDown = new System.Windows.Forms.PictureBox();
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.txt2 = new System.Windows.Forms.TextBox();
            this.txt1 = new System.Windows.Forms.TextBox();
            this.lbl2 = new System.Windows.Forms.Label();
            this.lbl1 = new System.Windows.Forms.Label();
            this.cmbxAccountN = new System.Windows.Forms.ComboBox();
            this.pnlViewer = new System.Windows.Forms.Panel();
            this.rptViewer = new Microsoft.Reporting.WinForms.ReportViewer();
            this.cardsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.rptCardImagesTableAdapter = new GameTech.B3Reports.Data.CardsTableAdapters.rptCardImagesTableAdapter();
            this.rptDetailTransTableAdapter = new GameTech.B3Reports.Data.DetailTransTableAdapters.rptDetailTransTableAdapter();
            this.spRptBallCallSetTableAdapter = new GameTech.B3Reports.Data.BallCallSetTableAdapters.spRptBallCallSetTableAdapter();
            this.m_errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            this.pnlCrystalViewer = new System.Windows.Forms.Panel();
            this.crystalReportViewer1 = new CrystalDecisions.Windows.Forms.CrystalReportViewer();
            this.AuditLogBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.auditLog = new GameTech.B3Reports.Data.AuditLog();
            this.spRptAuditLogTableAdapter = new GameTech.B3Reports.Data.AuditLogTableAdapters.spRptAuditLogTableAdapter();
            this.ballCallClass2 = new GameTech.B3Reports.Data.BallCallClass2();
            this.BallCallClass2BindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.usp_server_rptBallCallTableAdapter = new GameTech.B3Reports.Data.BallCallClass2TableAdapters.usp_server_rptBallCallTableAdapter();
            this.payoutsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.payouts = new GameTech.B3Reports.Data.Payouts();
            this.spRptPayoutsTableAdapter = new GameTech.B3Reports.Data.PayoutsTableAdapters.spRptPayoutsTableAdapter();
            this.userAccessBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.userAccess = new GameTech.B3Reports.Data.UserAccess();
            this.spRptUserAccessTableAdapter = new GameTech.B3Reports.Data.UserAccessTableAdapters.spRptUserAccessTableAdapter();
            this.queriesTableAdapterBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.pnlParamsBallCall = new System.Windows.Forms.Panel();
            this.cmbxBallCallByCategory = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbxBallCallSessionID = new System.Windows.Forms.ComboBox();
            this.button1 = new System.Windows.Forms.Button();
            this.dtBallCallEndDate = new System.Windows.Forms.DateTimePicker();
            this.dtBallCallStartDate = new System.Windows.Forms.DateTimePicker();
            this.lblBallCallEndDate = new System.Windows.Forms.Label();
            this.lblBallCallStartDate = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.spRptBallCallSetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ballCallSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptDetailTransBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailTrans)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptCardImagesBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cards)).BeginInit();
            this.pnlButtons.SuspendLayout();
            this.pnlParams.SuspendLayout();
            this.pnlKeypad.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picDown)).BeginInit();
            this.pnlViewer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cardsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_errorProvider)).BeginInit();
            this.pnlCrystalViewer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.AuditLogBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.auditLog)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ballCallClass2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.BallCallClass2BindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.payoutsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.payouts)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.userAccessBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.userAccess)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.queriesTableAdapterBindingSource)).BeginInit();
            this.pnlParamsBallCall.SuspendLayout();
            this.SuspendLayout();
            // 
            // spRptBallCallSetBindingSource
            // 
            this.spRptBallCallSetBindingSource.DataMember = "spRptBallCallSet";
            this.spRptBallCallSetBindingSource.DataSource = this.ballCallSet;
            // 
            // ballCallSet
            // 
            this.ballCallSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rptDetailTransBindingSource
            // 
            this.rptDetailTransBindingSource.DataMember = "rptDetailTrans";
            this.rptDetailTransBindingSource.DataSource = this.detailTrans;
            // 
            // detailTrans
            // 
            this.detailTrans.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // rptCardImagesBindingSource
            // 
            this.rptCardImagesBindingSource.DataMember = "rptCardImages";
            this.rptCardImagesBindingSource.DataSource = this.cards;
            // 
            // cards
            // 
            this.cards.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // btnCommand
            // 
            this.btnCommand.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnCommand, "btnCommand");
            this.btnCommand.FlatAppearance.BorderSize = 0;
            this.btnCommand.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnCommand.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnCommand.Name = "btnCommand";
            this.btnCommand.UseVisualStyleBackColor = false;
            this.btnCommand.Click += new System.EventHandler(this.btnCommand_Click);
            this.btnCommand.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnCommand_MouseDown);
            this.btnCommand.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnCommand_MouseUp);
            // 
            // btnDetailTrans
            // 
            this.btnDetailTrans.BackColor = System.Drawing.Color.Transparent;
            this.btnDetailTrans.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.transactionDetailReport1;
            resources.ApplyResources(this.btnDetailTrans, "btnDetailTrans");
            this.btnDetailTrans.FlatAppearance.BorderSize = 0;
            this.btnDetailTrans.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnDetailTrans.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnDetailTrans.Name = "btnDetailTrans";
            this.btnDetailTrans.Tag = "2";
            this.btnDetailTrans.UseVisualStyleBackColor = false;
            this.btnDetailTrans.Click += new System.EventHandler(this.btnDetailTrans_Click);
            this.btnDetailTrans.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnDetailTrans.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // pnlButtons
            // 
            this.pnlButtons.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.pnlButtons, "pnlButtons");
            this.pnlButtons.Controls.Add(this.btnRptAccountHistory);
            this.pnlButtons.Controls.Add(this.btnWinnersCard);
            this.pnlButtons.Controls.Add(this.btnDrawer);
            this.pnlButtons.Controls.Add(this.btnSession);
            this.pnlButtons.Controls.Add(this.btnVoid);
            this.pnlButtons.Controls.Add(this.btnSessionSummary);
            this.pnlButtons.Controls.Add(this.btnSessTranDtl);
            this.pnlButtons.Controls.Add(this.btnUserAccess);
            this.pnlButtons.Controls.Add(this.btnPayout);
            this.pnlButtons.Controls.Add(this.btnBallCallClass2);
            this.pnlButtons.Controls.Add(this.btnAuditLog);
            this.pnlButtons.Controls.Add(this.btnBallCall);
            this.pnlButtons.Controls.Add(this.btnDetailTrans);
            this.pnlButtons.Controls.Add(this.btnJackpot);
            this.pnlButtons.Controls.Add(this.btnDaily);
            this.pnlButtons.Controls.Add(this.btnCardImages);
            this.pnlButtons.Name = "pnlButtons";
            // 
            // btnRptAccountHistory
            // 
            this.btnRptAccountHistory.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.account_history_report;
            resources.ApplyResources(this.btnRptAccountHistory, "btnRptAccountHistory");
            this.btnRptAccountHistory.FlatAppearance.BorderSize = 0;
            this.btnRptAccountHistory.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnRptAccountHistory.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnRptAccountHistory.Name = "btnRptAccountHistory";
            this.btnRptAccountHistory.Tag = "12";
            this.btnRptAccountHistory.UseVisualStyleBackColor = true;
            this.btnRptAccountHistory.Click += new System.EventHandler(this.btnRptAccountHistory_Click);
            this.btnRptAccountHistory.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnRptAccountHistory.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnWinnersCard
            // 
            this.btnWinnersCard.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.winning_cards_report;
            resources.ApplyResources(this.btnWinnersCard, "btnWinnersCard");
            this.btnWinnersCard.FlatAppearance.BorderSize = 0;
            this.btnWinnersCard.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnWinnersCard.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnWinnersCard.Name = "btnWinnersCard";
            this.btnWinnersCard.Tag = "11";
            this.btnWinnersCard.UseVisualStyleBackColor = false;
            this.btnWinnersCard.Click += new System.EventHandler(this.btnSessTranDtl_Click);
            this.btnWinnersCard.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnWinnersCard.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnDrawer
            // 
            this.btnDrawer.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnDrawer, "btnDrawer");
            this.btnDrawer.FlatAppearance.BorderSize = 0;
            this.btnDrawer.Name = "btnDrawer";
            this.btnDrawer.UseVisualStyleBackColor = false;
            this.btnDrawer.Click += new System.EventHandler(this.btnDrawer_Click);
            // 
            // btnSession
            // 
            this.btnSession.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnSession, "btnSession");
            this.btnSession.FlatAppearance.BorderSize = 0;
            this.btnSession.Name = "btnSession";
            this.btnSession.UseVisualStyleBackColor = false;
            this.btnSession.Click += new System.EventHandler(this.btnSession_Click);
            // 
            // btnVoid
            // 
            this.btnVoid.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnVoid, "btnVoid");
            this.btnVoid.FlatAppearance.BorderSize = 0;
            this.btnVoid.Name = "btnVoid";
            this.btnVoid.UseVisualStyleBackColor = false;
            this.btnVoid.Click += new System.EventHandler(this.btnVoid_Click);
            // 
            // btnSessionSummary
            // 
            resources.ApplyResources(this.btnSessionSummary, "btnSessionSummary");
            this.btnSessionSummary.FlatAppearance.BorderSize = 0;
            this.btnSessionSummary.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnSessionSummary.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnSessionSummary.Name = "btnSessionSummary";
            this.btnSessionSummary.Tag = "9";
            this.btnSessionSummary.UseVisualStyleBackColor = true;
            this.btnSessionSummary.Click += new System.EventHandler(this.btnSessTranDtl_Click);
            this.btnSessionSummary.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnSessionSummary.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnSessTranDtl
            // 
            this.btnSessTranDtl.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnSessTranDtl, "btnSessTranDtl");
            this.btnSessTranDtl.FlatAppearance.BorderSize = 0;
            this.btnSessTranDtl.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnSessTranDtl.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnSessTranDtl.Name = "btnSessTranDtl";
            this.btnSessTranDtl.Tag = "8";
            this.btnSessTranDtl.UseVisualStyleBackColor = false;
            this.btnSessTranDtl.Click += new System.EventHandler(this.btnSessTranDtl_Click);
            this.btnSessTranDtl.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnSessTranDtl.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnUserAccess
            // 
            this.btnUserAccess.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.user_access_report1;
            resources.ApplyResources(this.btnUserAccess, "btnUserAccess");
            this.btnUserAccess.FlatAppearance.BorderSize = 0;
            this.btnUserAccess.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnUserAccess.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnUserAccess.Name = "btnUserAccess";
            this.btnUserAccess.Tag = "7";
            this.btnUserAccess.UseVisualStyleBackColor = false;
            this.btnUserAccess.Click += new System.EventHandler(this.btnUserAccess_Click);
            this.btnUserAccess.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnUserAccess.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnPayout
            // 
            this.btnPayout.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.payout_report1;
            resources.ApplyResources(this.btnPayout, "btnPayout");
            this.btnPayout.FlatAppearance.BorderSize = 0;
            this.btnPayout.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnPayout.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnPayout.Name = "btnPayout";
            this.btnPayout.Tag = "6";
            this.btnPayout.UseVisualStyleBackColor = false;
            this.btnPayout.Click += new System.EventHandler(this.btnSessTranDtl_Click);
            this.btnPayout.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnPayout.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnBallCallClass2
            // 
            this.btnBallCallClass2.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.BalCallReport1;
            resources.ApplyResources(this.btnBallCallClass2, "btnBallCallClass2");
            this.btnBallCallClass2.FlatAppearance.BorderSize = 0;
            this.btnBallCallClass2.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnBallCallClass2.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnBallCallClass2.Name = "btnBallCallClass2";
            this.btnBallCallClass2.Tag = "5";
            this.btnBallCallClass2.UseVisualStyleBackColor = true;
            this.btnBallCallClass2.Click += new System.EventHandler(this.btnBallCall_Click);
            this.btnBallCallClass2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnBallCallClass2.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnAuditLog
            // 
            this.btnAuditLog.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.audit_log_report1;
            resources.ApplyResources(this.btnAuditLog, "btnAuditLog");
            this.btnAuditLog.FlatAppearance.BorderSize = 0;
            this.btnAuditLog.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnAuditLog.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnAuditLog.Name = "btnAuditLog";
            this.btnAuditLog.Tag = "4";
            this.btnAuditLog.UseVisualStyleBackColor = false;
            this.btnAuditLog.Click += new System.EventHandler(this.btnAuditLog_Click);
            this.btnAuditLog.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnAuditLog.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnBallCall
            // 
            resources.ApplyResources(this.btnBallCall, "btnBallCall");
            this.btnBallCall.FlatAppearance.BorderSize = 0;
            this.btnBallCall.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnBallCall.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnBallCall.Name = "btnBallCall";
            this.btnBallCall.UseVisualStyleBackColor = true;
            this.btnBallCall.Click += new System.EventHandler(this.btnBallCall_Click);
            // 
            // btnJackpot
            // 
            this.btnJackpot.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnJackpot, "btnJackpot");
            this.btnJackpot.FlatAppearance.BorderSize = 0;
            this.btnJackpot.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnJackpot.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnJackpot.Name = "btnJackpot";
            this.btnJackpot.Tag = "10";
            this.btnJackpot.UseVisualStyleBackColor = false;
            this.btnJackpot.Click += new System.EventHandler(this.btnSessTranDtl_Click);
            this.btnJackpot.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnJackpot.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // btnDaily
            // 
            this.btnDaily.BackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnDaily, "btnDaily");
            this.btnDaily.FlatAppearance.BorderSize = 0;
            this.btnDaily.Name = "btnDaily";
            this.btnDaily.UseVisualStyleBackColor = false;
            this.btnDaily.Click += new System.EventHandler(this.btnDaily_Click);
            // 
            // btnCardImages
            // 
            this.btnCardImages.BackColor = System.Drawing.Color.Transparent;
            this.btnCardImages.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.BingoCardReports1;
            resources.ApplyResources(this.btnCardImages, "btnCardImages");
            this.btnCardImages.FlatAppearance.BorderSize = 0;
            this.btnCardImages.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnCardImages.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnCardImages.Name = "btnCardImages";
            this.btnCardImages.Tag = "1";
            this.btnCardImages.UseVisualStyleBackColor = false;
            this.btnCardImages.Click += new System.EventHandler(this.btnCardImages_Click);
            this.btnCardImages.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_KeyPress);
            this.btnCardImages.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnUserAccess_MouseUp);
            // 
            // pnlParams
            // 
            this.pnlParams.BackColor = System.Drawing.Color.Transparent;
            this.pnlParams.Controls.Add(this.lblAccountNumber);
            this.pnlParams.Controls.Add(this.m_sessionComboBox);
            this.pnlParams.Controls.Add(this.btnView);
            this.pnlParams.Controls.Add(this.pnlKeypad);
            this.pnlParams.Controls.Add(this.dtEnd);
            this.pnlParams.Controls.Add(this.dtStart);
            this.pnlParams.Controls.Add(this.txt2);
            this.pnlParams.Controls.Add(this.txt1);
            this.pnlParams.Controls.Add(this.lbl2);
            this.pnlParams.Controls.Add(this.lbl1);
            this.pnlParams.Controls.Add(this.cmbxAccountN);
            resources.ApplyResources(this.pnlParams, "pnlParams");
            this.pnlParams.Name = "pnlParams";
            // 
            // lblAccountNumber
            // 
            resources.ApplyResources(this.lblAccountNumber, "lblAccountNumber");
            this.lblAccountNumber.Name = "lblAccountNumber";
            // 
            // m_sessionComboBox
            // 
            resources.ApplyResources(this.m_sessionComboBox, "m_sessionComboBox");
            this.m_sessionComboBox.FormattingEnabled = true;
            this.m_sessionComboBox.Name = "m_sessionComboBox";
            this.m_sessionComboBox.SelectedIndexChanged += new System.EventHandler(this.m_sessionComboBox_SelectedIndexChanged);
            this.m_sessionComboBox.Validating += new System.ComponentModel.CancelEventHandler(this.m_sessionComboBox_Validating);
            // 
            // btnView
            // 
            this.btnView.BackColor = System.Drawing.Color.Transparent;
            this.btnView.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.ViewReportButton_Strip3;
            this.btnView.FlatAppearance.BorderSize = 0;
            this.btnView.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnView.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.btnView, "btnView");
            this.btnView.Name = "btnView";
            this.btnView.UseVisualStyleBackColor = false;
            this.btnView.Click += new System.EventHandler(this.btnView_Click);
            this.btnView.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnView_MouseDown);
            this.btnView.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnView_MouseUp);
            // 
            // pnlKeypad
            // 
            this.pnlKeypad.Controls.Add(this.btnPlay);
            this.pnlKeypad.Controls.Add(this.btnZero);
            this.pnlKeypad.Controls.Add(this.btnZeroZero);
            this.pnlKeypad.Controls.Add(this.btnNine);
            this.pnlKeypad.Controls.Add(this.btnEight);
            this.pnlKeypad.Controls.Add(this.btnSeven);
            this.pnlKeypad.Controls.Add(this.btnSix);
            this.pnlKeypad.Controls.Add(this.btnFive);
            this.pnlKeypad.Controls.Add(this.btnFour);
            this.pnlKeypad.Controls.Add(this.btnThree);
            this.pnlKeypad.Controls.Add(this.btnTwo);
            this.pnlKeypad.Controls.Add(this.btnOne);
            this.pnlKeypad.Controls.Add(this.picDown);
            resources.ApplyResources(this.pnlKeypad, "pnlKeypad");
            this.pnlKeypad.Name = "pnlKeypad";
            // 
            // btnPlay
            // 
            this.btnPlay.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpPlay;
            this.btnPlay.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnPlay, "btnPlay");
            this.btnPlay.Name = "btnPlay";
            this.btnPlay.UseVisualStyleBackColor = true;
            this.btnPlay.Click += new System.EventHandler(this.btnPlay_Click);
            this.btnPlay.MouseEnter += new System.EventHandler(this.BtnPlay_MouseEnter);
            this.btnPlay.MouseLeave += new System.EventHandler(this.BtnPlay_MouseLeave);
            // 
            // btnZero
            // 
            this.btnZero.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpZero;
            this.btnZero.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnZero, "btnZero");
            this.btnZero.Name = "btnZero";
            this.btnZero.UseVisualStyleBackColor = true;
            this.btnZero.Click += new System.EventHandler(this.btnZero_Click);
            this.btnZero.MouseEnter += new System.EventHandler(this.btnZero_MouseEnter);
            this.btnZero.MouseLeave += new System.EventHandler(this.btnZero_MouseLeave);
            // 
            // btnZeroZero
            // 
            this.btnZeroZero.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpZeroZero;
            this.btnZeroZero.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnZeroZero, "btnZeroZero");
            this.btnZeroZero.Name = "btnZeroZero";
            this.btnZeroZero.UseVisualStyleBackColor = true;
            this.btnZeroZero.Click += new System.EventHandler(this.btnZeroZero_Click);
            this.btnZeroZero.MouseEnter += new System.EventHandler(this.btnZeroZero_MouseEnter);
            this.btnZeroZero.MouseLeave += new System.EventHandler(this.btnZeroZero_MouseLeave);
            // 
            // btnNine
            // 
            this.btnNine.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpNine;
            this.btnNine.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnNine, "btnNine");
            this.btnNine.Name = "btnNine";
            this.btnNine.UseVisualStyleBackColor = true;
            this.btnNine.Click += new System.EventHandler(this.btnNine_Click);
            this.btnNine.MouseEnter += new System.EventHandler(this.btnNine_MouseEnter);
            this.btnNine.MouseLeave += new System.EventHandler(this.btnNine_MouseLeave);
            // 
            // btnEight
            // 
            this.btnEight.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpEight;
            this.btnEight.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnEight, "btnEight");
            this.btnEight.Name = "btnEight";
            this.btnEight.UseVisualStyleBackColor = true;
            this.btnEight.Click += new System.EventHandler(this.btnEight_Click);
            this.btnEight.MouseEnter += new System.EventHandler(this.btnEight_MouseEnter);
            this.btnEight.MouseLeave += new System.EventHandler(this.btnEight_MouseLeave);
            // 
            // btnSeven
            // 
            this.btnSeven.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpSeven;
            this.btnSeven.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnSeven, "btnSeven");
            this.btnSeven.Name = "btnSeven";
            this.btnSeven.UseVisualStyleBackColor = true;
            this.btnSeven.Click += new System.EventHandler(this.btnSeven_Click);
            this.btnSeven.MouseEnter += new System.EventHandler(this.btnSeven_MouseEnter);
            this.btnSeven.MouseLeave += new System.EventHandler(this.btnSeven_MouseLeave);
            // 
            // btnSix
            // 
            this.btnSix.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpSix;
            this.btnSix.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnSix, "btnSix");
            this.btnSix.Name = "btnSix";
            this.btnSix.UseVisualStyleBackColor = true;
            this.btnSix.Click += new System.EventHandler(this.btnSix_Click);
            this.btnSix.MouseEnter += new System.EventHandler(this.BtnSix_MouseEnter);
            this.btnSix.MouseLeave += new System.EventHandler(this.BtnSix_MouseLeave);
            // 
            // btnFive
            // 
            this.btnFive.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpFive;
            this.btnFive.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnFive, "btnFive");
            this.btnFive.Name = "btnFive";
            this.btnFive.UseVisualStyleBackColor = true;
            this.btnFive.Click += new System.EventHandler(this.btnFive_Click);
            this.btnFive.MouseEnter += new System.EventHandler(this.btnFive_MouseEnter);
            this.btnFive.MouseLeave += new System.EventHandler(this.btnFive_MouseLeave);
            // 
            // btnFour
            // 
            this.btnFour.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpFour;
            this.btnFour.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnFour, "btnFour");
            this.btnFour.Name = "btnFour";
            this.btnFour.UseVisualStyleBackColor = true;
            this.btnFour.Click += new System.EventHandler(this.btnFour_Click);
            this.btnFour.MouseEnter += new System.EventHandler(this.btnFour_MouseEnter);
            this.btnFour.MouseLeave += new System.EventHandler(this.btnFour_MouseLeave);
            // 
            // btnThree
            // 
            this.btnThree.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpThree;
            this.btnThree.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnThree, "btnThree");
            this.btnThree.Name = "btnThree";
            this.btnThree.UseVisualStyleBackColor = true;
            this.btnThree.Click += new System.EventHandler(this.btnThree_Click);
            this.btnThree.MouseEnter += new System.EventHandler(this.bntThree_MouseEnter);
            this.btnThree.MouseLeave += new System.EventHandler(this.bntThree_MouseLeave);
            // 
            // btnTwo
            // 
            this.btnTwo.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.UpTwo;
            this.btnTwo.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.btnTwo, "btnTwo");
            this.btnTwo.Name = "btnTwo";
            this.btnTwo.UseVisualStyleBackColor = true;
            this.btnTwo.Click += new System.EventHandler(this.btnTwo_Click);
            this.btnTwo.MouseEnter += new System.EventHandler(this.btnTwo_MouseEnter);
            this.btnTwo.MouseLeave += new System.EventHandler(this.btnTwo_MouseLeave);
            // 
            // btnOne
            // 
            resources.ApplyResources(this.btnOne, "btnOne");
            this.btnOne.FlatAppearance.BorderSize = 0;
            this.btnOne.Name = "btnOne";
            this.btnOne.UseVisualStyleBackColor = true;
            this.btnOne.Click += new System.EventHandler(this.btnOne_Click);
            this.btnOne.MouseEnter += new System.EventHandler(this.btnOne_MouseEnter);
            this.btnOne.MouseLeave += new System.EventHandler(this.btnOne_MouseLeave);
            // 
            // picDown
            // 
            resources.ApplyResources(this.picDown, "picDown");
            this.picDown.Name = "picDown";
            this.picDown.TabStop = false;
            // 
            // dtEnd
            // 
            resources.ApplyResources(this.dtEnd, "dtEnd");
            this.dtEnd.Name = "dtEnd";
            // 
            // dtStart
            // 
            resources.ApplyResources(this.dtStart, "dtStart");
            this.dtStart.Name = "dtStart";
            this.dtStart.ValueChanged += new System.EventHandler(this.dtStart_ValueChanged);
            // 
            // txt2
            // 
            resources.ApplyResources(this.txt2, "txt2");
            this.txt2.Name = "txt2";
            this.txt2.Enter += new System.EventHandler(this.txt2_Enter);
            this.txt2.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txt1_KeyPress);
            this.txt2.Validating += new System.ComponentModel.CancelEventHandler(this.txt2_Validating);
            // 
            // txt1
            // 
            resources.ApplyResources(this.txt1, "txt1");
            this.txt1.Name = "txt1";
            this.txt1.Enter += new System.EventHandler(this.txt1_Enter);
            this.txt1.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txt1_KeyPress);
            this.txt1.Validating += new System.ComponentModel.CancelEventHandler(this.txt1_Validating);
            // 
            // lbl2
            // 
            resources.ApplyResources(this.lbl2, "lbl2");
            this.lbl2.Name = "lbl2";
            // 
            // lbl1
            // 
            resources.ApplyResources(this.lbl1, "lbl1");
            this.lbl1.Name = "lbl1";
            // 
            // cmbxAccountN
            // 
            resources.ApplyResources(this.cmbxAccountN, "cmbxAccountN");
            this.cmbxAccountN.FormattingEnabled = true;
            this.cmbxAccountN.Name = "cmbxAccountN";
            // 
            // pnlViewer
            // 
            this.pnlViewer.BackColor = System.Drawing.Color.Transparent;
            this.pnlViewer.Controls.Add(this.rptViewer);
            resources.ApplyResources(this.pnlViewer, "pnlViewer");
            this.pnlViewer.Name = "pnlViewer";
            // 
            // rptViewer
            // 
            resources.ApplyResources(this.rptViewer, "rptViewer");
            reportDataSource2.Name = "BallCallSet";
            reportDataSource2.Value = this.spRptBallCallSetBindingSource;
            this.rptViewer.LocalReport.DataSources.Add(reportDataSource2);
            this.rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.BallCallSet.rdlc";
            this.rptViewer.Name = "rptViewer";
            this.rptViewer.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.PageWidth;
            // 
            // cardsBindingSource
            // 
            this.cardsBindingSource.DataSource = this.cards;
            this.cardsBindingSource.Position = 0;
            // 
            // rptCardImagesTableAdapter
            // 
            this.rptCardImagesTableAdapter.ClearBeforeFill = true;
            // 
            // rptDetailTransTableAdapter
            // 
            this.rptDetailTransTableAdapter.ClearBeforeFill = true;
            // 
            // spRptBallCallSetTableAdapter
            // 
            this.spRptBallCallSetTableAdapter.ClearBeforeFill = true;
            // 
            // m_errorProvider
            // 
            this.m_errorProvider.ContainerControl = this;
            // 
            // pnlCrystalViewer
            // 
            this.pnlCrystalViewer.Controls.Add(this.crystalReportViewer1);
            resources.ApplyResources(this.pnlCrystalViewer, "pnlCrystalViewer");
            this.pnlCrystalViewer.Name = "pnlCrystalViewer";
            // 
            // crystalReportViewer1
            // 
            this.crystalReportViewer1.ActiveViewIndex = -1;
            this.crystalReportViewer1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            resources.ApplyResources(this.crystalReportViewer1, "crystalReportViewer1");
            this.crystalReportViewer1.Name = "crystalReportViewer1";
            // 
            // AuditLogBindingSource
            // 
            this.AuditLogBindingSource.DataMember = "spRptAuditLog";
            this.AuditLogBindingSource.DataSource = this.auditLog;
            // 
            // auditLog
            // 
            this.auditLog.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // spRptAuditLogTableAdapter
            // 
            this.spRptAuditLogTableAdapter.ClearBeforeFill = true;
            // 
            // ballCallClass2
            // 
            this.ballCallClass2.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // BallCallClass2BindingSource
            // 
            this.BallCallClass2BindingSource.DataMember = "usp_server_rptBallCall";
            this.BallCallClass2BindingSource.DataSource = this.ballCallClass2;
            // 
            // usp_server_rptBallCallTableAdapter
            // 
            this.usp_server_rptBallCallTableAdapter.ClearBeforeFill = true;
            // 
            // payoutsBindingSource
            // 
            this.payoutsBindingSource.DataMember = "spRptPayouts";
            this.payoutsBindingSource.DataSource = this.payouts;
            // 
            // payouts
            // 
            this.payouts.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // spRptPayoutsTableAdapter
            // 
            this.spRptPayoutsTableAdapter.ClearBeforeFill = true;
            // 
            // userAccessBindingSource
            // 
            this.userAccessBindingSource.DataMember = "spRptUserAccess";
            this.userAccessBindingSource.DataSource = this.userAccess;
            // 
            // userAccess
            // 
            this.userAccess.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // spRptUserAccessTableAdapter
            // 
            this.spRptUserAccessTableAdapter.ClearBeforeFill = true;
            // 
            // queriesTableAdapterBindingSource
            // 
            this.queriesTableAdapterBindingSource.DataSource = typeof(GameTech.B3Reports.DataSet1TableAdapters.QueriesTableAdapter);
            // 
            // pnlParamsBallCall
            // 
            this.pnlParamsBallCall.BackColor = System.Drawing.Color.Transparent;
            this.pnlParamsBallCall.Controls.Add(this.cmbxBallCallByCategory);
            this.pnlParamsBallCall.Controls.Add(this.label4);
            this.pnlParamsBallCall.Controls.Add(this.cmbxBallCallSessionID);
            this.pnlParamsBallCall.Controls.Add(this.button1);
            this.pnlParamsBallCall.Controls.Add(this.dtBallCallEndDate);
            this.pnlParamsBallCall.Controls.Add(this.dtBallCallStartDate);
            this.pnlParamsBallCall.Controls.Add(this.lblBallCallEndDate);
            this.pnlParamsBallCall.Controls.Add(this.lblBallCallStartDate);
            resources.ApplyResources(this.pnlParamsBallCall, "pnlParamsBallCall");
            this.pnlParamsBallCall.Name = "pnlParamsBallCall";
            // 
            // cmbxBallCallByCategory
            // 
            resources.ApplyResources(this.cmbxBallCallByCategory, "cmbxBallCallByCategory");
            this.cmbxBallCallByCategory.FormattingEnabled = true;
            this.cmbxBallCallByCategory.Name = "cmbxBallCallByCategory";
            this.cmbxBallCallByCategory.SelectedIndexChanged += new System.EventHandler(this.cmbxBallCallByCategory_SelectedIndexChanged);
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // cmbxBallCallSessionID
            // 
            resources.ApplyResources(this.cmbxBallCallSessionID, "cmbxBallCallSessionID");
            this.cmbxBallCallSessionID.FormattingEnabled = true;
            this.cmbxBallCallSessionID.Name = "cmbxBallCallSessionID";
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.Transparent;
            this.button1.BackgroundImage = global::GameTech.B3Reports.Properties.Resources.ViewReportButton_Strip3;
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.button1.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            resources.ApplyResources(this.button1, "button1");
            this.button1.Name = "button1";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.btnView_Click);
            this.button1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnView_MouseDown);
            this.button1.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnView_MouseUp);
            // 
            // dtBallCallEndDate
            // 
            resources.ApplyResources(this.dtBallCallEndDate, "dtBallCallEndDate");
            this.dtBallCallEndDate.Name = "dtBallCallEndDate";
            // 
            // dtBallCallStartDate
            // 
            resources.ApplyResources(this.dtBallCallStartDate, "dtBallCallStartDate");
            this.dtBallCallStartDate.Name = "dtBallCallStartDate";
            this.dtBallCallStartDate.ValueChanged += new System.EventHandler(this.dtStart_ValueChanged);
            // 
            // lblBallCallEndDate
            // 
            resources.ApplyResources(this.lblBallCallEndDate, "lblBallCallEndDate");
            this.lblBallCallEndDate.Name = "lblBallCallEndDate";
            // 
            // lblBallCallStartDate
            // 
            resources.ApplyResources(this.lblBallCallStartDate, "lblBallCallStartDate");
            this.lblBallCallStartDate.Name = "lblBallCallStartDate";
            // 
            // WideForm
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.BackColor = System.Drawing.SystemColors.Control;
            resources.ApplyResources(this, "$this");
            this.Controls.Add(this.pnlButtons);
            this.Controls.Add(this.pnlParamsBallCall);
            this.Controls.Add(this.pnlParams);
            this.Controls.Add(this.pnlViewer);
            this.Controls.Add(this.btnCommand);
            this.Controls.Add(this.pnlCrystalViewer);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "WideForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.WideForm_FormClosed);
            this.Load += new System.EventHandler(this.WideForm_Load);
            this.LocationChanged += new System.EventHandler(this.LoginFullWin_LocationChanged);
            this.VisibleChanged += new System.EventHandler(this.WideForm_VisibleChanged);
            ((System.ComponentModel.ISupportInitialize)(this.spRptBallCallSetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ballCallSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptDetailTransBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailTrans)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rptCardImagesBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cards)).EndInit();
            this.pnlButtons.ResumeLayout(false);
            this.pnlParams.ResumeLayout(false);
            this.pnlParams.PerformLayout();
            this.pnlKeypad.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.picDown)).EndInit();
            this.pnlViewer.ResumeLayout(false);
            this.pnlViewer.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cardsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.m_errorProvider)).EndInit();
            this.pnlCrystalViewer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.AuditLogBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.auditLog)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ballCallClass2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.BallCallClass2BindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.payoutsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.payouts)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.userAccessBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.userAccess)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.queriesTableAdapterBindingSource)).EndInit();
            this.pnlParamsBallCall.ResumeLayout(false);
            this.pnlParamsBallCall.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnCommand;
        private System.Windows.Forms.Button btnDetailTrans;
        private System.Windows.Forms.Panel pnlButtons;
        private System.Windows.Forms.Panel pnlParams;
        private System.Windows.Forms.Panel pnlViewer;
        private Microsoft.Reporting.WinForms.ReportViewer rptViewer;
        private System.Windows.Forms.BindingSource rptCardImagesBindingSource;
        private Data.Cards cards;
        private System.Windows.Forms.BindingSource cardsBindingSource;
        private Data.CardsTableAdapters.rptCardImagesTableAdapter rptCardImagesTableAdapter;
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.DateTimePicker dtStart;
        private System.Windows.Forms.TextBox txt2;
        private System.Windows.Forms.TextBox txt1;
        private System.Windows.Forms.Label lbl2;
        private System.Windows.Forms.Label lbl1;
        private System.Windows.Forms.BindingSource rptDetailTransBindingSource;
        private Data.DetailTrans detailTrans;
        private Data.DetailTransTableAdapters.rptDetailTransTableAdapter rptDetailTransTableAdapter;
        private System.Windows.Forms.Button btnView;
        private System.Windows.Forms.Button btnDrawer;
        private System.Windows.Forms.Button btnDaily;
        private System.Windows.Forms.Button btnSession;
        private System.Windows.Forms.Button btnJackpot;
        private System.Windows.Forms.Button btnVoid;
        private System.Windows.Forms.PictureBox picDown;
        private System.Windows.Forms.Panel pnlKeypad;
        private System.Windows.Forms.Button btnOne;
        private System.Windows.Forms.Button btnThree;
        private System.Windows.Forms.Button btnTwo;
        private System.Windows.Forms.Button btnNine;
        private System.Windows.Forms.Button btnEight;
        private System.Windows.Forms.Button btnSeven;
        private System.Windows.Forms.Button btnFour;
        private System.Windows.Forms.Button btnFive;
        private System.Windows.Forms.Button btnSix;
        private System.Windows.Forms.Button btnPlay;
        private System.Windows.Forms.Button btnZero;
        private System.Windows.Forms.Button btnZeroZero;
        private System.Windows.Forms.Button btnBallCall;
        private System.Windows.Forms.BindingSource spRptBallCallSetBindingSource;
        private Data.BallCallSet ballCallSet;
        private Data.BallCallSetTableAdapters.spRptBallCallSetTableAdapter spRptBallCallSetTableAdapter;
        private System.Windows.Forms.Button btnCardImages;
        private System.Windows.Forms.ComboBox m_sessionComboBox;
        private System.Windows.Forms.BindingSource queriesTableAdapterBindingSource;
        private System.Windows.Forms.ErrorProvider m_errorProvider;
        private System.Windows.Forms.Panel pnlCrystalViewer;
        private System.Windows.Forms.Button btnAuditLog;
        private CrystalDecisions.Windows.Forms.CrystalReportViewer crystalReportViewer1;
        private System.Windows.Forms.BindingSource AuditLogBindingSource;
        private Data.AuditLog auditLog;
        private Data.AuditLogTableAdapters.spRptAuditLogTableAdapter spRptAuditLogTableAdapter;
        private System.Windows.Forms.Button btnBallCallClass2;
        private Data.BallCallClass2 ballCallClass2;
        private System.Windows.Forms.BindingSource BallCallClass2BindingSource;
        private Data.BallCallClass2TableAdapters.usp_server_rptBallCallTableAdapter usp_server_rptBallCallTableAdapter;
        private System.Windows.Forms.Button btnPayout;
        private System.Windows.Forms.BindingSource payoutsBindingSource;
        private Data.Payouts payouts;
        private Data.PayoutsTableAdapters.spRptPayoutsTableAdapter spRptPayoutsTableAdapter;
        private System.Windows.Forms.Button btnUserAccess;
        private System.Windows.Forms.BindingSource userAccessBindingSource;
        private Data.UserAccess userAccess;
        private Data.UserAccessTableAdapters.spRptUserAccessTableAdapter spRptUserAccessTableAdapter;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Button btnSessTranDtl;
        private System.Windows.Forms.Button btnSessionSummary;
        private System.Windows.Forms.Button btnWinnersCard;
        private System.Windows.Forms.Button btnRptAccountHistory;
        private System.Windows.Forms.Label lblAccountNumber;
        private System.Windows.Forms.ComboBox cmbxAccountN;
        private System.Windows.Forms.Panel pnlParamsBallCall;
        private System.Windows.Forms.ComboBox cmbxBallCallByCategory;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cmbxBallCallSessionID;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DateTimePicker dtBallCallEndDate;
        private System.Windows.Forms.DateTimePicker dtBallCallStartDate;
        private System.Windows.Forms.Label lblBallCallEndDate;
        private System.Windows.Forms.Label lblBallCallStartDate;
    }
}