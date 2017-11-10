using System;
using System.Configuration;
using System.Collections.Generic;
using System.Windows.Forms;
using GameTech.B3Reports.Forms;

namespace GameTech.B3Reports
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            if (config.AppSettings.Settings["ScreenFormat"].Value.ToString().ToUpper() == "WIDE")
                Application.Run(new LoginFullWin());              
            else
                Application.Run(new Main());
        }
    }
}