using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;


namespace GameTech.B3Reports
{
    class IdleTimeStart
    {
        Timer CheckIdleTimer = new Timer();
        public bool IdleTimerIsReach = false;
        Form y = new Form();

        public void StartTimer(Form x)
        {
            CheckIdleTimer.Start();      
            y = x;
            CheckIdleTimer.Tick += new System.EventHandler(CheckIdleTimer_Tick);
        }

     

        public void IdleTimeStop()
        {
            CheckIdleTimer.Stop();
            CheckIdleTimer.Enabled = false;
        }

           private void CheckIdleTimer_Tick(object sender, EventArgs e)
        {
            //1 min = 60 sec
            //1 sec = 1000
            //1 min = 60000

            int IdleinSec = Convert.ToInt32(GetSecuritySettings.LogoutInactivity) * 60000 ;

            if (Convert.ToInt32(GetSecuritySettings.LogoutInactivity) == 0)
            {
                CheckIdleTimer.Stop();
                CheckIdleTimer.Enabled = false;
            }

            if (Win32.GetIdleTime() >= IdleinSec && Convert.ToInt32(GetSecuritySettings.LogoutInactivity) != 0)
            {

                try
                {
                    FormCollection fc = Application.OpenForms;
                    foreach (Form frm in fc)
                    {

                        if (frm.Name.ToUpper() != "LoginFullWin")
                        {
                            frm.Hide();
                        }
                    }

                    if (!ActivateForm.NOW("LoginFullWin"))//check the form if its already loaded 
                    {
                        FireForm.Fire("GameTech.B3Reports.Forms.LoginFullWin");
                    }

                    WriteLog.WriteLog_("", CurrentUserLoggedIn.username, "Inactivity Logout", GetCurrentMacID.MacAddress, "");

                    IdleTimerIsReach = true;
                    y.Visible = false;
                    y.Hide();


                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }
                IdleTimeStop();
            }
            else { IdleTimerIsReach = false; }
          
        }
       
    }
}
