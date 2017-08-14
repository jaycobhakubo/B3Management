//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;



using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;


namespace GameTech.B3Reports
{
    class AdjustWindowSize
    {
        public static void adjust(Form x)
        {
            Rectangle dsplySize = GetScreen(x);

            int currentDisplayHeight = dsplySize.Size.Height;
            int currentDisplayWidth = dsplySize.Size.Width;
            if (currentDisplayHeight == 768 && currentDisplayWidth == 1024)  //cs200
            {
                x.TopMost = true;
                x.WindowState = FormWindowState.Maximized;
                x.ControlBox = false;
                x.FormBorderStyle = FormBorderStyle.None;

                x.Text = string.Empty;
            }
        }

        public static Rectangle GetScreen(Form x)
        {
            return Screen.FromControl(x).Bounds;
        }
    }
}
