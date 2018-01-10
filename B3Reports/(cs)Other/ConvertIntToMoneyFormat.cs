using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;

namespace GameTech.B3Reports
{
    class ConvertIntToMoneyFormat
    {
        public static string  convert_(int x)
        {
            
            string ReturnValue = "";
            if (x != 0)
            {
                decimal y = (decimal)x / 100;
                int count = BitConverter.GetBytes(decimal.GetBits(y)[3])[2];

                string z = "";
                if (count == 1)
                {
                    z = "0";
                }
                else
                    if (count == 0)
                    {
                        z = ".00";
                    }

                ReturnValue = y.ToString() + z.ToString();
                //string[] b = ReturnValue.Split('.');
                //int c = int.Parse(b[0]);
                //if (c == 0)
                //{
                //    ReturnValue = ReturnValue.Replace("0.", "");
                //    ReturnValue = ReturnValue + "\u00A2";
                //}
                //else
                //{
                    ReturnValue = "$" + ReturnValue;
                //}
            }
            else
            {
                ReturnValue = "0";
            }
          
            return  ReturnValue;
        }

        public static string convertToDecimal(int x)
        {
            string ReturnValue = "";
            if (x != 0)
            {
                decimal y = (decimal)x / 100;
                ReturnValue = Convert.ToString(y);
            }
            return ReturnValue;
        }
    }
}
