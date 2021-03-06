﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace GameTech.B3Reports
{
    class FireForm
    {
        public static void Fire(string strNameSpaceFormName)
        {
            try
            {
                Type type = Type.GetType(strNameSpaceFormName);
                Form form = (Form)Activator.CreateInstance(type);
                form.Show();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
