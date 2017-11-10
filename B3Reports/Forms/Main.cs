using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;

namespace GameTech.B3Reports.Forms
{
    public partial class Main : Form
    {
        public int CurrentReport { get; set; }

        public Main()
        {
            InitializeComponent();
            Clear();
        }

        void Clear()
        {
            rptViewer.LocalReport.ReportEmbeddedResource = null;
            pnlParams.Visible = false;
            rptViewer.Visible = false;
            txt1.Visible = false;
            txt2.Visible = false;
            lbl1.Visible = false;
            lbl2.Visible = false;
            txt1.Text = string.Empty;
            txt2.Text = string.Empty;
            lbl1.Text = string.Empty;
            lbl2.Text = string.Empty;
            dtStart.Visible = false;
            dtEnd.Visible = false;
            
        }

        void ShowFields(int id)
        {
            Clear();
            CurrentReport = id;

            switch (id)
            {
                case 1:
                    lbl1.Text = "Starting Card:";
                    lbl2.Text = "Ending Card:";
                    txt1.Visible = true;
                    txt2.Visible = true;
                    break;
                case 2:
                    lbl1.Text = "Starting Date:";
                    lbl2.Text = "Ending Date:";
                    dtStart.Visible = true;
                    dtEnd.Visible = true;
                    dtStart.Value = DateTime.Today;
                    dtEnd.Value = DateTime.Now.AddDays(1);
                    break;
                default:
                    break;
            }

            lbl1.Visible = true;
            lbl2.Visible = true;
            pnlParams.Visible = true;
        }

        private void btnReturn_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnCardImages_Click(object sender, EventArgs e)
        {
            ShowFields(1);
        }

        private void btnDetailTrans_Click(object sender, EventArgs e)
        {
            ShowFields(2);
        }

        private void Main_Load(object sender, EventArgs e)
        {
           
        }

        private void btnView_Click(object sender, EventArgs e)
        {
            ViewReport();
        }

        void ViewReport()
        {
            this.Cursor = Cursors.WaitCursor;
            ReportDataSource rptDataSource = new ReportDataSource();
            pnlParams.Visible = false;
            rptViewer.Visible = true;

            switch (CurrentReport)
            {
                case 1:
                    rptDataSource.Name = "dsCards";
                    rptDataSource.Value = this.rptCardImagesBindingSource;
                    int start = 0, end = 0;
             
                    start = int.Parse(txt1.Text);
                    end = int.Parse(txt2.Text);   
                    rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.CardImages.rdlc";
                    rptCardImagesTableAdapter.Fill(this.cards.rptCardImages, start, end);
                    break;

                case 2:
           
                    rptDataSource.Name = "dsTrans";
                    rptDataSource.Value = this.rptDetailTransBindingSource;
                    rptViewer.LocalReport.ReportEmbeddedResource = "GameTech.B3Reports.Reports.DetailTrans.rdlc";
                    break;

                default:
                    break;
            }

            rptViewer.LocalReport.DataSources.Add(rptDataSource);
            rptViewer.RefreshReport();

            this.Cursor = Cursors.Default;
        }

    }
}
