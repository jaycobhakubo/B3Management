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

namespace GTI.Controls
{

    public class TextBoxNumeric : TextBox
    {

        public TextBoxNumeric()
        {
            KeyPress += TextBoxNumeric_KeyPress;
            KeyDown += new KeyEventHandler(TextBoxNumeric_KeyDown);
            this.Size = new System.Drawing.Size(125, 26);
        }
        private bool ISBackallowed;

        void TextBoxNumeric_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == 46 || e.KeyValue == 8)
            {
                int index;
                string text;
                index = this.SelectionStart - this.GetFirstCharIndexFromLine(this.GetLineFromCharIndex(this.SelectionStart));

                text = this.Text ?? string.Empty;
                if (this.SelectionLength > 0)
                {
                    text = text.Substring(0, (this.SelectionStart)) + text.Substring(this.SelectionStart + this.SelectionLength);

                }
                else
                    switch (e.KeyValue)
                    {
                        case 46:
                            if ((SelectionStart + 1) <= text.Length)

                                text = text.Substring(0, (this.SelectionStart)) + text.Substring((this.SelectionStart + 1) + this.SelectionLength);

                            break;
                        case 8:
                            if ((SelectionStart - 1) >= 0)
                                text = text.Substring(0, (this.SelectionStart - 1)) + text.Substring(this.SelectionStart + this.SelectionLength);

                            break;
                    }
                ISBackallowed = false;
                if (!ValidateLength(Mask, text, Precision))
                {
                    e.Handled = true;
                    ISBackallowed = true;
                }

                return;
            }
        }


        private void TextBoxNumeric_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            int index;
            string text;

            if ((Char.IsControl(e.KeyChar) == true))
            {
                if (e.KeyChar != 8)
                {
                    e.Handled = true;
                    return;
                }
                else
                    if (ISBackallowed)
                    {
                        e.Handled = true;
                    }

                return;
            }

            string pattern = "^[" + Regex.Escape(NumberFormatInfo.CurrentInfo.PositiveSign + NumberFormatInfo.CurrentInfo.NegativeSign) + "]?";

            switch (Mask)
            {
                case TextBoxType.Decimal:
                    // Match 0 or more digits, optionally follow by a decimal seprator, then optionally more digits.
                    pattern += @"\d*[" + Regex.Escape(NumberFormatInfo.CurrentInfo.CurrencyDecimalSeparator) + Regex.Escape(NumberFormatInfo.CurrentInfo.NumberDecimalSeparator) + @"]?\d";

                    if (Precision > 0)
                        pattern += "{0," + Precision.ToString(CultureInfo.InvariantCulture) + "}$";
                    else
                        pattern += "*$";
                    break;

                default: // Integer
                    pattern += @"\d*$"; // Match 0 or more digits.
                    break;
            }

            index = this.SelectionStart - this.GetFirstCharIndexFromLine(this.GetLineFromCharIndex(this.SelectionStart));

            System.Globalization.NumberFormatInfo numberFormatInfo = System.Globalization.CultureInfo.CurrentCulture.NumberFormat;

            string decimalSeparator = numberFormatInfo.NumberDecimalSeparator;
            string groupSeparator = numberFormatInfo.NumberGroupSeparator;
            // string text = this.Text.Insert(index, e.KeyChar.ToString());

            text = this.Text ?? string.Empty;

            if (this.SelectionLength > 0)
            {
                text = text.Substring(0, this.SelectionStart) + text.Substring(this.SelectionStart + this.SelectionLength);
                index = this.SelectionStart;
                e.Handled = false;
            }
            text = text.Insert(index, e.KeyChar.ToString());
            //this.Text = text;

            if (!Regex.IsMatch(text, pattern, RegexOptions.IgnoreCase))
            {
                // Not a valid match, don't add the text.
                e.Handled = true;
            }
            else if (!ValidateLength(Mask, text, Precision))
            {
                e.Handled = true;
            }
        }
        private const int WM_PASTE = 0x302;
        private const int WM_CUT = 0x0300;
        private const int WM_COPY = 0x0301;
        private const int WM_DELETE = 771;
        private const int WM_UNDO = 772;

        protected override void WndProc(ref Message m)
        {

            if (m.Msg == WM_PASTE || m.Msg == WM_COPY || m.Msg == WM_CUT || m.Msg == WM_DELETE || m.Msg == WM_UNDO)
            {

            }
            else
            {
                base.WndProc(ref m);
            }
        }

        private bool ValidateLength(TextBoxType Type, string value, int precision)
        {
            switch (Type)
            {
                case TextBoxType.Integer:
                    return (value == null || value.Length <= MaxLength);

                case TextBoxType.Decimal:
                    if (value == null)
                        return true;
                    else if (precision == 0)
                        return (value.Length <= MaxLength);
                    else
                    {
                        int separatorLength = System.Globalization.NumberFormatInfo.CurrentInfo.NumberDecimalSeparator.Length;

                        int decPointIndex = value.IndexOf(NumberFormatInfo.CurrentInfo.NumberDecimalSeparator);

                        if (decPointIndex == -1)
                        {
                            decPointIndex = value.IndexOf(NumberFormatInfo.CurrentInfo.CurrencyDecimalSeparator);

                            if (decPointIndex != -1)
                                separatorLength = NumberFormatInfo.CurrentInfo.CurrencyDecimalSeparator.Length;
                        }


                        int fractionalLength = separatorLength + precision;

                        if (decPointIndex == -1)
                            return (value.Length <= MaxLength - fractionalLength);
                        else if (decPointIndex == 0)
                            return true;
                        else
                            return (value.Substring(0, decPointIndex).Length <= MaxLength - fractionalLength);
                    }

                default:
                    return true;
            }

        }

        #region "Properties"
        public object NumericTextBoxValue
        {
            get
            {
                if (_Type == TextBoxType.Integer)
                {
                    return Int32.Parse(this.Text);
                }
                else
                {
                    return Decimal.Parse(this.Text);
                }
            }

        }
        public enum TextBoxType
        {
            Integer,
            Decimal

        }

        private TextBoxType _Type = TextBoxType.Integer;
        public override int MaxLength
        {
            get
            {
                return _MaxLength;
            }
            set
            {
                _MaxLength = value;
            }
        }

        private int _MaxLength;
        public TextBoxType Mask
        {
            get { return _Type; }

            set
            {
                _Type = value;

                if (_Type == TextBoxType.Integer)
                    _MaxLength = 10;
                else
                    _MaxLength = 16;

            }
        }
        public int Precision
        {
            get { return _Precision; }
            set { _Precision = value; }
        }
        private int _Precision = 2;


    }

        #endregion
}

