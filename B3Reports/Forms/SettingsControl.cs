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
    public partial class SettingsControl : UserControl
    {
        protected bool IsEnabled;

        public virtual bool LoadSettings() { return true; }
        public virtual bool SaveSettings() { return true; }
        public virtual void OnActivate(object o) { }

        public virtual bool IsModified { get; protected set; }

        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SettingsControl));
            this.SuspendLayout();
            // 
            // SettingsControl
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.DoubleBuffered = true;
            resources.ApplyResources(this, "$this");
            this.Name = "SettingsControl";
            this.ResumeLayout(false);

        }

        public SettingsControl()
        {
            IsEnabled = true;
        }

        // The following routines were added to avoid Parse() from throwing exceptions for null values
        public bool ParseBool(string s)
        {
            // Try to parse the value
            bool result;
            bool default_value = false;
            if (bool.TryParse(s, out result))
            {
                return result;
            }
            else
            {
                return default_value;
            }
        }

        public DateTime ParseDateTime(string s)
        {
            // Try to parse the value
            DateTime result;
            DateTime default_value = DateTime.Now;
            if (DateTime.TryParse(s, out result))
            {
                return result;
            }
            else
            {
                return default_value;
            }
        }

        public int ParseInt(string s)
        {
            // Try to parse the value
            int result;
            int default_value = 1;
            if (int.TryParse(s, out result))
            {
                return result;
            }
            else
            {
                return default_value;
            }
        }

        public decimal ParseDecimal(string s)
        {
            // Try to parse the value
            decimal result;
            decimal default_value = 1;
            if (decimal.TryParse(s, out result))
            {
                return result;
            }
            else
            {
                return default_value;
            }
        }

        public void EnableControls(bool enable)
        {
            if (enable == IsEnabled)
            {
                return;
            }

            IsEnabled = enable;
            foreach (Control control in Controls)
            {
                control.Enabled = enable;
            }
        }

    }
}
