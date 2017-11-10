using System;
using System.Configuration;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.ReportSource;
using CrystalDecisions.Shared;
using GameTech.B3Reports.Reports;

namespace GameTech.B3Reports.Forms
{
    public partial class WideForm : Form
    {
  
        ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(WideForm));  

        public int CurrentReport { get; set; }
        public string ConnString { get; set; }
        SqlConnection sc = GetSQLConnection.get();
        public string StartingCards;
        public bool pickA;
        public bool pickB;
        public DateTime M_Date;


        #region Constructor

        public WideForm()
        {
            InitializeComponent();
            AdjustWindowSize.adjust(this);
          
            var settings = ConfigurationManager.ConnectionStrings;
            if (settings != null)
            {               
                var conn = settings["B3Reports.Properties.Settings.B3ConnectionString"];
                //var conn = settings["B3Reports.Properties.Resources.SQLConnection"];
                int i = 0;
            }

            btnDaily.Visible = false;  
            btnDrawer.Visible = false;
            btnSession.Visible = false;
            btnVoid.Visible = false;
            btnBallCall.Visible = false;

            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);
    
        }
        #endregion

        #region METHODS

        void NotImplemented()
        {
            MessageBox.Show("This Report is not yet implemented.");
        }
        void ShowReports()
        {
            pnlButtons.Visible = true;
            pnlParams.Visible = false;
            pnlViewer.Visible = false;
            pnlCrystalViewer.Visible = false;
            pnlParamsBallCall.Visible = false;
        }
        void ShowParams(int id)
        {
            pnlParams.Visible = true;
            CurrentReport = id;
            switch (id)
            {
                case 1:
                    m_sessionComboBox.Visible = false;
                    lbl1.Text = "Starting Card:";
                    lbl2.Text = "Ending Card:";
                    txt1.Visible = true;
                    txt2.Visible = true;
                    dtStart.Visible = false;
                    dtEnd.Visible = false;
                    lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;
                    break;

                case 2:              
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));   //added just to change the value 
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;  
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;
                    break;

                case 3:
                    m_sessionComboBox.Visible = false;
                    lbl1.Text = "Starting Date:";
                    lbl2.Text = "Ending Date:";
                    dtStart.Visible = true;
                    dtEnd.Visible = true;
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;
                    break;
              
                case 4:
                    m_sessionComboBox.Visible = false;
                    lbl1.Text = "Starting Date:";
                    lbl2.Text = "Ending Date:";
                    dtStart.Visible = true;
                    dtEnd.Visible = true;
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;
                    break;

                case 5:    //For Ball Call Report
                
                    pnlParamsBallCall.Visible = true;
                    pnlParams.Visible = false;
                    lblBallCallEndDate.Visible = false;
                    lblBallCallStartDate.Visible = false;
                    dtBallCallEndDate.Visible = false;
                    dtBallCallStartDate.Visible = false;
                    cmbxBallCallSessionID.Visible = false;

                    cmbxBallCallByCategory.Visible = true;
                    if (cmbxBallCallByCategory.Items.Count == 0)
                    {
                        cmbxBallCallByCategory.Items.Add("Session");//0
                        cmbxBallCallByCategory.Items.Add("Game");//1
                    }

                    if (cmbxBallCallByCategory.SelectedIndex == 1)
                    {
                        cmbxBallCallByCategory.SelectedIndex = -1;
                    }
                    cmbxBallCallByCategory.SelectedIndex = 1;

                    break;

                case 6:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));   //added just to change the value 
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;   
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;

                    break;

                case 8:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));   //added just to change the value 
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;
                    break;

                case 9:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));   
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;

                    break;

                case 10:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;

                    break;

                case 11:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                     lblAccountNumber.Visible = false;
                    cmbxAccountN.Visible = false;

                    break;

                case 12:
                    m_sessionComboBox.Visible = true;
                    lbl1.Text = "Date:";
                    lbl2.Text = "SessionID:";
                    dtStart.Visible = true;
                    dtEnd.Visible = false;
                    dtStart.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Today;
                    txt1.Visible = false;
                    txt2.Visible = false;
                    lblAccountNumber.Visible = true;
                    cmbxAccountN.Visible = true;

                    break;

                default:
                    break;
            }

            txt1.Select(); 
            pnlButtons.Visible = false;
            pnlViewer.Visible = false;
            pnlCrystalViewer.Visible = false;
        }

        void ViewReport()//knc
        {
            m_errorProvider.SetError(m_sessionComboBox, string.Empty);

            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                return;

            this.Cursor = Cursors.WaitCursor;
            ReportDataSource rptDataSource = new ReportDataSource();
            rptViewer.LocalReport.DataSources.Clear();  // 03.22
      
            

            pnlViewer.Visible = true;
            pnlButtons.Visible = false;
            pnlParams.Visible = false;

            //ReportParameter[] parameters = new ReportParameter[4];

            string StartDate = dtStart.Value.ToString();
            string EndDate = dtEnd.Value.ToString();
            string x = txt1.Text.ToString();
            string y = txt2.Text.ToString();

            DataSet ds = new DataSet("spRptAuditLog");
            int SessID;

            switch (CurrentReport)
            {
                case 1:
                    rptDataSource.Name = "dsCards";
                    rptDataSource.Value = this.rptCardImagesBindingSource;
                    int start = 0, end = 0;
                    int.TryParse(txt1.Text, out start);
                    int.TryParse(txt2.Text, out end);
                    rptCardImagesTableAdapter.Fill(this.cards.rptCardImages, start, end);
                    ReportParameter P5 = new ReportParameter("StartDate", x);
                    ReportParameter P6 = new ReportParameter("EndDate", y);
                    this.rptViewer.ShowParameterPrompts = true;
                    this.rptViewer.LocalReport.SetParameters(new ReportParameter[] {P5,P6 });
                    rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.CardImages.rdlc";           
                    break;

                case 2:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());   
                    rptDataSource.Name = "dsTrans";
                    rptDataSource.Value = this.rptDetailTransBindingSource;
                    detailTrans.EnforceConstraints = false;
                    rptDetailTransTableAdapter.Fill(this.detailTrans.rptDetailTrans, dtStart.Value, SessID);
                    ReportParameter P1 = new ReportParameter("StartDate", StartDate);
                    ReportParameter P2 = new ReportParameter("EndDate", m_sessionComboBox.SelectedItem.ToString());  
                    this.rptViewer.ShowParameterPrompts = true;
                    this.rptViewer.LocalReport.SetParameters(new ReportParameter[] {P1,P2});
                    rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.DetailTrans.rdlc";                 
                    break;

                case 3:         
                    rptDataSource.Name = "BallCallSet";
                    rptDataSource.Value = this.spRptBallCallSetBindingSource; 
                    spRptBallCallSetTableAdapter.Fill(this.ballCallSet.spRptBallCallSet, dtStart.Value, dtEnd.Value);                                       
                    ReportParameter P3 = new ReportParameter("StartDate", StartDate);
                    ReportParameter P4 = new ReportParameter("EndDate", EndDate);
                    this.rptViewer.ShowParameterPrompts = true;
                    this.rptViewer.LocalReport.SetParameters(new ReportParameter[] {P3,P4});                 
                    rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.BallCallSet.rdlc";
                    break;

                case 4:
                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;
                    DateTime start_date = dtStart.Value;
                    DateTime end_date = dtEnd.Value;
                    ds = new DataSet("spRptAuditLog");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("spRptAuditLog", con);
                        sqlcom.Parameters.AddWithValue("@StartDate", start_date);
                        sqlcom.Parameters.AddWithValue("@EndDate", end_date);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        AuditLog crysRpt = new AuditLog();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@StartDate", start_date);
                        crysRpt.SetParameterValue("@EndDate", end_date);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }
                    break;

                case 5:
          
                    start_date = dtBallCallStartDate.Value;
                    end_date = dtBallCallEndDate.Value;
                    pnlParamsBallCall.Visible = false;

                    if (cmbxBallCallByCategory.SelectedIndex == 1)
                    {
                        pnlViewer.Visible = false;  
                        pnlCrystalViewer.Visible = true;

                        SessID = int.Parse( cmbxBallCallSessionID.SelectedItem.ToString());
               
                        start_date = dtStart.Value;
                        ds = new DataSet("usp_server_rptBallCall");
                        using (SqlConnection con = GetSQLConnection.get())
                        {
                            SqlCommand sqlcom = new SqlCommand("usp_server_rptBallCall", con);
                            sqlcom.Parameters.AddWithValue("@session", SessID);
                        //    sqlcom.Parameters.AddWithValue("@DateParameter", start_date);
                            sqlcom.CommandType = CommandType.StoredProcedure;
                            sqlcom.CommandTimeout = 0;
                            SqlDataAdapter da = new SqlDataAdapter();
                            da.SelectCommand = sqlcom;
                            da.Fill(ds);
                            B3ClassIIBallCall crysRpt = new B3ClassIIBallCall();
                            crysRpt.SetDataSource(ds);
                            crysRpt.SetParameterValue("@session", SessID);
                           // crysRpt.SetParameterValue("@DateParameter", start_date);
                            PassThroughConnection(crysRpt);
                            crystalReportViewer1.ReportSource = crysRpt;
                            crystalReportViewer1.Refresh();
                        }
                    }
                    else if (cmbxBallCallByCategory.SelectedIndex == 0)
                    {
                        
                        rptDataSource.Name = "BallCallSet";
                        rptDataSource.Value = this.spRptBallCallSetBindingSource;
                        spRptBallCallSetTableAdapter.Fill(this.ballCallSet.spRptBallCallSet, dtBallCallStartDate.Value, dtBallCallEndDate.Value);
                        P3 = new ReportParameter("StartDate", start_date.ToString());
                        P4 = new ReportParameter("EndDate", end_date.ToString());
                        this.rptViewer.ShowParameterPrompts = true;
                        this.rptViewer.LocalReport.SetParameters(new ReportParameter[] { P3, P4 });
                        rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.BallCallSet.rdlc";
                    }


                    break;

                case 6:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());
                      start_date = dtStart.Value;
                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("spRptPayouts");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("spRptPayouts", con);
                        sqlcom.Parameters.AddWithValue("@SessionNum", SessID);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        Payouts crysRpt = new Payouts();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@SessionNum", SessID);
                        crysRpt.SetParameterValue("@GamingDate", start_date);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;

                case 7:
                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("spRptUserAccess");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("spRptUserAccess", con);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        UserAccess crysRpt = new UserAccess();
                        crysRpt.SetDataSource(ds);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }
                    break;

                case 8:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());


                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("rptSessionTrans");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("rptSessionTrans", con);
                        sqlcom.Parameters.AddWithValue("@SessionNumber", SessID);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        SessionTransaction crysRpt = new SessionTransaction();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@SessionNumber", SessID);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;

                case 9:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());
                    end_date = dtEnd.Value;

                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("rptSessionTrans");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("usp_management_rptGetSessionsSummary", con);
                        sqlcom.Parameters.AddWithValue("@DateTime", end_date);
                        sqlcom.Parameters.AddWithValue("@SessionN", SessID);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        SessionSummary crysRpt = new SessionSummary();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@DateTime", end_date);
                        crysRpt.SetParameterValue("@SessionN", SessID);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;

                case 10:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());
                   // end_date = dtEnd.Value;
                    end_date =  dtStart.Value; // .Value;

                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("rptSessionTrans");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("usp_management_rptGetJackpotSummary", con);
                        sqlcom.Parameters.AddWithValue("@nDate", end_date);
                        sqlcom.Parameters.AddWithValue("@nSessNum", SessID);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        B3_JackpotReport crysRpt = new B3_JackpotReport();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@nDate", end_date);
                        crysRpt.SetParameterValue("@nSessNum", SessID);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;

                case 11:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());
                    end_date = dtStart.Value;//end_date = dtEnd.Value;

                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("spRptPayouts2");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("spRptPayouts2", con);
                        sqlcom.Parameters.AddWithValue("@DateRun", end_date);
                        sqlcom.Parameters.AddWithValue("@SessionNum", SessID);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        WinnerCardsReport crysRpt = new WinnerCardsReport();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@DateRun", end_date);
                        crysRpt.SetParameterValue("@SessionNum", SessID);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;

                case 12:
                    SessID = int.Parse(m_sessionComboBox.SelectedItem.ToString());
                    //end_date = dtEnd.Value;
                    end_date =  dtStart.Value;
                    int AccountNumber = int.Parse(cmbxAccountN.SelectedItem.ToString());

                    pnlViewer.Visible = false;
                    pnlCrystalViewer.Visible = true;

                    ds = new DataSet("usp_management_rptAccountHistory");
                    using (SqlConnection con = GetSQLConnection.get())
                    {
                        SqlCommand sqlcom = new SqlCommand("usp_management_rptAccountHistory", con);
                        sqlcom.Parameters.AddWithValue("@P_Date_", end_date);
                        sqlcom.Parameters.AddWithValue("@SessionID_", SessID);
                        sqlcom.Parameters.AddWithValue("@AccountNumber", AccountNumber);
                        sqlcom.CommandType = CommandType.StoredProcedure;
                        sqlcom.CommandTimeout = 0;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcom;
                        da.Fill(ds);
                        AccountHistory crysRpt = new AccountHistory();
                        crysRpt.SetDataSource(ds);
                        crysRpt.SetParameterValue("@P_Date_", end_date);
                        crysRpt.SetParameterValue("@SessionID_", SessID);
                        crysRpt.SetParameterValue("@AccountNumber", AccountNumber);
                        PassThroughConnection(crysRpt);
                        crystalReportViewer1.ReportSource = crysRpt;
                        crystalReportViewer1.Refresh();
                    }

                    break;


                default:
                    break;
            }

            rptViewer.LocalReport.DataSources.Add(rptDataSource);
            rptViewer.RefreshReport();

            this.Cursor = Cursors.Default;
        }

        private void PassThroughConnection(ReportDocument x)
        {
            ConnectionInfo crConnectionInfo = new ConnectionInfo();
            TableLogOnInfo crtableLoginInfo = new TableLogOnInfo();
            TableLogOnInfos crTableLoginInfos = new TableLogOnInfos();
            Tables crTables;

            //Get the server name
            GameTech.B3Reports._cs_Get.GetSystemInfo ServerName = new _cs_Get.GetSystemInfo();
            string tempServerName = ServerName.ServerName;

            crConnectionInfo.ServerName = tempServerName;//Servername always changes.
            crConnectionInfo.DatabaseName = "B3";//Fixed on all B3 system
            crConnectionInfo.UserID = "sqluser";//Fixed on all B3 system
            crConnectionInfo.Password = "gly*cine83";//We should hash this.

            crTables = x.Database.Tables;

            foreach (Table crTable in crTables)
            {
                crtableLoginInfo = crTable.LogOnInfo;
                crtableLoginInfo.ConnectionInfo = crConnectionInfo;
                crTable.ApplyLogOnInfo(crtableLoginInfo);
            }
        }

        public void SetViewToDefault()
        {
            m_errorProvider.Clear();
            crystalReportViewer1.ReportSource = null;
            crystalReportViewer1.Refresh();
            pnlButtons.Visible = true;
        }


        #endregion

        #region Handlers
        private void WideForm_Load(object sender, EventArgs e)
        {
            this.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);
        }
      


        private void btnCommand_Click(object sender, EventArgs e)
        {
            m_errorProvider.Clear();
            crystalReportViewer1.ReportSource = null;
            crystalReportViewer1.Refresh();
            if (pnlButtons.Visible == true)
            {
                try
                {

                    if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                    {
                        FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                    }
                    else
                    {
                        this.Visible = false;

                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                
            }
            else
               ShowReports();        
        }
        #endregion

        private void btnView_Click(object sender, EventArgs e)
        {
            m_errorProvider.Clear();
            ViewReport();
        }

        private void btnDaily_Click(object sender, EventArgs e)
        {
            NotImplemented();
        }

        private void btnDrawer_Click(object sender, EventArgs e)
        {
            NotImplemented();
        }

   

        private void btnSession_Click(object sender, EventArgs e)
        {
            NotImplemented();
        }

        private void btnVoid_Click(object sender, EventArgs e)
        {
            NotImplemented();
        }

        private void btnOne_MouseEnter(object sender, EventArgs e)
        {
            btnOne.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownOne;
        }

        private void btnOne_MouseLeave(object sender, EventArgs e)
        {
            btnOne.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpOne;
        }

        private void btnTwo_MouseEnter(object sender, EventArgs e)
        {
            btnTwo.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownTwo;
        }

        private void btnTwo_MouseLeave(object sender, EventArgs e)
        {
            btnTwo.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpTwo;
        }

        private void bntThree_MouseEnter(object sender, EventArgs e)
        {
            btnThree.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownThree;
        }

        private void bntThree_MouseLeave(object sender, EventArgs e)
        {
            btnThree.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpThree;
        }

        private void btnFour_MouseEnter(object sender, EventArgs e)
        {
            btnFour.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownFour;
        }

        private void btnFour_MouseLeave(object sender, EventArgs e)
        {
            btnFour.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpFour;
        }

        private void btnFive_MouseEnter(object sender, EventArgs e)
        {
            btnFive.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownFive;
        }

        private void btnFive_MouseLeave(object sender, EventArgs e)
        {
            btnFive.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpFive;
        }

        private void BtnSix_MouseEnter(object sender, EventArgs e)
        {
            btnSix.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownSix;
        }

        private void BtnSix_MouseLeave(object sender, EventArgs e)
        {
            btnSix.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpSix;
        }

        private void btnSeven_MouseEnter(object sender, EventArgs e)
        {
            btnSeven.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownSeven;
        }

        private void btnSeven_MouseLeave(object sender, EventArgs e)
        {
            btnSeven.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpSeven;
        }

        private void btnEight_MouseEnter(object sender, EventArgs e)
        {
            btnEight.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownEight;
        }

        private void btnEight_MouseLeave(object sender, EventArgs e)
        {
            btnEight.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpEight;
        }

        private void btnNine_MouseEnter(object sender, EventArgs e)
        {
            btnNine.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownNine;
        }

        private void btnNine_MouseLeave(object sender, EventArgs e)
        {
            btnNine.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpNine;
        }

        private void btnZeroZero_MouseEnter(object sender, EventArgs e)
        {
            btnZeroZero.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownZeroZero;
        }

        private void btnZeroZero_MouseLeave(object sender, EventArgs e)
        {
            btnZeroZero.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpZeroZero;
        }

        private void btnZero_MouseEnter(object sender, EventArgs e)
        {
            btnZero.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownZero;
        }

        private void btnZero_MouseLeave(object sender, EventArgs e)
        {
            btnZero.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpZero;
        }

        private void BtnPlay_MouseEnter(object sender, EventArgs e)
        {
            btnPlay.BackgroundImage = GameTech.B3Reports.Properties.Resources.DownPlay;
        }

        private void BtnPlay_MouseLeave(object sender, EventArgs e)
        {
            btnPlay.BackgroundImage = GameTech.B3Reports.Properties.Resources.UpPlay;
        }

        private void txt1_Enter(object sender, EventArgs e)
        {
            pickB = false;
            pickA = true;

        }

        private void txt2_Enter(object sender, EventArgs e)
        {
            pickA = false;
            pickB = true;

        }

        private void StoreTextBox(string X)
        {
            if (pickA == true)
            {
                txt1.Text += X;

            }
            else if (pickB == true)
            {
                txt2.Text += X;

            }
        }

        private void btnOne_Click(object sender, EventArgs e)
        {
            string X = "1";
            StoreTextBox(X); 

        }

        private void btnTwo_Click(object sender, EventArgs e)
        {

            string X = "2";
            StoreTextBox(X); 
        }

        private void btnThree_Click(object sender, EventArgs e)
        {
            string X = "3";
            StoreTextBox(X); 
        }


      
        private void btnFour_Click(object sender, EventArgs e)
        {
            string X = "4";
            StoreTextBox(X); 
        }

        private void btnFive_Click(object sender, EventArgs e)
        {
            string X = "5";
            StoreTextBox(X); 
        }

        private void btnSix_Click(object sender, EventArgs e)
        {
            string X = "6";
            StoreTextBox(X); 
        }

        private void btnSeven_Click(object sender, EventArgs e)
        {
            string X = "7";
            StoreTextBox(X); 
        }

        private void btnEight_Click(object sender, EventArgs e)
        {
            string X = "8";
            StoreTextBox(X); 
        }

        private void btnNine_Click(object sender, EventArgs e)
        {
            string X = "9";
            StoreTextBox(X); 
        }

        private void btnZeroZero_Click(object sender, EventArgs e)
        {
            string X = "00";
            StoreTextBox(X); 
        }

        private void btnZero_Click(object sender, EventArgs e)
        {
            string X = "0";
            StoreTextBox(X); 
        }

        private void btnPlay_Click(object sender, EventArgs e)
        {
            int i = 0;
            string y;


            if (pickA == true)//TXT1
            {
                if (txt1.Text.Length >= 1)
                {
                    i = txt1.Text.Length;
                    y = txt1.Text.Substring(0, i - 1);
                    txt1.Text = y;
                }
            }
            else if (pickB == true)
            {
                if (txt2.Text.Length >= 1)
                {
                    i = txt2.Text.Length;
                    y = txt2.Text.Substring(0, i - 1);
                    txt2.Text = y;
                }
            }

        }

        private void btnCardImages_Click(object sender, EventArgs e)
        {
        
            ShowParams(1);
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            pnlKeypad.Visible = true;
            txt1.Clear();
            txt2.Clear();
            pnlParams.Visible = true;

        }
        private void btnDetailTrans_Click(object sender, EventArgs e)
        {
            m_sessionComboBox.Text = "";
            ShowParams(2);
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            pnlKeypad.Visible = false;
        }

        //Ball Call
        private void btnBallCall_Click(object sender, EventArgs e)
        {
      
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            ShowParams(CurrentReport);//5
            pnlParams.Visible = false;


        }

        private void btnAuditLog_Click(object sender, EventArgs e)
        {
            ShowParams(4);
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            pnlKeypad.Visible = false;
        }


        private void btnSessTranDtl_Click(object sender, EventArgs e)
        {
            ShowParams(8);
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            //ShowParams(CurrentReport);//5
            pnlKeypad.Visible = false;
        }

        private void btnUserAccess_Click(object sender, EventArgs e)
        {

            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            ViewReport();
        }


        private void btnRptAccountHistory_Click(object sender, EventArgs e)
        {
            ShowParams(12);
            Button btn = (Button)sender;
            CurrentReport = Convert.ToInt32(btn.Tag);
            pnlKeypad.Visible = false;
        }
 

        private void dtStart_ValueChanged(object sender, EventArgs e)
        {
            DateTimePicker dt = (DateTimePicker)sender;

            if (CurrentReport != 5 /*&& CurrentReport != 6*/)
            {
                m_sessionComboBox.Items.Clear();
                m_sessionComboBox.Text = ""; 
 
                sc.Open();
                SqlCommand cmd = new SqlCommand("exec spRptGetSessionID '" + dt.Value + "'", sc);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    m_sessionComboBox.Items.Add(dr["sessnum"]);   
                }
                dr.Close();
                dr.Dispose();
                sc.Close();


                if (m_sessionComboBox.Items.Count > 0)   
                {
                     m_sessionComboBox.SelectedIndex = 0; 
                }

 
              
            }
            else if (CurrentReport == 5)//BallCall
            {
                if (cmbxBallCallByCategory.SelectedIndex == 1)
                {
                    cmbxBallCallSessionID.Items.Clear();
                    cmbxBallCallSessionID.Text = "";

                    sc.Open();
                    SqlCommand cmd = new SqlCommand("exec spRptGetSessionID '" + dt.Value + "'", sc);
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        cmbxBallCallSessionID.Items.Add(dr["sessnum"]);
                    }
                    dr.Close();
                    dr.Dispose();
                    sc.Close();

                    if (cmbxBallCallSessionID.Items.Count > 0)
                    {
                        cmbxBallCallSessionID.SelectedIndex = 0;
                    }

                }
            }
                
        }

        /// <summary>
        /// Get the account number per session.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void m_sessionComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (CurrentReport == 12)
            {
                cmbxAccountN.Items.Clear();
                cmbxAccountN.Text = "";

                //if (sc.State != ConnectionState.Open)
                //{
                sc.Open();
                //}

                SqlCommand cmd2 = new SqlCommand("exec usp_management_Report_GetAccountNumber " + m_sessionComboBox.SelectedItem , sc);
                  SqlDataReader  dr2 = cmd2.ExecuteReader();

                while (dr2.Read())
                {
                    cmbxAccountN.Items.Add(dr2["creditacctnum"]);
                }


                if (cmbxAccountN.Items.Count > 0)
                {
                    cmbxAccountN.SelectedIndex = 0;
                }

                dr2.Close();
                dr2.Dispose();
                sc.Close();
            }
        }

        private void m_sessionComboBox_Validating(object sender, CancelEventArgs e)
        {
            if (CurrentReport != 7)
            {
                if (m_sessionComboBox.SelectedItem == null)
                {
                    m_errorProvider.SetError(m_sessionComboBox, "Invalid Entry");
                    e.Cancel = true;
                }
            }
        }

        private void LoginFullWin_LocationChanged(object sender, EventArgs e)
        {
            WindowsDefaultLocation.PointA = this.Location.X;
            WindowsDefaultLocation.PointB = this.Location.Y;
        }

        private void WideForm_FormClosed(object sender, FormClosedEventArgs e)
        {
           // Application.Exit();
            m_errorProvider.Clear();
   
                try
                {

                    if (!ActivateForm.NOW("NewMenu"))//check the form if its already loaded 
                    {
                        FireForm.Fire("GameTech.B3Reports.Forms.NewMenu");
                    }
                    else
                    {
                        this.Visible = false;

                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }         
        }

        private void btnUserAccess_KeyPress(object sender, MouseEventArgs e)
        {
            Button x = (Button)sender;
            if (Convert.ToInt32(x.Tag) == 1)
            {
                btnCardImages.BackgroundImage = Properties.Resources.BingoCardReports2;//2;
            }
            else
            if (Convert.ToInt32(x.Tag) == 2)
            {
                btnDetailTrans.BackgroundImage = Properties.Resources.transactionDetailReport2;//2;
            }else
            if (Convert.ToInt32(x.Tag) == 3)
            {
            }
            else
            if (Convert.ToInt32(x.Tag) == 4)
            {
                btnAuditLog.BackgroundImage = Properties.Resources.audit_log_report2;
            }
            else
            if (Convert.ToInt32(x.Tag) == 5)
            {
                btnBallCallClass2.BackgroundImage = Properties.Resources.BalCallReport2;
            }
            else
            if (Convert.ToInt32(x.Tag) == 6)
            {
                btnPayout.BackgroundImage = Properties.Resources.payout_report2;
            }
            else if (Convert.ToInt32(x.Tag) == 7)
            {
                btnUserAccess.BackgroundImage = Properties.Resources.user_access_report2;
            }
            else if (Convert.ToInt32(x.Tag) == 8)
            {
                btnSessTranDtl.BackgroundImage = Properties.Resources.SessionTransactionButtonDown;//2;
                
            }
            else if (Convert.ToInt32(x.Tag) == 9)
            {
                btnSessionSummary.BackgroundImage = Properties.Resources.session_summary_down2;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 10)
            {
                 btnJackpot.BackgroundImage = Properties.Resources.JackpotReport_ButtonDown1;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 11)
            {
                btnWinnersCard.BackgroundImage = Properties.Resources.winning_cards_report_down;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 12)
            {
                btnRptAccountHistory.BackgroundImage = Properties.Resources.account_history_report_down;//2;

            }
        }


        private void btnUserAccess_MouseUp(object sender, MouseEventArgs e)
        {
            Button x = (Button)sender;
            if (Convert.ToInt32(x.Tag) == 1)
            {
                        btnCardImages.BackgroundImage = Properties.Resources.BingoCardReports1;//2;
            }
            else
                if (Convert.ToInt32(x.Tag) == 2)
                {
                              btnDetailTrans.BackgroundImage = Properties.Resources.transactionDetailReport1;//2;
                }
                else
            if (Convert.ToInt32(x.Tag) == 3)
            {
            }
            else
            if (Convert.ToInt32(x.Tag) == 4)
            {
           btnAuditLog.BackgroundImage = Properties.Resources.audit_log_report1;
            }
            else
            if (Convert.ToInt32(x.Tag) == 5)
            {
                btnBallCallClass2.BackgroundImage = Properties.Resources.BalCallReport1;
            }
            else
            if (Convert.ToInt32(x.Tag) == 6)
            {
            btnPayout.BackgroundImage = Properties.Resources.payout_report1;
            }
            else if (Convert.ToInt32(x.Tag) == 7)
            {
                btnUserAccess.BackgroundImage = Properties.Resources.user_access_report1;
            }
            else if (Convert.ToInt32(x.Tag) == 8)
            {
                btnSessTranDtl.BackgroundImage = Properties.Resources.SessionTransaction;//2;

            }
                 else if (Convert.ToInt32(x.Tag) == 9)
            {
                btnSessionSummary.BackgroundImage = Properties.Resources.session_summary1;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 10)
            {
                btnJackpot.BackgroundImage = Properties.Resources.JackpotReport_Normal1;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 11)
            {
                 btnWinnersCard.BackgroundImage = Properties.Resources.winning_cards_report;//2;

            }
            else if (Convert.ToInt32(x.Tag) == 12)
            {
                btnRptAccountHistory.BackgroundImage = Properties.Resources.account_history_report;//2;

            }
        }

        private void btnCommand_MouseDown(object sender, MouseEventArgs e)
        {
            btnCommand.BackgroundImage = Properties.Resources.Reports_Background1;
            //btnCommand.BackColor = Color.Transparent;
        }

        private void btnCommand_MouseUp(object sender, MouseEventArgs e)
        {
            btnCommand.BackgroundImage = Properties.Resources.ReturnButton_Strip;
        }

        private void btnView_MouseDown(object sender, MouseEventArgs e)
        {
            btnView.BackgroundImage = Properties.Resources.ViewReportButton_Strip4;
        }

        private void btnView_MouseUp(object sender, MouseEventArgs e)
        {
            btnView.BackgroundImage = Properties.Resources.ViewReportButton_Strip3;
        }

        private void txt1_Validating(object sender, CancelEventArgs e)
        {
            if (CurrentReport != 7)
            {
                if (txt1.Text == string.Empty || txt1.Text == "0")
                {
                    m_errorProvider.SetError(txt1, "Invalid Entry");
                    e.Cancel = true;
                }
            }
        }

        private void txt2_Validating(object sender, CancelEventArgs e)
        {
            if (CurrentReport != 7)
            {
                if (txt2.Text == string.Empty || txt2.Text == "0")
                {
                    m_errorProvider.SetError(txt2, "Invalid Entry");
                    e.Cancel = true;
                }
            }
        }

        private void txt1_KeyPress(object sender, KeyPressEventArgs e)
        {    
            bool result = true;
            if (e.KeyChar == (char)Keys.Back)
            {
                result = false;

            }
            if (result)
            {
                result = !char.IsDigit(e.KeyChar);
            }

            e.Handled = result;
        }

        private void cmbxBallCallByCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            dtBallCallStartDate.Value = DateTime.Today.Subtract(TimeSpan.FromDays(1));   //added just to change the value 
            dtBallCallStartDate.Value = DateTime.Today;
            dtBallCallEndDate.Value = DateTime.Today;

            if (cmbxBallCallByCategory.SelectedIndex == 0)//Session
            {
                lblBallCallStartDate.Text = "Starting Date:";
                lblBallCallEndDate.Text = "Ending Date:";
                lblBallCallStartDate.Visible = true;
                lblBallCallEndDate.Visible = true;
                dtBallCallEndDate.Visible = true;
                dtBallCallStartDate.Visible = true;
                cmbxBallCallSessionID.Visible = false;

            }
            else
            if(cmbxBallCallByCategory.SelectedIndex == 1)//Game
            {
                lblBallCallStartDate.Text = "Date:";
                lblBallCallEndDate.Text = "SessionID:";
                dtBallCallEndDate.Visible = false;
                dtBallCallStartDate.Visible = true;
                cmbxBallCallSessionID.Visible = true;
                lblBallCallStartDate.Visible = true;
                lblBallCallEndDate.Visible = true;
            }
        }

        private void WideForm_VisibleChanged(object sender, EventArgs e)
        {
            if (this.Visible == true)
            {
                SetViewToDefault();
            }
        }

      
    
    }
}
