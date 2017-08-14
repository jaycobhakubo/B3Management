using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameTech.B3Reports
{
    class IsDubbed
    {
        public static bool Dubbed(string N, string BallCall)
        {
            bool result = false;
            BallCall = "," + BallCall +",";
            N = "," +N+ ",";
            result = BallCall.Contains(N.ToString());

            return result;
        }
    }
}
