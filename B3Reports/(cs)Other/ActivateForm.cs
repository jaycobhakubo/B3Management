//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;


namespace GameTech.B3Reports
{
    class ActivateForm
    {

        public static bool NOW(string formName)
        {
            bool IsFormExists = false;
            try
            {
                formName = formName.Trim().ToUpper();
                FormCollection fc = Application.OpenForms;
                foreach (Form frm in fc)
                {

                    if (frm.Name.ToUpper() == formName)
                    {

                        frm.Visible = true;
                        frm.Activate();
                        frm.BringToFront();
                        frm.Location = new Point(WindowsDefaultLocation.PointA, WindowsDefaultLocation.PointB);
                        IsFormExists = true;                                               
                        break;
                       
                    }
                }             
            }
            catch (Exception e) { MessageBox.Show(e.Message); }
            return IsFormExists;
        }

    }
}
