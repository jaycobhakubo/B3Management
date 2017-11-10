using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Windows.Forms;
using System.Drawing;
using System.Globalization;
using System.Threading;
using System.ComponentModel;
using System.Text.RegularExpressions;


namespace GameTech.B3Reports.CustomControls
{
    class NumericTextBoxWDecimal : TextBox
    {
        bool allowSpace = false;

        // Restricts the entry of characters to digits (including hex), the negative sign,
        // the decimal point, and editing keystrokes (backspace).
        protected override void OnKeyPress(KeyPressEventArgs e)
        {
            base.OnKeyPress(e);

            NumberFormatInfo numberFormatInfo = System.Globalization.CultureInfo.CurrentCulture.NumberFormat;
            string decimalSeparator = numberFormatInfo.NumberDecimalSeparator;
            string groupSeparator = numberFormatInfo.NumberGroupSeparator;
            string negativeSign = numberFormatInfo.NegativeSign;

            string keyInput = e.KeyChar.ToString();

            //Count decimal 
            string x = this.Text;
            int count = x.Split('.').Length - 1;

           // MessageBox.Show("KeyPressed");

            if (Char.IsDigit(e.KeyChar))
            {
                // Digits are OK
            }
            else if ((keyInput.Equals(decimalSeparator) || keyInput.Equals(groupSeparator) ||
             keyInput.Equals(negativeSign)) && count != 1)
            {
                // Decimal separator is OK
            }
            else if (e.KeyChar == '\b')
            {
                // Backspace key is OK
            }
            //    else if ((ModifierKeys & (Keys.Control | Keys.Alt)) != 0)
            //    {
            //     // Let the edit control handle control and alt key combinations
            //    }
            else if (this.allowSpace && e.KeyChar == ' ')
            {

            }
            //else if (sender as TextBox).Text.IndexOf('.') > -1)
            //{

            //}
            // else if (this.Text.IndexOf('.') > -1)
            else if (count == 1)
            {
                e.Handled = true;
            }

            else
            {
                // Swallow this invalid key and beep
                e.Handled = true;
                //    MessageBeep();
            }
        }

        public int IntValue
        {
            get
            {
                return Int32.Parse(this.Text);
            }
        }

        public decimal DecimalValue
        {
            get
            {
                return Decimal.Parse(this.Text);
            }
        }

        public bool AllowSpace
        {
            set
            {
                this.allowSpace = value;
            }

            get
            {
                return this.allowSpace;
            }
        }
    }
}