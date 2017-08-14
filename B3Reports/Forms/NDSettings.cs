using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace GameTech.B3Reports.Forms
{
    public partial class NDSettings : SettingsControl
    {
        //private bool m_SalesMode = false;//Set default
        private int m_PlayerPinLength = 0;//Set default

        public int PlayerPinLength
        {
            get { return m_PlayerPinLength; }
            set { m_PlayerPinLength = value; }
        }

        public NDSettings()
        {
            InitializeComponent();
        }

        public override bool LoadSettings()
        {
            this.SuspendLayout();
            bool bResult = LoadNDSettings();
            this.ResumeLayout(true);
            return bResult;
        }

        private bool LoadNDSettings()
        {
            if (numPlayerPinLenght.Value == m_PlayerPinLength)
            {
                numPlayerPinLenght.Value = m_PlayerPinLength + 1;//Set to 1
            }

            //GetNDSettings NDSettings = new GetNDSettings();
            
            //Assign to member variables.
            //m_PlayerPinLength =  //NDSettings.PlayerPinLength;
                 
            //if (NDSettings.SalesMode)
            //{
            //    m_SalesMode = true;
            //}
            //else
            //{
            //    m_SalesMode = false;
            //}

            //Assign to controls.
            //chkbxNdSalesMode.Checked = m_SalesMode;
            numPlayerPinLenght.Value = m_PlayerPinLength;
            
            return true; //always true
        }

        public override bool SaveSettings()
        {
            Cursor x = Cursors.WaitCursor;  //  Common.BeginWait();        
            bool bResult = SaveNDSettings();
            x = Cursors.Default; // Common.EndWait();
            return bResult;
        }

        private bool SaveNDSettings()
        {
            bool result = true;
            bool IsModified = false;
            
            //Compare the old value to the new value
            //Sales Mode
            //bool NewValue_SalesMode = false;
            //bool OldValue_SalesMode = m_SalesMode;

            //if (chkbxNdSalesMode.Checked == true)
            //{
            //    NewValue_SalesMode = true;
            //}
            //else { NewValue_SalesMode = false; }

            //if (NewValue_SalesMode != OldValue_SalesMode)
            //{
            //    IsModified = true;
            //    WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "North Dakota Sales Mode", OldValue_SalesMode.ToString(), NewValue_SalesMode.ToString());
            //}

            //Player Pin Length
            int NewValue_PlayerPinLength = (int)numPlayerPinLenght.Value;
            int OldValue_PlayerPinLength = m_PlayerPinLength;
            if (NewValue_PlayerPinLength != OldValue_PlayerPinLength)
            {
                IsModified = true;
                WriteLog.WriteLogUpdate("", CurrentUserLoggedIn.username, "UPDATE", GetCurrentMacID.MacAddress, "North Dakota Player Pin Length", OldValue_PlayerPinLength.ToString(), NewValue_PlayerPinLength.ToString());
            }


            //Save it.
            if (IsModified == true)
            {
                //SetNDSettings set = new SetNDSettings();
                //set.SalesMode = NewValue_SalesMode;
                //set.PlayerPinLength = NewValue_PlayerPinLength;
                //set.RunSQL();

                SetSystemConfig set = new SetSystemConfig();
                set.PlayerPinLength = NewValue_PlayerPinLength;
                m_PlayerPinLength = NewValue_PlayerPinLength;
                set.RunSQL();
            }

            return result;
        }

        private void numPlayerPinLenght_Validating(object sender, CancelEventArgs e)
        {
            NumericUpDown NU = (NumericUpDown)sender;

            if (NU.Text == "")
            {
                numPlayerPinLenght.Value = m_PlayerPinLength + 1;//This is how to fix a blank numeric up down controls.
                numPlayerPinLenght.Value = m_PlayerPinLength;
            }
        }

        private void numPlayerPinLenght_Leave(object sender, EventArgs e)
        {
            if (!ValidateChildren(ValidationConstraints.Enabled | ValidationConstraints.Visible))
                return;
        }

    }
}
